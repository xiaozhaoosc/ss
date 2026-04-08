package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.parent.domain.bo.ParentToolBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentToolVo;

import java.util.List;

/**
 * 家长辅助工具服务接口
 */
public interface IParentToolService {

    /**
     * 获取情绪急救包配置
     */
    ParentToolVo getEmotionFirstAid(Long userId);

    /**
     * 更新情绪急救包配置
     */
    boolean updateEmotionFirstAid(ParentToolBo bo);

    /**
     * 获取家长指南
     */
    List<ParentToolVo> getParentGuide(String type);

    /**
     * 获取亲子契约模板
     */
    List<ParentToolVo> getContractTemplate();
}