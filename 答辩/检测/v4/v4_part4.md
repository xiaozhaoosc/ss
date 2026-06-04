3 系统设计

本章详细阐述系统的架构设计。先从整体分层结构入手，明确前后端的职责划分与数据流转方式；再逐一说明登录鉴权、任务流转、专注计时、AI反馈等核心业务模块的设计思路；最后给出数据库表结构设计与缓存策略。

3.1 总体架构设计

总体架构如图3.1所示：

图3.1 总体架构设计

3.1.1 架构分层设计

"小步"系统采用经典的分层架构，各层职责明确。自上而下共四层[11]：

表现层即前端部分，包括移动端应用（家长端与儿童端）与Web管理后台，基于UniApp与Vue 3构建。该层的核心职责是把用户操作转化为HTTP请求，以及把后端返回数据渲染到界面上，不承担任何业务逻辑。

业务逻辑层是后端核心，基于Spring Boot 3构建。任务流转、代币计算、家长与儿童绑定关系管理等所有业务规则都在这一层处理。通过Controller接收请求、Service处理业务、Manager协调，核心计算与校验封装在内，确保异常数据无法进入后续流程。

数据访问层位于业务层与数据库之间，采用MyBatis-Plus框架，单表增删改查无需手写SQL，复杂联查保留手写能力，向上为业务层提供面向对象的查询接口。

基础层包括PostgreSQL数据库、Redis缓存、日志服务与大语言模型API代理。该层不涉及业务逻辑，只负责数据存储、缓存支撑与外部调用的稳定性。

3.1.2 前后端分离协同

"小步"系统采用标准的前后端分离部署架构[12]。前端App与管理后台通过HTTPS向云端Nginx网关发送RESTful API请求。网关作为唯一的对外入口，完成负载均衡与跨域处理后，将请求转发至内网的Spring Boot服务。前后端数据交换统一使用JSON格式，返回结果封装于Result泛型类，包含鉴权状态码与提示信息，方便联调阶段的问题定位。


3.2 核心业务模块设计

3.2.1 用户认证与鉴权模块

系统涉及管理员、家长、儿童三种角色，权限隔离基于Sa-Token实现[13]。

（1）登录认证

前端提交账号密码，后端验证通过后在Redis中创建用户会话上下文，将Token返回前端保存。

（2）双域隔离设计

为防止管理员Token在移动端App中被误用，系统采用Sa-Token的多账号体系（Multi-Account System）架构，将后台管理系统（Admin）的用户中心与移动终端（App）的用户中心在缓存路由层面严格隔离，两套Token互不干扰。

（3）细粒度权限管控

业务接口执行前经过Sa-Token全局拦截器。通过在Controller方法上注入@SaCheckRole("PARENT")与@SaCheckPermission("task:create")等鉴权注解，保证儿童无法创建或删除任务，家长无法跨家庭查看其他儿童的数据，实现角色与组织层的严格互斥。

3.2.2 任务管理与流程设计

任务是系统最核心的业务实体，几乎所有功能模块都围绕它展开。考虑到ADHD儿童在执行过程中的状态变化不确定性较高，任务状态机保留了一定弹性。

任务状态共四种：未开始、执行中（进入番茄钟计时）、已完成（打卡成功）、已废弃（当日未完成且已过期）。

家长创建任务时除基本标题和预计耗时外，还需配置执行周期（单次/每日循环/自定义频率）与完成后的代币奖励数量。复杂任务支持挂载子步骤清单，以便将"写作业"这类大任务拆解为"拿出语文课本""翻到第53页"等可直接执行的小步骤，减轻ADHD儿童面对整体目标时的心理压力。

3.2.3 专注模式与时间管理

专注模块为儿童进入任务后的计时体验提供支撑，不涉及持久层写入操作，优先保证前端运行流畅。

工作流程如下：前端获取待专注任务的ID与参数，儿童点击"开始"后，Pinia状态树切换至"专注锁定态"，倒计时引擎启动。此状态下，全局路由返回操作与底部TabBar切换均被拦截，维持全屏沉浸体验，防止误触导致任务中断。

倒计时自然结束后，前端将完成记录（含持续时长、设备信息等）提交至后端，后端开启事务确认任务完成并同步核算奖励。

若中途主动退出，前端仍会把实际积累的时长传回后端，后端在归档时标记为"非完全完成"。这部分数据对后续AI分析儿童专注耐受阈值与情绪变化趋势有参考价值——设计这个细节的初衷是：即使没有完成，也不能让这段时间数据白白丢失。

3.2.4 智能辅助生成与数据反馈

