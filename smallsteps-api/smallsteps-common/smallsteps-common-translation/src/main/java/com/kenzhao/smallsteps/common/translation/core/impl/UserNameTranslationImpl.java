package com.kenzhao.smallsteps.common.translation.core.impl;

import cn.hutool.core.convert.Convert;
import com.kenzhao.smallsteps.common.core.service.UserService;
import com.kenzhao.smallsteps.common.translation.annotation.TranslationType;
import com.kenzhao.smallsteps.common.translation.constant.TransConstant;
import com.kenzhao.smallsteps.common.translation.core.TranslationInterface;
import lombok.AllArgsConstructor;

/**
 * 用户名翻译实现
 *
 * @author 赵轩
 */
@AllArgsConstructor
@TranslationType(type = TransConstant.USER_ID_TO_NAME)
public class UserNameTranslationImpl implements TranslationInterface<String> {

    private final UserService userService;

    @Override
    public String translation(Object key, String other) {
        return userService.selectUserNameById(Convert.toLong(key));
    }
}
