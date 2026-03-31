//package com.kenzhao.smallsteps.common.satoken.core.strategy;
//
//import org.junit.jupiter.api.Test;
//
//import java.util.Arrays;
//import java.util.Collections;
//import java.util.List;
//
//import static org.junit.jupiter.api.Assertions.*;
//
///**
// * SaPermissionMatchStrategy 单元测试
// *
// * @author 赵轩
// */
//class SaPermissionMatchStrategyTest {
//
//    @Test
//    void testExactMatch() {
//        List<String> permissions = Arrays.asList("system:user:list", "system:user:add");
//
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "system:user:list"));
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "system:user:add"));
//        assertFalse(SaPermissionMatchStrategy.hasPermission(permissions, "system:user:delete"));
//    }
//
//    @Test
//    void testSuperAdminWildcard() {
//        List<String> permissions = Collections.singletonList("*:*:*");
//
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "parent:task:list"));
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "system:user:add"));
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "any:module:action"));
//    }
//
//    @Test
//    void testModuleLevelWildcard() {
//        List<String> permissions = Collections.singletonList("system:*");
//
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "system:user:list"));
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "system:role:add"));
//        assertFalse(SaPermissionMatchStrategy.hasPermission(permissions, "parent:task:list"));
//    }
//
//    @Test
//    void testTwoLevelWildcard() {
//        List<String> permissions = Collections.singletonList("system:user:*");
//
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "system:user:list"));
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "system:user:add"));
//        assertFalse(SaPermissionMatchStrategy.hasPermission(permissions, "system:role:list"));
//    }
//
//    @Test
//    void testEmptyPermissionList() {
//        List<String> permissions = Collections.emptyList();
//
//        assertFalse(SaPermissionMatchStrategy.hasPermission(permissions, "system:user:list"));
//    }
//
//    @Test
//    void testNullPermissionList() {
//        assertFalse(SaPermissionMatchStrategy.hasPermission(null, "system:user:list"));
//    }
//
//    @Test
//    void testBlankPermission() {
//        List<String> permissions = Collections.singletonList("*:*:*");
//
//        assertFalse(SaPermissionMatchStrategy.hasPermission(permissions, ""));
//        assertFalse(SaPermissionMatchStrategy.hasPermission(permissions, null));
//    }
//
//    @Test
//    void testMixedPermissions() {
//        List<String> permissions = Arrays.asList(
//                "system:user:list",
//                "parent:*",
//                "*:*:*");
//
//        // 精确匹配
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "system:user:list"));
//        // 模块通配符
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "parent:task:add"));
//        // 超级管理员通配符
//        assertTrue(SaPermissionMatchStrategy.hasPermission(permissions, "workflow:process:start"));
//    }
//}
