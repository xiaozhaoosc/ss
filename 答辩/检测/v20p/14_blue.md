# Extracted 61 blue spans from 14论文.md

--- Fragment 1 ---
随着AI的发展可以借助数字化手段实施辅助干预，为认知减负、亲子协同交互及动态激励等环节等方面，设计并实现了一套面向ADHD中小学生的行为习惯养成综合辅助系统——“小步（Small Steps）”。

--- Fragment 2 ---
系统采用主流的前后端分离架构，通过儿童端、家长端和管理后台的三端协同，构建涵盖渐进式任务拆解、多模态激励与情绪追踪的数字化干预闭环。

--- Fragment 3 ---
技术层面，基于个人情况，后端采用Spring Boot 3与MyBatis-Plus搭建，选用Sa-Token实现多角色鉴权，使用Postgres与Redis做数据处理；

--- Fragment 4 ---
移动端利用UniApp与Vue 3实现双模式动态切换。

--- Fragment 5 ---
系统的核心创新在于集成大语言模型（LLM），通过分析儿童行为数据动态输出个性化寄语与激励建议，缓解执行疲劳，并引导家长从“检查者”转向“陪伴者”,为ADHD日常数字辅助干预提供一种新的选择。

--- Fragment 6 ---
Abstract: 	Attention deficit hyperactivity disorder (ADHD), characterized by difficulties in sustaining attention, hyperactivity, and impulsivity, is a fairly common neurodevelopmental condition among school-age children.

--- Fragment 7 ---
Mainstream medication requires long-term use and may have some impact on physical development, while supplementary offline behavioral interventions often leave both parents and children exhausted amid busy school schedules.

--- Fragment 8 ---
With the growth of AI, digital tools can offer a form of assisted intervention, and in response to needs like cognitive offloading, parent-child coordination, and dynamic motivation, we designed and built a comprehensive habit-formation support system for elementary and middle school students with ADHD—called "Small Steps.

--- Fragment 9 ---
" The system follows a typical front-end/back-end separation architecture.

--- Fragment 10 ---
It brings together a child app, a parent app, and an admin backend to create a digital intervention loop covering gradual task breakdown, multimodal rewards, and mood tracking.

--- Fragment 11 ---
On the technical side, based on personal familiarity, the backend was put together with Spring Boot 3 and MyBatis-Plus, using Sa-Token to handle multi-role authentication and Postgres plus Redis for data stuff.

--- Fragment 12 ---
The mobile end uses UniApp with Vue 3 to switch between two display modes.

--- Fragment 13 ---
为防止后台管理员 Token 在移动端 App 误用，系统采用 Sa-Token 的多账号体系（Multi-Account System）架构，将后台管理系统（Admin）的用户中心与移动终端（App）的用户中心在缓存路由中严格隔离。

--- Fragment 14 ---
数据库是系统业务逻辑落地的核心载体，其设计直接决定系统的数据一致性、扩展性与运行性能。

--- Fragment 15 ---
针对ADHD儿童行为干预场景的特殊性，本系统在数据库设计中不仅关注传统业务数据建模，同时引入游戏化激励、任务拆解以及情绪追踪等扩展维度，以支撑系统的长期行为引导能力。

--- Fragment 16 ---
通过从业务需求描述对象中剥离实体与映射关联，抽取出本系统的四类主要实体构建了 E-R（Entity-Relationship）在数据库设计过程中，系统遵循以下核心原则：

--- Fragment 17 ---
高内聚与领域划分原则 围绕系统核心业务，将数据划分为“用户与档案”、“任务流转”、“激励体系”与“情绪与AI追踪”四大领域，保证各模块职责清晰、边界明确。

--- Fragment 18 ---
读性能优先原则 针对儿童端与家长端的高频读取场景，通过适度去范式化设计与缓存机制，减少多表关联查询带来的性能开销。

--- Fragment 19 ---
灵活扩展原则 对于任务子步骤、用户偏好等非结构化数据，采用 PostgreSQL 的 JSONB 类型存储，以适应未来业务变化。

--- Fragment 20 ---
数据一致性保障原则 通过快照字段与流水表设计，确保积分、奖励等关键数据具备可追溯性与审计能力。

--- Fragment 21 ---
系统整体采用“关系型数据库 + 缓存层”的双层架构，其结构如下：

--- Fragment 22 ---
为了更直观地展现系统的底层架构，本节采用包含实体主要属性的 E-R 模型，将系统的核心库表划分为四大业务域进行展示。

--- Fragment 23 ---
用户与档案域，如 图 3.3：负责维护系统鉴权基础以及儿童的独立档案和游戏化属性。

--- Fragment 24 ---
任务流转域，如 图 3.4：为系统的业务中枢，实现了从家长任务下发到儿童实际打卡执行的全生命周期闭环。

--- Fragment 25 ---
激励体系域，如 图 3.5：负责系统内虚拟资产（积分）的发放、核算以及与心愿奖品的最终兑换流转。

--- Fragment 26 ---
情绪追踪域，如 图 3.6：专项支持 ADHD 治疗中所需的话术动态生成及情绪安抚应对机制。

--- Fragment 27 ---
具体而言，用户档案域以 sys_user 表与 ss_child 表的一对多映射奠定权限隔离根基；

--- Fragment 28 ---
任务流转域通过 ss_parent_task 主表关联 ss_task_log 实现细粒度执行追踪；

