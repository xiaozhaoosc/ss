package com.kenzhao.smallsteps.common.translation.core.impl;

import com.kenzhao.smallsteps.common.core.service.DeptService;
import com.kenzhao.smallsteps.common.translation.annotation.TranslationType;
import com.kenzhao.smallsteps.common.translation.constant.TransConstant;
import com.kenzhao.smallsteps.common.translation.core.TranslationInterface;
import lombok.AllArgsConstructor;

/**
 * 部门翻译实现
 *
 * @author 赵轩
 */
@AllArgsConstructor
@TranslationType(type = TransConstant.DEPT_ID_TO_NAME)
public class DeptNameTranslationImpl implements TranslationInterface<String> {

    private final DeptService deptService;

    @Override
    public String translation(Object key, String other) {
        if (key instanceof String ids) {
            return deptService.selectDeptNameByIds(ids);
        } else if (key instanceof Long id) {
            return deptService.selectDeptNameByIds(id.toString());
        }
        return null;
    }
}
