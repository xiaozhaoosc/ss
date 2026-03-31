package com.kenzhao.smallsteps.common.core.validate.enumd;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import com.kenzhao.smallsteps.common.core.utils.StringUtils;
import com.kenzhao.smallsteps.common.core.utils.reflect.ReflectUtils;

/**
 * 自定义枚举校验注解实现
 *
 * @author 赵轩
 * @date 2024-12-09
 */
public class EnumPatternValidator implements ConstraintValidator<EnumPattern, String> {

    private EnumPattern annotation;

    @Override
    public void initialize(EnumPattern annotation) {
        ConstraintValidator.super.initialize(annotation);
        this.annotation = annotation;
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext constraintValidatorContext) {
        if (StringUtils.isNotBlank(value)) {
            String fieldName = annotation.fieldName();
            for (Object e : annotation.type().getEnumConstants()) {
                if (value.equals(ReflectUtils.invokeGetter(e, fieldName))) {
                    return true;
                }
            }
        }
        return false;
    }

}