--- Fragment 29 ---
激励体系域则围绕 ss_parent_reward_redemption 奖励兑换记录表确保有正反馈。

--- Fragment 30 ---
四大域协同建模为后续高内聚微服务拆分提供了清晰的边界参照。

--- Fragment 31 ---
本章为论文的核心工程实践部分。

--- Fragment 32 ---
在之前完成的需求规划与架构设计蓝图引导下，本章将深入 smallsteps-api（后端层）、smallsteps-app（移动端层）以及 smallsteps-ui（管理中台层）三大工程子库的代码腹地。

--- Fragment 33 ---
结合核心代码片段、关键组件配置及接口设计标准，详尽展示系统从抽象逻辑到具体二进制可执行程序的演化过程。

--- Fragment 34 ---
后端工程基于 Spring Boot 3 标准的 Maven 多模块体系构建，分为 API 定义、Service 业务逻辑、以及统一的配置管理中心，承载了整个家庭智能干预系统的计算中枢任务。

--- Fragment 35 ---
在用户进行登录请求时，系统调用 SysUserServiceImpl 层的验证逻辑。

--- Fragment 36 ---
相比于传统的 JWT 手动拼接，系统引入了 Sa-Token 处理登录态。

--- Fragment 37 ---
当验证通过后，直接调用 StpUtil.

--- Fragment 38 ---
login(user.

--- Fragment 39 ---
getId())。

--- Fragment 40 ---
这一简单接口的背后，框架自动向 Redis 缓存写入了当前用户的登录状态与过期时间戳，并在 HTTP Response Header 中自动下发以 satoken 为索引的凭据标识。

--- Fragment 41 ---
为了保障核心业务接口不被未授权访问，后端实现了一个实现了 WebMvcConfigurer 接口的配置类。

--- Fragment 42 ---
在此类中注册了 Sa-Token 的拦截器 SaInterceptor：

--- Fragment 43 ---
此机制保证了除公开登录注册接口外，所有带有 /ssapi/ 前缀的请求在触达 Controller 的业务逻辑前，都必须经过底层 Redis 中上下文 Token 的比对，有效实现了第一层鉴权。

--- Fragment 44 ---
针对平台的海量活动分析（如每日使用该 App 的打卡总次数监控），使用流行的轻量前端库 ECharts 配合 Element Plus 的组件系统。

--- Fragment 45 ---
开发者构建了一套涵盖最近30天的柱状、平滑折线统计图。

--- Fragment 46 ---
每次数据更新时，组件内利用 Vue 3 的监听器（Watcher）捕捉 API 返回的新时序 JSON 数据集，并在 ECharts 图表对象内触发 setOption() 方法实现图表的丝滑重绘与渲染，辅助技术和研究人员高效掌握应用使用规律。

--- Fragment 47 ---
本章由内至外深入演示了整个系统的重磅技术实践步骤。

--- Fragment 48 ---
在后端，分析了 Spring Boot 结合 MyBatis-Plus 保证数据库的一致性并展示了 AI 聚合链路的具体写法及防降级策略。

--- Fragment 49 ---
在最体现产品灵魂的移动前端方面，说明了选用 UniApp 与 Pinia 配合实现秒级角色切换与数据持久同步的方案，并阐述了利用原子类 CSS (TailwindCSS) 大幅提升组件适配率以及专注模式对意外中断的拦截处理机制。

--- Fragment 50 ---
最后简述了用以承载管理员运维诉求的独立后端终端。

--- Fragment 51 ---
经过本章开发逻辑与部分源码级讲解的沉淀，整个具备双端智能闭环控制的 ADHD 辅助治疗数字结构已经完全成文可见。

--- Fragment 52 ---
任何软件工程项目在正式进入生产环境（Production Environment）并交付给终端用户之前，都必须经历详尽而严苛的测试。

--- Fragment 53 ---
对于“小步”系统而言，由于其目标群体的特殊性（儿童）及数据的高隐私敏感度，系统的稳定性、安全性和交互防错能力显得尤为重要。

--- Fragment 54 ---
本章将详细描述系统的测试环境搭建、从核心功能逻辑到性能抗压的多维度测试方案及其实际运行结果分析。

--- Fragment 55 ---
在整个研究与开发流程中，完成了以下核心工作：

--- Fragment 56 ---
主导了全局纯粹无压力的 UI 交互哲学。

--- Fragment 57 ---
放弃了威慑感，改由通过游戏化代币的正向奖励与大模型的话术安抚来完成闭环干预的设计。

--- Fragment 58 ---
现代化重构架构体系搭建：完全摒弃了传统的单体结构。

--- Fragment 59 ---
后端利用 Spring Boot 3、MyBatis-Plus 的高效生态组建了业务枢纽，利用 Sa-Token 完成了灵活的权限防线；

--- Fragment 60 ---
前端基于 UniApp 3.0 实现多端全覆盖布局，引入 Vue 3 的 Composition API 和 Pinia 实现极致渲染效能及跨栏状态管理。

--- Fragment 61 ---
AI 赋能业务新范式：不仅完成基础的信息交互，更是尝试在后端逻辑定时接入并研判 LLM 智能接口，让原本机械死板的软件代码具备了类似“驻场儿童心理咨询师”般的同理心反馈视角，极大程度释放了家长的心智负担。

