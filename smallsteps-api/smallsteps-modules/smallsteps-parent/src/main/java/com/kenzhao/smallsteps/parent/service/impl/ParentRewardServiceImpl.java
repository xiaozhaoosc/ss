package com.kenzhao.smallsteps.parent.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.common.core.utils.StringUtils;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.ParentReward;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentRewardBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentRewardVo;
import com.kenzhao.smallsteps.parent.mapper.ParentRewardMapper;
import com.kenzhao.smallsteps.parent.service.IParentRewardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 家长奖励配置Service业务层处理
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@RequiredArgsConstructor
@Service
public class ParentRewardServiceImpl implements IParentRewardService {

    private final ParentRewardMapper baseMapper;

    /**
     * 查询家长奖励配置
     */
    @Override
    public ParentRewardVo queryById(Long rewardId) {
        return baseMapper.selectVoById(rewardId);
    }

    /**
     * 查询家长奖励配置列表
     */
    @Override
    public TableDataInfo<ParentRewardVo> queryPageList(ParentRewardBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ParentReward> lqw = buildQueryWrapper(bo);
        Page<ParentRewardVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询家长奖励配置列表
     */
    @Override
    public List<ParentRewardVo> queryList(ParentRewardBo bo) {
        LambdaQueryWrapper<ParentReward> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<ParentReward> buildQueryWrapper(ParentRewardBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<ParentReward> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, ParentReward::getUserId, bo.getUserId());
        lqw.like(StringUtils.isNotBlank(bo.getName()), ParentReward::getName, bo.getName());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), ParentReward::getStatus, bo.getStatus());
        return lqw;
    }

    /**
     * 新增家长奖励配置
     */
    @Override
    public Boolean insertByBo(ParentRewardBo bo) {
        ParentReward add = MapstructUtils.convert(bo, ParentReward.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setRewardId(add.getRewardId());
        }
        return flag;
    }

    /**
     * 修改家长奖励配置
     */
    @Override
    public Boolean updateByBo(ParentRewardBo bo) {
        ParentReward update = MapstructUtils.convert(bo, ParentReward.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(ParentReward entity) {
        if (entity.getUserId() != null && StringUtils.isNotBlank(entity.getName())) {
            LambdaQueryWrapper<ParentReward> lqw = Wrappers.lambdaQuery();
            lqw.eq(ParentReward::getUserId, entity.getUserId())
               .eq(ParentReward::getName, entity.getName())
               .ne(entity.getRewardId() != null, ParentReward::getRewardId, entity.getRewardId());
            if (baseMapper.exists(lqw)) {
                throw new com.kenzhao.smallsteps.common.core.exception.ServiceException("该奖励名称已存在，请勿重复创建");
            }
        }
    }

    /**
     * 批量删除家长奖励配置
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
