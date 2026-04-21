# 最新生成的全字段 E-R 模型图

根据您提供的 9 张核心表（包含所有系统字段及审计字段）的详尽数据字典，以下是重新生成的完整 Mermaid E-R 模型图。为了便于在 Markdown 中直观查阅，前两大核心业务域仍采用左右并排的横向显示布局。

<table>
<tr>
<td valign="top" width="50%">

### （1）用户与档案域
该域负责维护系统鉴权基础以及儿童的独立档案和游戏化属性。

```mermaid
erDiagram
    sys_user {
        int8 user_id PK "用户ID"
        varchar tenant_id "租户编号"
        int8 dept_id "部门ID"
        varchar user_name "用户账号"
        varchar nick_name "用户昵称"
        varchar user_type "用户类型（sys_user系统用户）"
        varchar email "用户邮箱"
        varchar phonenumber "手机号码"
        char sex "用户性别（0男 1女 2未知）"
        int8 avatar "头像地址"
        varchar password "密码"
        char status "帐号状态（0正常 1停用）"
        char del_flag "删除标志（0代表存在 1代表删除）"
        varchar login_ip "最后登陆IP"
        timestamp login_date "最后登陆时间"
        int8 create_dept "创建部门"
        int8 create_by "创建者"
        timestamp create_time "创建时间"
        int8 update_by "更新者"
        timestamp update_time "更新时间"
        varchar remark "备注"
    }
    
    ss_child {
        int8 id PK "主键ID"
        varchar tenant_id "租户编号"
        int8 parent_id FK "绑定的家长ID"
        varchar nickname "儿童昵称"
        varchar avatar_url "头像地址"
        jsonb avatar_config "虚拟形象配置"
        int4 level "当前等级"
        jsonb daily_config "个性化每日限制配置"
        char gender "性别"
        timestamp birthday "生日"
        int4 star_balance "星星余额"
        int4 total_stars "累计星星"
        jsonb challenges "挑战进度记录"
        int8 create_dept "创建部门"
        int8 create_by "创建者"
        timestamp create_time "创建时间"
        int8 update_by "更新者"
        timestamp update_time "更新时间"
        varchar remark "备注"
        char del_flag "删除标志"
    }

    sys_user ||--o{ ss_child : "监护绑定(parent_id)"
```

</td>
<td valign="top" width="50%">

### （2）任务流转域
该域为系统的业务中枢，实现了从家长任务下发到儿童实际打卡执行的全生命周期闭环。

```mermaid
erDiagram
    ss_parent_task {
        int8 task_id PK "任务ID"
        int8 user_id FK "所属用户ID"
        varchar title "任务标题"
        varchar description "任务描述"
        varchar icon "图标"
        int4 difficulty "难度等级(1-5)"
        int4 reward_points "奖励积分"
        char status "状态(0进行中 1已完成 2已过期)"
        int8 create_by "创建者"
        timestamp create_time "创建时间"
        int8 update_by "更新者"
        timestamp update_time "更新时间"
        char del_flag "删除标志(0代表存在 2代表删除)"
        int8 dept_id "家庭ID(部门ID)"
        int8 parent_id "父任务ID(用于任务拆解)"
        int4 prompt_level "支架强度/辅助强度(1-5)"
        int4 cycle_type "循环类型(0单次 1每日 2每周)"
        varchar light_effect "灯光效果代码"
        varchar audio_effect "音频索引代码"
        timestamp deadline "截止时间"
        int8 create_dept "创建部门"
    }
    
    ss_task_log {
        int8 id PK "主键ID"
        varchar tenant_id "租户编号"
        int8 task_id FK "关联的任务定义ID"
        int8 child_id FK "执行儿童ID"
        timestamp finish_time "实际打卡完成时间"
        char status "状态(0:待办, 1:进行中, 2:已完成)"
        varchar proof "任务证明图片/资料"
        int4 reward_snap "实际奖励星星快照"
        varchar title_snap "任务标题快照"
        timestamp create_time "创建时间"
        int8 dept_id "家庭ID(部门ID)"
        date target_date "预定执行日期"
        int4 actual_duration "实际专注时长(秒)"
        timestamp start_time "专注开始时间"
        timestamp end_time "专注结束时间"
        char del_flag "删除标志(0代表存在 2代表删除)"
        int8 create_dept "创建部门"
        int8 create_by "创建者"
        int8 update_by "更新者"
        timestamp update_time "更新时间"
    }

    ss_parent_task ||--o{ ss_task_log : "实例化执行(task_id)"
```

</td>
</tr>
</table>

### （3）激励体系域
负责系统内虚拟资产（积分）的发放、核算以及与心愿奖品的最终兑换流转。

```mermaid
erDiagram
    ss_child_score {
        int8 user_id PK "用户ID（儿童的对应系统登录ID）"
        int4 balance "当前余额"
        int4 total_earned "累计获得"
        timestamp update_time "更新时间"
    }
    
    ss_score_history {
        int8 id PK "流水ID"
        int8 user_id FK "关联儿童ID"
        int4 amount "变动数值"
        char type "类型(1:获取 2:消费)"
        int8 source_id "关联源记录ID（如任务ID）"
        varchar reason "变动事由说明"
        timestamp create_time "流水产生时间"
    }
    
    ss_parent_reward {
        int8 reward_id PK "奖励ID"
        int8 user_id FK "所属家长用户ID"
        varchar name "奖励名称"
        int4 points_required "所需兑换积分"
        int4 stock "库存(-1无限)"
        varchar icon "奖励图标"
        char status "状态(0上架 1下架)"
        int8 create_by "创建者"
        timestamp create_time "创建时间"
        int8 update_by "更新者"
        timestamp update_time "更新时间"
        char del_flag "删除标志(0代表存在 2代表删除)"
        int8 create_dept "创建部门"
    }
    
    ss_parent_reward_redemption {
        int8 redemption_id PK "兑换ID"
        int8 reward_id FK "奖励ID"
        int8 user_id FK "发起用户ID(儿童)"
        int4 points_cost "消耗积分"
        char status "状态(0:待审批 1:已批准 2:已拒绝)"
        int8 create_by "创建者"
        timestamp create_time "申请提交时间"
        int8 update_by "更新/审批者"
        timestamp update_time "更新/审批时间"
        int8 create_dept "创建部门"
    }

    ss_child_score ||--o{ ss_score_history : "产生财务流水(user_id)"
    ss_parent_reward ||--o{ ss_parent_reward_redemption : "对应心愿奖品(reward_id)"
```

### （4）情绪追踪辅助域
专项支持 ADHD 治疗中所需的话术动态生成及情绪安抚应对机制。

```mermaid
erDiagram
    ss_emotion_record {
        int8 id PK "主键ID"
        varchar tenant_id "租户编号"
        int8 child_id FK "关联儿童ID"
        int4 mood_level "情绪状态/能效评级"
        varchar mood_type "情绪大类(如开心、愤怒等)"
        varchar description "具体表现文本描述"
        varchar voice_url "声音分析录音URL"
        varchar parent_feedback "家长的应对方式反馈"
        char is_read "状态(是否已查阅)"
        timestamp record_time "情绪记录时间"
        timestamp create_time "入库时间"
    }
```