为减轻家长每日撰写辅导话术的负担，同时使干预更具个性化，系统构建了一条旁路的AI反馈闭环[14]。该模块不阻塞日常业务，由后端定时任务驱动。

运行机制如下：每日固定时段，系统提取某一儿童与家长组合的近十天打卡记录（总完成数、成功率、超时情况、情绪评分等），聚合为结构化的行为摘要JSON。随后将摘要与管理后台预设的Prompt模板拼合，异步发送至大语言模型。返回内容经脱敏处理后入库，次日家长打开应用时，首页展示AI生成的"辅助指引卡片"。家长确认内容合适后，可一键推送至儿童端的"时光机信箱"。

这套流程在设计上留了一条重要的降级路径：当LLM接口不可用时，系统从本地预设话术库中随机取出兜底内容返回，保证家长端界面始终有内容展示，不因外部依赖故障影响用户体验。


3.3 数据库设计

3.3.1 设计原则与总体架构

数据库设计遵循以下几条原则：

高内聚与领域划分。围绕核心业务，数据划分为"用户与档案""任务流转""激励体系""情绪与AI追踪"四大领域，各模块职责清晰、边界明确。

读性能优先。针对儿童端与家长端的高频读取场景，通过适度去范式化与缓存机制减少多表关联查询的性能开销。

灵活扩展。对任务子步骤、用户偏好等非结构化数据，采用PostgreSQL的JSONB类型存储，适应未来业务变化。

数据一致性保障。通过快照字段与流水表设计，确保积分、奖励等关键数据具备可追溯性。

系统整体采用"关系型数据库+缓存层"的双层架构，如图3.2所示：

图3.2 双层架构

3.3.2 概念模型设计（E-R模型）

系统核心库表划分为四大业务域，E-R模型如下各图所示。

用户与档案域（图3.3）：维护系统鉴权基础及儿童独立档案与游戏化属性。

任务流转域（图3.4）：系统的业务中枢，实现从家长任务下发到儿童打卡执行的全生命周期闭环。

激励体系域（图3.5）：负责虚拟积分的发放、核算与心愿奖品兑换流转。

情绪追踪域（图3.6）：专项支持ADHD干预所需的话术动态生成与情绪安抚应对机制。

图3.3 用户与档案

图3.4 任务流转

图3.5 激励体系

图3.6 情绪追踪

用户档案域以sys_user表与ss_child表的一对多映射奠定权限隔离根基；任务流转域通过ss_parent_task主表关联ss_task_log实现细粒度执行追踪；激励体系域围绕ss_parent_reward_redemption奖励兑换记录表确保正向反馈闭环。四大域协同建模，为后续可能的服务拆分提供了清晰的边界参照。

3.3.3 关系型数据库结构详述

以下列出各核心表的关键字段设计：

表3.1 系统用户表 (sys_user)
字段名称	类型	长度	必填	说明
user_id	int8	20	是	用户ID
status	char	1	否	帐号状态（0正常 1停用）
dept_id	int8	20	否	部门ID
user_name	varchar	30	是	用户账号
nick_name	varchar	30	是	用户昵称
user_type	varchar	10	否	用户类型
email	varchar	50	否	用户邮箱
phonenumber	varchar	11	否	手机号码
sex	char	1	否	用户性别（0男 1女 2未知）
password	varchar	100	否	密码
remark	varchar	500	否	备注

表3.2 儿童档案表 (ss_child)
字段名称	类型	长度	必填	说明
id	int8	20	是	主键ID
total_stars	int4	11	否	累计星星
parent_id	int8	20	是	绑定的家长ID
nickname	varchar	64	是	儿童昵称
challenges	jsonb	-	否	挑战进度记录
avatar_config	jsonb	-	否	虚拟形象配置
level	int4	11	否	当前等级
daily_config	jsonb	-	否	个性化每日限制配置
gender	char	1	否	性别
birthday	timestamp	6	否	生日
star_balance	int4	11	否	星星余额

表3.3 家长任务发布表 (ss_parent_task)
字段名称	类型	长度	必填	说明
task_id	int8	20	是	任务ID
user_id	int8	20	否	所属用户ID
title	varchar	100	否	任务标题
description	varchar	500	否	任务描述
prompt_level	int4	11	否	支架强度/辅助强度(1-5)
difficulty	int4	11	否	难度等级(1-5)
reward_points	int4	11	否	奖励积分
status	char	1	否	状态(0进行中 1已完成 2已过期)
cycle_type	int4	11	否	循环类型(0单次 1每日 2每周)
dept_id	int8	20	否	家庭ID(部门ID)
parent_id	int8	20	否	父任务ID(用于任务拆解)

