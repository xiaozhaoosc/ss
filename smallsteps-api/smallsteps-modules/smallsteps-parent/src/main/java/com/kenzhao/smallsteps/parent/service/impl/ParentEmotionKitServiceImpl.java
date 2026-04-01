package com.kenzhao.smallsteps.parent.service.impl;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.parent.domain.ParentEmotionKit;
import com.kenzhao.smallsteps.parent.domain.bo.ParentEmotionKitBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentEmotionKitVo;
import com.kenzhao.smallsteps.parent.mapper.ParentEmotionKitMapper;
import com.kenzhao.smallsteps.parent.service.IParentEmotionKitService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * 情绪急救包配置服务实现
 */
@Service
@RequiredArgsConstructor
public class ParentEmotionKitServiceImpl implements IParentEmotionKitService {

    private final ParentEmotionKitMapper parentEmotionKitMapper;

    @Override
    public List<ParentEmotionKitVo> queryList(ParentEmotionKitBo bo) {
        List<ParentEmotionKit> list = parentEmotionKitMapper.selectParentEmotionKitList(bo);
        return toVoList(list);
    }

    @Override
    public TableDataInfo<ParentEmotionKitVo> queryPageList(ParentEmotionKitBo bo, PageQuery pageQuery) {
        // 简化实现，实际项目中应该使用分页查询
        List<ParentEmotionKit> list = parentEmotionKitMapper.selectParentEmotionKitList(bo);
        List<ParentEmotionKitVo> voList = toVoList(list);
        return TableDataInfo.build(voList);
    }

    @Override
    public ParentEmotionKitVo queryById(Long kitId) {
        ParentEmotionKit parentEmotionKit = parentEmotionKitMapper.selectParentEmotionKitByKitId(kitId);
        return toVo(parentEmotionKit);
    }

    @Override
    public boolean insertByBo(ParentEmotionKitBo bo) {
        ParentEmotionKit parentEmotionKit = new ParentEmotionKit();
        // 复制属性
        parentEmotionKit.setChildId(bo.getChildId());
        parentEmotionKit.setKitName(bo.getKitName());
        parentEmotionKit.setEmotionType(bo.getEmotionType());
        parentEmotionKit.setContent(bo.getContent());
        parentEmotionKit.setStatus(bo.getStatus());
        parentEmotionKit.setCreateBy(bo.getCreateBy());
        parentEmotionKit.setCreateTime(bo.getCreateTime());
        parentEmotionKit.setUpdateBy(bo.getUpdateBy());
        parentEmotionKit.setUpdateTime(bo.getUpdateTime());
        return parentEmotionKitMapper.insertParentEmotionKit(parentEmotionKit) > 0;
    }

    @Override
    public boolean updateByBo(ParentEmotionKitBo bo) {
        ParentEmotionKit parentEmotionKit = new ParentEmotionKit();
        // 复制属性
        parentEmotionKit.setKitId(bo.getKitId());
        parentEmotionKit.setChildId(bo.getChildId());
        parentEmotionKit.setKitName(bo.getKitName());
        parentEmotionKit.setEmotionType(bo.getEmotionType());
        parentEmotionKit.setContent(bo.getContent());
        parentEmotionKit.setStatus(bo.getStatus());
        parentEmotionKit.setUpdateBy(bo.getUpdateBy());
        parentEmotionKit.setUpdateTime(bo.getUpdateTime());
        return parentEmotionKitMapper.updateParentEmotionKit(parentEmotionKit) > 0;
    }

    @Override
    public boolean deleteWithValidById(Long kitId, boolean isValid) {
        return parentEmotionKitMapper.deleteParentEmotionKitByKitId(kitId) > 0;
    }

    @Override
    public boolean deleteWithValidByIds(List<Long> kitIds, boolean isValid) {
        Long[] ids = kitIds.toArray(new Long[0]);
        return parentEmotionKitMapper.deleteParentEmotionKitByKitIds(ids) > 0;
    }

    @Override
    public List<ParentEmotionKitVo> getChildEmotionKits(Long childId) {
        List<ParentEmotionKit> list = parentEmotionKitMapper.selectParentEmotionKitByChildId(childId);
        return toVoList(list);
    }

    @Override
    public List<ParentEmotionKitVo> getChildEmotionKitsByEmotionType(Long childId, Integer emotionType) {
        List<ParentEmotionKit> list = parentEmotionKitMapper.selectParentEmotionKitByChildIdAndEmotionType(childId, emotionType);
        return toVoList(list);
    }

    /**
     * 转换为VO列表
     */
    private List<ParentEmotionKitVo> toVoList(List<ParentEmotionKit> list) {
        List<ParentEmotionKitVo> voList = new ArrayList<>();
        for (ParentEmotionKit parentEmotionKit : list) {
            voList.add(toVo(parentEmotionKit));
        }
        return voList;
    }

    /**
     * 转换为VO
     */
    private ParentEmotionKitVo toVo(ParentEmotionKit parentEmotionKit) {
        if (parentEmotionKit == null) {
            return null;
        }
        ParentEmotionKitVo vo = new ParentEmotionKitVo();
        // 复制属性
        vo.setKitId(parentEmotionKit.getKitId());
        vo.setChildId(parentEmotionKit.getChildId());
        vo.setKitName(parentEmotionKit.getKitName());
        vo.setEmotionType(parentEmotionKit.getEmotionType());
        vo.setContent(parentEmotionKit.getContent());
        vo.setStatus(parentEmotionKit.getStatus());
        vo.setCreateBy(parentEmotionKit.getCreateBy());
        vo.setCreateTime(parentEmotionKit.getCreateTime());
        vo.setUpdateBy(parentEmotionKit.getUpdateBy());
        vo.setUpdateTime(parentEmotionKit.getUpdateTime());
        
        // 设置情绪类型名称
        vo.setEmotionTypeName(getEmotionTypeName(parentEmotionKit.getEmotionType()));
        
        // 设置状态名称
        vo.setStatusName(parentEmotionKit.getStatus() == 1 ? "启用" : "禁用");
        
        return vo;
    }

    /**
     * 获取情绪类型名称
     */
    private String getEmotionTypeName(Integer emotionType) {
        switch (emotionType) {
            case 1: return "开心";
            case 2: return "难过";
            case 3: return "愤怒";
            case 4: return "焦虑";
            case 5: return "平静";
            default: return "未知";
        }
    }
}
