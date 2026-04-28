-- 创建任务模板表
CREATE TABLE IF NOT EXISTS ss_task_template (
    template_id BIGSERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    icon VARCHAR(100),
    category VARCHAR(50),
    target_age_min INT,
    target_age_max INT,
    default_difficulty INT DEFAULT 1,
    default_prompt_level INT DEFAULT 1,
    light_effect VARCHAR(100),
    audio_effect VARCHAR(100),
    intervention_theory TEXT,
    status CHAR(1) DEFAULT '0',
    del_flag CHAR(1) DEFAULT '0',
    create_by VARCHAR(64),
    create_time TIMESTAMP,
    update_by VARCHAR(64),
    update_time TIMESTAMP,
    remark VARCHAR(500)
);

-- 创建任务步骤模板表
CREATE TABLE IF NOT EXISTS ss_task_step_template (
    step_id BIGSERIAL PRIMARY KEY,
    template_id BIGINT NOT NULL,
    step_order INT NOT NULL,
    content TEXT NOT NULL,
    visual_hint VARCHAR(200),
    audio_hint VARCHAR(200),
    expected_duration INT,
    create_by VARCHAR(64),
    create_time TIMESTAMP,
    update_by VARCHAR(64),
    update_time TIMESTAMP
);

-- 清理旧数据 (可选)
TRUNCATE TABLE ss_task_template CASCADE;
TRUNCATE TABLE ss_task_step_template CASCADE;

-- 插入模板数据
INSERT INTO ss_task_template (template_id, title, category, default_difficulty, icon, description, intervention_theory) VALUES
(1, '早起洗漱 (ADHD版)', 'Life', 1, 'brush', '将早起洗漱拆解为微小动作，减少阻力。', '动作提示法：将复杂链条拆解为单一指令。'),
(2, '书包整理 (防遗漏)', 'Study', 2, 'inventory', '使用“三步检查法”确保不漏带课本。', '自述法：通过大声朗读清单强化记忆。'),
(3, '15分钟专注阅读', 'Study', 3, 'book', '结合番茄钟技术的专注练习。', '时间知觉训练：通过视觉进度条量化时间。'),
(4, '房间“5分钟闪电清理”', 'Life', 2, 'cleaning_services', '限时清理，只关注地面物品。', '游戏化动力：将家务转化为限时挑战。'),
(5, '睡前准备仪式', 'Life', 1, 'bedtime', '平复情绪，建立稳定的睡眠预期。', '环境暗示：通过灯光与声音降低觉醒水平。'),
(6, '自主写作业 (拆解版)', 'Study', 4, 'edit_note', '先做简单的，再做难的，中间休息。', '成功体验优先：通过早期正反馈提升持久力。'),
(7, '穿衣大挑战', 'Life', 1, 'checkroom', '按顺序摆放衣服，一步步穿好。', '空间导航：通过物理定位减少认知干扰。'),
(8, '餐后整理', 'Life', 2, 'restaurant', '送回餐具，擦拭桌面。', '习惯锚点：将餐后行为与特定信号挂钩。'),
(9, '社交技能：打招呼', 'Social', 2, 'groups', '练习眼神交流和清晰的问候。', '社交故事：模拟真实场景，降低社交焦虑。'),
(10, '情绪调节：深呼吸', 'Social', 1, 'wind', '当感到愤怒时，练习3次深呼吸。', '生理反馈：通过呼吸调整植物神经系统。');

-- 插入步骤数据
INSERT INTO ss_task_step_template (template_id, step_order, content) VALUES
(1, 1, '掀开被子坐起来'),
(1, 2, '走进洗手间'),
(1, 3, '挤好牙膏并刷牙'),
(2, 1, '打开课程表并确认科目'),
(2, 2, '检查每本书是否在包里'),
(2, 3, '合上拉链，挂好书包'),
(3, 1, '选择一本你想读的书'),
(3, 2, '设定15分钟倒计时'),
(3, 3, '大声朗读一段你喜欢的话');
