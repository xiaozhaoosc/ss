package com.kenzhao.smallsteps.common.satoken.config;

import cn.dev33.satoken.dao.SaTokenDao;
import cn.dev33.satoken.jwt.StpLogicJwtForSimple;
import cn.dev33.satoken.stp.StpInterface;
import cn.dev33.satoken.stp.StpLogic;
import com.kenzhao.smallsteps.common.core.factory.YmlPropertySourceFactory;
import com.kenzhao.smallsteps.common.satoken.core.dao.PlusSaTokenDao;
import com.kenzhao.smallsteps.common.satoken.core.service.SaPermissionImpl;
import com.kenzhao.smallsteps.common.satoken.core.strategy.SaPermissionMatchStrategy;
import com.kenzhao.smallsteps.common.satoken.handler.SaTokenExceptionHandler;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;

/**
 * sa-token 配置
 *
 * @author 赵轩
 */
@AutoConfiguration
@PropertySource(value = "classpath:common-satoken.yml", factory = YmlPropertySourceFactory.class)
public class SaTokenConfig {

    @Bean
    public StpLogic getStpLogicJwt() {
        // 自定义 StpLogic，支持通配符权限匹配
        return new StpLogicJwtForSimple() {
            @Override
            public boolean hasPermission(String permission) {
                java.util.List<String> permissionList = this.getPermissionList();
                return SaPermissionMatchStrategy.hasPermission(permissionList, permission);
            }

            @Override
            public boolean hasPermissionAnd(String... permissions) {
                java.util.List<String> permissionList = this.getPermissionList();
                for (String permission : permissions) {
                    if (!SaPermissionMatchStrategy.hasPermission(permissionList, permission)) {
                        return false;
                    }
                }
                return true;
            }

            @Override
            public boolean hasPermissionOr(String... permissions) {
                java.util.List<String> permissionList = this.getPermissionList();
                for (String permission : permissions) {
                    if (SaPermissionMatchStrategy.hasPermission(permissionList, permission)) {
                        return true;
                    }
                }
                return false;
            }
        };
    }

    /**
     * 权限接口实现(使用bean注入方便用户替换)
     */
    @Bean
    public StpInterface stpInterface() {
        return new SaPermissionImpl();
    }

    /**
     * 自定义dao层存储
     */
    @Bean
    public SaTokenDao saTokenDao() {
        return new PlusSaTokenDao();
    }

    /**
     * 异常处理器
     */
    @Bean
    public SaTokenExceptionHandler saTokenExceptionHandler() {
        return new SaTokenExceptionHandler();
    }

}
