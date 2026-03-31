package com.kenzhao.smallsteps.workflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 变量枚举
 *
 * @author 赵轩
 */
@Getter
@AllArgsConstructor
public enum VariablesEnum implements NodeExtEnum {
    ;
    private final String label;
    private final String value;
    private final boolean selected;

}