表3.4 任务执行记录表 (ss_task_log)
字段名称	类型	长度	必填	说明
id	int8	20	是	主键ID
target_date	date	-	否	预定执行日期
task_id	int8	20	是	关联的任务定义ID
child_id	int8	20	是	执行儿童ID
finish_time	timestamp	6	否	实际打卡完成时间
status	char	1	否	状态(0:待办 1:进行中 2:已完成)
proof	varchar	500	否	任务证明图片/资料
reward_snap	int4	11	否	实际奖励星星快照
title_snap	varchar	128	否	任务标题快照
actual_duration	int4	11	否	实际专注时长(秒)
dept_id	int8	20	否	家庭ID(部门ID)

表3.5 儿童积分余额表 (ss_child_score)
字段名称	类型	长度	必填	说明
user_id	int8	20	是	用户ID（儿童对应系统登录ID）
balance	int4	11	否	当前余额
total_earned	int4	11	否	累计获得
update_time	timestamp	6	否	更新时间

表3.6 积分流水记录表 (ss_score_history)
字段名称	类型	长度	必填	说明
id	int8	20	是	主键ID
user_id	int8	20	是	关联儿童ID
amount	int4	11	是	变动数值
type	char	1	否	类型(1:获取 2:消费)
source_id	int8	20	否	关联源记录ID（如任务ID）
reason	varchar	255	否	变动事由说明
create_time	timestamp	6	否	流水产生时间

表3.7 家长奖励配置表 (ss_parent_reward)
字段名称	类型	长度	必填	说明
reward_id	int8	20	是	奖励ID
user_id	int8	20	否	所属家长用户ID
name	varchar	100	否	奖励名称
points_required	int4	11	否	所需兑换积分
stock	int4	11	否	库存(-1无限)
icon	varchar	100	否	奖励图标
status	char	1	否	状态(0上架 1下架)
create_by	int8	20	否	创建者
create_time	timestamp	6	否	创建时间
del_flag	char	1	否	删除标志
create_dept	int8	20	否	创建部门

表3.8 奖励兑换记录表 (ss_parent_reward_redemption)
字段名称	类型	长度	必填	说明
redemption_id	int8	20	是	兑换ID
reward_id	int8	20	是	奖励ID
user_id	int8	20	是	发起用户ID(儿童)
points_cost	int4	11	否	消耗积分
status	char	1	否	状态(0:待审批 1:已批准 2:已拒绝)
create_by	int8	20	否	创建者
create_time	timestamp	6	否	申请提交时间
update_by	int8	20	否	更新/审批者
update_time	timestamp	6	否	更新/审批时间
create_dept	int8	20	否	创建部门

表3.9 情绪记录表 (ss_emotion_record)
字段名称	类型	长度	必填	说明
id	int8	20	是	主键ID
tenant_id	varchar	20	否	租户编号
child_id	int8	20	是	关联儿童ID
mood_level	int4	11	否	情绪状态/能效评级
mood_type	varchar	32	否	情绪大类(如开心、愤怒等)
description	varchar	500	否	具体表现文本描述
voice_url	varchar	255	否	声音分析录音URL
parent_feedback	varchar	500	否	家长的应对方式反馈
is_read	char	1	否	状态(是否已查阅)
record_time	timestamp	6	否	情绪记录时间
create_time	timestamp	6	否	入库时间

3.3.4 缓存策略与Redis结构设计

系统中存在几处高频读写场景需要Redis支撑。移动端每次页面切换都需要验证Token有效性，如果每次都回数据库查，在峰值并发下性能会撑不住；同时打卡接口在网络不稳定环境下容易触发重复请求，需要防重机制。

认证缓存：配合Sa-Token，按用户ID建立satoken:login:session:{userId}的Hash对象，存储权限集合与失效时间，免去权限比对时的额外查库消耗。

任务防重提交：利用Redis的TTL机制结合SETNX（Set if Not eXists）原生指令，当儿童端快速连续点击"任务完成"时，拦截第二次请求，防止网络抖动引发的重复代币发放。这个问题在早期测试中确实复现过——网络延迟较大时，儿童会多次点击，导致积分被结算两次，加了这个锁之后就稳定了。


3.4 本章小结

本章对系统的架构设计与核心业务模块进行了系统性阐述：确定了前后端分离的分层架构，给出了鉴权、任务流转、专注计时、AI反馈等关键模块的设计方案，完成了PostgreSQL数据库表结构与Redis缓存策略的设计。这些设计成果为后续的编码实现提供了技术支撑与数据架构基础。
