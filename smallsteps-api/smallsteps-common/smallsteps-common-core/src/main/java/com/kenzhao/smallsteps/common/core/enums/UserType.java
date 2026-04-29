package com.kenzhao.smallsteps.common.core.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;
import com.kenzhao.smallsteps.common.core.utils.StringUtils;

/**
 * 用户类型
 *
 * @author 赵轩
 */
@Getter
@AllArgsConstructor
public enum UserType {

    /**
     * 家长
     */
    PARENT("1"),

    /**
     * 儿童
     */
    CHILD("2"),

    /**
     * 系统管理员
     */
    SYS_USER("sys_user");

    /**
     * 用户类型标识（用于 token、权限识别等）
     */
    private final String userType;

    public static UserType getUserType(String str) {
        if (str == null) {
            throw new RuntimeException("'UserType' not found By null");
        }
        for (UserType value : values()) {
            if (str.equals(value.getUserType()) || str.startsWith(value.getUserType() + ":")) {
                return value;
            }
        }
        throw new RuntimeException("'UserType' not found By " + str);
    }
}
