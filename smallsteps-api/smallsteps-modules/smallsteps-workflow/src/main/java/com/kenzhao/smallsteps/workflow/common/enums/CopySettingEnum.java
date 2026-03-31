package com.kenzhao.smallsteps.workflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 抄送设置枚举
 *
 * @author 赵轩
 */
@Getter
@AllArgsConstructor
public enum CopySettingEnum implements NodeExtEnum {
    ;
    private final String label;
    private final String value;
    private final boolean selected;

}

