package com.kenzhao.smallsteps.common.core.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 设备类型
 *
 * @author 赵轩
 */
@Getter
@AllArgsConstructor
public enum DeviceType {

    /**
     * pc端
     */
    PC("pc"),

    /**
     * app端
     */
    APP("app"),

    /**
     * 小程序端
     */
    XCX("xcx"),

    /**
     * 第三方社交登录平台
     */
    SOCIAL("social");

    /**
     * 设备标识
     */
    private final String device;
}
