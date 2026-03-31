package com.kenzhao.smallsteps.workflow.service.impl;

import cn.hutool.core.convert.Convert;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.kenzhao.smallsteps.common.translation.annotation.TranslationType;
import com.kenzhao.smallsteps.common.translation.core.TranslationInterface;
import com.kenzhao.smallsteps.workflow.common.ConditionalOnEnable;
import com.kenzhao.smallsteps.workflow.common.constant.FlowConstant;
import com.kenzhao.smallsteps.workflow.service.IFlwCategoryService;
import org.springframework.stereotype.Service;

/**
 * 流程分类名称翻译实现
 *
 * @author 赵轩
 */
@ConditionalOnEnable
@Slf4j
@RequiredArgsConstructor
@Service
@TranslationType(type = FlowConstant.CATEGORY_ID_TO_NAME)
public class CategoryNameTranslationImpl implements TranslationInterface<String> {

    private final IFlwCategoryService flwCategoryService;

    @Override
    public String translation(Object key, String other) {
        return flwCategoryService.selectCategoryNameById(Convert.toLong(key));
    }
}
