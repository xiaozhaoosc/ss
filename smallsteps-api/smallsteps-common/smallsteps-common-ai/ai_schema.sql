-- AI 供应商表
CREATE TABLE `sys_ai_provider` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '供应商名称',
  `type` varchar(50) NOT NULL COMMENT '类型(openai/azure)',
  `base_url` varchar(255) DEFAULT NULL COMMENT 'API地址',
  `api_key` varchar(500) DEFAULT NULL COMMENT 'API密钥(加密)',
  `weight` int(11) DEFAULT '100' COMMENT '权重',
  `status` char(1) DEFAULT '0' COMMENT '状态(0正常 1停用)',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志(0代表存在 2代表删除)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI供应商配置表';

-- AI 模型表
CREATE TABLE `sys_ai_model` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `provider_id` bigint(20) NOT NULL COMMENT '供应商ID',
  `model_code` varchar(100) NOT NULL COMMENT 'API调用代码',
  `name` varchar(100) NOT NULL COMMENT '显示名称',
  `cost_input` decimal(10,6) DEFAULT '0.000000' COMMENT '输入价格(元/1M)',
  `cost_output` decimal(10,6) DEFAULT '0.000000' COMMENT '输出价格(元/1M)',
  `context_window` int(11) DEFAULT '0' COMMENT '上下文窗口',
  `is_free_tier` char(1) DEFAULT '0' COMMENT '是否免费模型(0否 1是)',
  `status` char(1) DEFAULT '0' COMMENT '状态',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志(0代表存在 2代表删除)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI模型配置表';

-- AI 路由策略表
CREATE TABLE `sys_ai_route` (
  `scene_key` varchar(50) NOT NULL COMMENT '业务场景',
  `strategy` varchar(50) NOT NULL DEFAULT 'PRIORITY_LEVEL' COMMENT '路由策略',
  `default_model_id` bigint(20) DEFAULT NULL COMMENT '默认模型ID',
  `config_json` json DEFAULT NULL COMMENT '扩展配置',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`scene_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI路由策略表';
