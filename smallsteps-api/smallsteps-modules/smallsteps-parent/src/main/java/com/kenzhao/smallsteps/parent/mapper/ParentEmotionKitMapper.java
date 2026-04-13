package com.kenzhao.smallsteps.parent.mapper;

import com.kenzhao.smallsteps.common.ss.domain.ParentEmotionKit;

import java.util.List;

/**
 * 情绪急救包配置Mapper接口
 */
public interface ParentEmotionKitMapper {
    /**
     * 查询情绪急救包配置列表
     *
     * @param parentEmotionKit 情绪急救包配置
     * @return 情绪急救包配置集合
     */
    public List<ParentEmotionKit> selectParentEmotionKitList(ParentEmotionKit parentEmotionKit);

    /**
     * 根据急救包ID查询情绪急救包配置
     *
     * @param kitId 急救包ID
     * @return 情绪急救包配置
     */
    public ParentEmotionKit selectParentEmotionKitByKitId(Long kitId);

    /**
     * 新增情绪急救包配置
     *
     * @param parentEmotionKit 情绪急救包配置
     * @return 结果
     */
    public int insertParentEmotionKit(ParentEmotionKit parentEmotionKit);

    /**
     * 修改情绪急救包配置
     *
     * @param parentEmotionKit 情绪急救包配置
     * @return 结果
     */
    public int updateParentEmotionKit(ParentEmotionKit parentEmotionKit);

    /**
     * 删除情绪急救包配置
     *
     * @param kitId 急救包ID
     * @return 结果
     */
    public int deleteParentEmotionKitByKitId(Long kitId);

    /**
     * 批量删除情绪急救包配置
     *
     * @param kitIds 需要删除的急救包ID集合
     * @return 结果
     */
    public int deleteParentEmotionKitByKitIds(Long[] kitIds);

    /**
     * 查询孩子的情绪急救包配置
     *
     * @param childId 孩子ID
     * @return 情绪急救包配置集合
     */
    public List<ParentEmotionKit> selectParentEmotionKitByChildId(Long childId);

    /**
     * 查询孩子特定情绪的急救包配置
     *
     * @param childId 孩子ID
     * @param emotionType 情绪类型
     * @return 情绪急救包配置集合
     */
    public List<ParentEmotionKit> selectParentEmotionKitByChildIdAndEmotionType(Long childId, Integer emotionType);
}
