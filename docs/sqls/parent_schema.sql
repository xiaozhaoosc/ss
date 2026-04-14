-- 1. 家长任务表
CREATE TABLE IF NOT EXISTS ss_parent_task (
  task_id           bigint          NOT NULL,
  dept_id           bigint          DEFAULT NULL,
  parent_id         bigint          DEFAULT NULL,
  user_id           bigint          DEFAULT NULL,
  title             varchar(100)    DEFAULT '',
  description       varchar(500)    DEFAULT '',
  icon              varchar(100)    DEFAULT '',
  difficulty        integer         DEFAULT 1,
  prompt_level      integer         DEFAULT 1,
  cycle_type        integer         DEFAULT 0,
  reward_points     integer         DEFAULT 10,
  light_effect      varchar(100)    DEFAULT '',
  audio_effect      varchar(100)    DEFAULT '',
  deadline          timestamp       DEFAULT NULL,
  status            char(1)         DEFAULT '0',
  del_flag          char(1)         DEFAULT '0',
  create_dept       bigint          DEFAULT NULL,
  create_by         bigint          DEFAULT NULL,
  create_time       timestamp       DEFAULT NULL,
  update_by         bigint          DEFAULT NULL,
  update_time       timestamp       DEFAULT NULL,
  PRIMARY KEY (task_id)
);
COMMENT ON TABLE ss_parent_task IS '家长任务发布表';
COMMENT ON COLUMN ss_parent_task.task_id IS '任务ID';
COMMENT ON COLUMN ss_parent_task.dept_id IS '家庭ID(部门ID)';
COMMENT ON COLUMN ss_parent_task.parent_id IS '父任务ID(用于任务拆解)';
COMMENT ON COLUMN ss_parent_task.user_id IS '所属用户ID';
COMMENT ON COLUMN ss_parent_task.title IS '任务标题';
COMMENT ON COLUMN ss_parent_task.description IS '任务描述';
COMMENT ON COLUMN ss_parent_task.icon IS '图标';
COMMENT ON COLUMN ss_parent_task.difficulty IS '难度等级(1-5)';
COMMENT ON COLUMN ss_parent_task.prompt_level IS '支架强度/辅助强度(1-5)';
COMMENT ON COLUMN ss_parent_task.cycle_type IS '循环类型(0单次 1每日 2每周)';
COMMENT ON COLUMN ss_parent_task.reward_points IS '奖励积分';
COMMENT ON COLUMN ss_parent_task.light_effect IS '灯光效果代码';
COMMENT ON COLUMN ss_parent_task.audio_effect IS '音频索引代码';
COMMENT ON COLUMN ss_parent_task.deadline IS '截止时间';
COMMENT ON COLUMN ss_parent_task.status IS '状态(0进行中 1已完成 2已过期)';
COMMENT ON COLUMN ss_parent_task.create_dept IS '创建部门';
COMMENT ON COLUMN ss_parent_task.create_by IS '创建者';
COMMENT ON COLUMN ss_parent_task.create_time IS '创建时间';
COMMENT ON COLUMN ss_parent_task.update_by IS '更新者';
COMMENT ON COLUMN ss_parent_task.update_time IS '更新时间';
COMMENT ON COLUMN ss_parent_task.del_flag IS '删除标志(0代表存在 2代表删除)';

-- 2. 家长奖励表
CREATE TABLE IF NOT EXISTS ss_parent_reward (
  reward_id         bigint          NOT NULL,
  user_id           bigint          DEFAULT NULL,
  name              varchar(100)    DEFAULT '',
  points_required   integer         DEFAULT 100,
  stock             integer         DEFAULT -1,
  icon              varchar(100)    DEFAULT '',
  status            char(1)         DEFAULT '0',
  create_by         bigint          DEFAULT NULL,
  create_time       timestamp       DEFAULT NULL,
  update_by         bigint          DEFAULT NULL,
  update_time       timestamp       DEFAULT NULL,
  del_flag          char(1)         DEFAULT '0',
  PRIMARY KEY (reward_id)
);
COMMENT ON TABLE ss_parent_reward IS '家长奖励配置表';
COMMENT ON COLUMN ss_parent_reward.reward_id IS '奖励ID';
COMMENT ON COLUMN ss_parent_reward.user_id IS '所属用户ID';
COMMENT ON COLUMN ss_parent_reward.name IS '奖励名称';
COMMENT ON COLUMN ss_parent_reward.points_required IS '所需积分';
COMMENT ON COLUMN ss_parent_reward.stock IS '库存(-1无限)';
COMMENT ON COLUMN ss_parent_reward.icon IS '图标';
COMMENT ON COLUMN ss_parent_reward.status IS '状态(0上架 1下架)';
COMMENT ON COLUMN ss_parent_reward.create_by IS '创建者';
COMMENT ON COLUMN ss_parent_reward.create_time IS '创建时间';
COMMENT ON COLUMN ss_parent_reward.update_by IS '更新者';
COMMENT ON COLUMN ss_parent_reward.update_time IS '更新时间';
COMMENT ON COLUMN ss_parent_reward.del_flag IS '删除标志(0代表存在 2代表删除)';

-- 3. 亲子契约表
CREATE TABLE IF NOT EXISTS ss_parent_contract (
  contract_id       bigint          NOT NULL,
  ss_parent_id         bigint          NOT NULL,
  child_id          bigint          NOT NULL,
  content           text,
  signature_img     varchar(500)    DEFAULT '',
  status            char(1)         DEFAULT '0',
  create_by         bigint          DEFAULT NULL,
  create_time       timestamp       DEFAULT NULL,
  update_by         bigint          DEFAULT NULL,
  update_time       timestamp       DEFAULT NULL,
  del_flag          char(1)         DEFAULT '0',
  PRIMARY KEY (contract_id)
);
COMMENT ON TABLE ss_parent_contract IS '亲子契约表';
COMMENT ON COLUMN ss_parent_contract.contract_id IS '契约ID';
COMMENT ON COLUMN ss_parent_contract.ss_parent_id IS '家长ID';
COMMENT ON COLUMN ss_parent_contract.child_id IS '孩子ID';
COMMENT ON COLUMN ss_parent_contract.content IS '契约内容';
COMMENT ON COLUMN ss_parent_contract.signature_img IS '签名图片';
COMMENT ON COLUMN ss_parent_contract.status IS '状态(0生效中 1已失效)';
COMMENT ON COLUMN ss_parent_contract.create_by IS '创建者';
COMMENT ON COLUMN ss_parent_contract.create_time IS '创建时间';
COMMENT ON COLUMN ss_parent_contract.update_by IS '更新者';
COMMENT ON COLUMN ss_parent_contract.update_time IS '更新时间';
COMMENT ON COLUMN ss_parent_contract.del_flag IS '删除标志(0代表存在 2代表删除)';

