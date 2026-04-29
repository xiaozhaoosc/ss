package com.kenzhao.smallsteps.common.core.constant;

/**
 * 缓存的key 常量
 *
 * @author 赵轩
 */
public interface CacheConstants {

    /**
     * 在线用户 redis key
     */
    String ONLINE_TOKEN_KEY = "online_tokens:";

    /**
     * 参数管理 cache key
     */
    String SYS_CONFIG_KEY = "sys_config:";

    /**
     * 字典管理 cache key
     */
    String SYS_DICT_KEY = "sys_dict:";

    /**
     * 登录账户密码错误次数 redis key
     */
    String PWD_ERR_CNT_KEY = "pwd_err_cnt:";

    /**
     * AI 路由配置 cache key
     */
    String AI_ROUTE_KEY = "ai:route:";

    /**
     * AI 模型配置 cache key
     */
    String AI_MODEL_KEY = "ai:model:";

}
