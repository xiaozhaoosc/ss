package com.kenzhao.smallsteps.common.translation.core.impl;

import lombok.AllArgsConstructor;
import com.kenzhao.smallsteps.common.core.service.UserService;
import com.kenzhao.smallsteps.common.translation.annotation.TranslationType;
import com.kenzhao.smallsteps.common.translation.constant.TransConstant;
import com.kenzhao.smallsteps.common.translation.core.TranslationInterface;

/**
 * 用户名称翻译实现
 *
 * @author 赵轩
 */
@AllArgsConstructor
@TranslationType(type = TransConstant.USER_ID_TO_NICKNAME)
public class NicknameTranslationImpl implements TranslationInterface<String> {

    private final UserService userService;

    @Override
    public String translation(Object key, String other) {
        if (key instanceof Long id) {
            return userService.selectNicknameById(id);
        } else if (key instanceof String ids) {
            return userService.selectNicknameByIds(ids);
        }
        return null;
    }
}
