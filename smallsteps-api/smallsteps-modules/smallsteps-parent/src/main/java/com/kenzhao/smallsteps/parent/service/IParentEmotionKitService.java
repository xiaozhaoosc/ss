package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentEmotionKitBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentEmotionKitVo;

import java.util.List;

/**
 * 情绪急救包配置服务接口
 */
public interface IParentEmotionKitService {
    /**
     * 查询情绪急救包配置列表
     *
     * @param bo 情绪急救包配置
     * @return 情绪急救包配置集合
     */
    public List<ParentEmotionKitVo> queryList(ParentEmotionKitBo bo);

    /**
     * 查询情绪急救包配置分页列表
     *
     * @param bo 情绪急救包配置
     * @param pageQuery 分页参数
     * @return 情绪急救包配置分页列表
     */
    public TableDataInfo<ParentEmotionKitVo> queryPageList(ParentEmotionKitBo bo, PageQuery pageQuery);

    /**
     * 根据急救包ID查询情绪急救包配置
     *
     * @param kitId 急救包ID
     * @return 情绪急救包配置
     */
    public ParentEmotionKitVo queryById(Long kitId);

    /**
     * 新增情绪急救包配置
     *
     * @param bo 情绪急救包配置
     * @return 结果
     */
    public boolean insertByBo(ParentEmotionKitBo bo);

    /**
     * 修改情绪急救包配置
     *
     * @param bo 情绪急救包配置
     * @return 结果
     */
    public boolean updateByBo(ParentEmotionKitBo bo);

    /**
     * 删除情绪急救包配置
     *
     * @param kitId 急救包ID
     * @return 结果
     */
    public boolean deleteWithValidById(Long kitId, boolean isValid);

    /**
     * 批量删除情绪急救包配置
     *
     * @param kitIds 需要删除的急救包ID集合
     * @param isValid 是否验证
     * @return 结果
     */
    public boolean deleteWithValidByIds(List<Long> kitIds, boolean isValid);

    /**
     * 获取孩子的情绪急救包配置
     *
     * @param childId 孩子ID
     * @return 情绪急救包配置集合
     */
    public List<ParentEmotionKitVo> getChildEmotionKits(Long childId);

    /**
     * 获取孩子特定情绪的急救包配置
     *
     * @param childId 孩子ID
     * @param emotionType 情绪类型
     * @return 情绪急救包配置集合
     */
    public List<ParentEmotionKitVo> getChildEmotionKitsByEmotionType(Long childId, Integer emotionType);
}
