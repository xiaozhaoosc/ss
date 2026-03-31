package com.kenzhao.smallsteps.common.satoken.core.strategy;

import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
 * Sa-Token 权限匹配策略
 * 支持通配符 * 匹配
 *
 * @author 赵轩
 */
@Slf4j
public class SaPermissionMatchStrategy {

    /**
     * 判断是否拥有指定权限
     * 
     * @param permissionList 用户拥有的权限列表
     * @param permission     需要验证的权限
     * @return 是否拥有权限
     */
    public static boolean hasPermission(List<String> permissionList, String permission) {
        if (permissionList == null || permissionList.isEmpty()) {
            return false;
        }

        if (StrUtil.isBlank(permission)) {
            return false;
        }

        // 遍历用户权限列表
        for (String userPerm : permissionList) {
            if (StrUtil.isBlank(userPerm)) {
                continue;
            }

            // 1. 精确匹配
            if (userPerm.equals(permission)) {
                log.debug("权限匹配成功(精确): 用户权限={}, 需要权限={}", userPerm, permission);
                return true;
            }

            // 2. 通配符匹配：*:*:* 匹配所有
            if ("*:*:*".equals(userPerm)) {
                log.debug("权限匹配成功(超级管理员): 用户权限={}, 需要权限={}", userPerm, permission);
                return true;
            }

            // 3. 模块级通配符：system:* 匹配 system:user:list
            if (userPerm.endsWith(":*")) {
                String prefix = userPerm.substring(0, userPerm.length() - 1);
                if (permission.startsWith(prefix)) {
                    log.debug("权限匹配成功(模块通配符): 用户权限={}, 需要权限={}", userPerm, permission);
                    return true;
                }
            }

            // 4. 两级通配符：system:user:* 匹配 system:user:list
            if (userPerm.contains(":*")) {
                String pattern = userPerm.replace(":*", ":");
                if (permission.startsWith(pattern)) {
                    log.debug("权限匹配成功(两级通配符): 用户权限={}, 需要权限={}", userPerm, permission);
                    return true;
                }
            }
        }

        log.debug("权限匹配失败: 用户权限列表={}, 需要权限={}", permissionList, permission);
        return false;
    }
}
