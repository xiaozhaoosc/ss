package com.kenzhao.smallsteps.parent.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.common.ss.domain.ParentReward;
import com.kenzhao.smallsteps.common.ss.domain.ParentRewardRedemption;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentRewardRedemptionBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentRewardRedemptionVo;
import com.kenzhao.smallsteps.parent.mapper.ParentRewardMapper;
import com.kenzhao.smallsteps.parent.mapper.ParentRewardRedemptionMapper;
import com.kenzhao.smallsteps.parent.service.IParentRewardRedemptionService;
import com.kenzhao.smallsteps.child.service.IScoreService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 奖励兑换记录Service业务层处理
 */
@RequiredArgsConstructor
@Service
public class ParentRewardRedemptionServiceImpl implements IParentRewardRedemptionService {

    private final ParentRewardRedemptionMapper baseMapper;
    private final ParentRewardMapper rewardMapper;
    private final IScoreService scoreService;

    @Override
    public TableDataInfo<ParentRewardRedemptionVo> queryPageList(ParentRewardRedemptionBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ParentRewardRedemption> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, ParentRewardRedemption::getUserId, bo.getUserId());
        lqw.eq(bo.getStatus() != null, ParentRewardRedemption::getStatus, bo.getStatus());
        Page<ParentRewardRedemptionVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public Boolean insertByBo(ParentRewardRedemptionBo bo) {
        ParentRewardRedemption add = MapstructUtils.convert(bo, ParentRewardRedemption.class);
        // 初始状态为待审批
        add.setStatus("0");
        return baseMapper.insert(add) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean approve(Long redemptionId) {
        ParentRewardRedemption redemption = baseMapper.selectById(redemptionId);
        if (redemption == null || !"0".equals(redemption.getStatus())) {
            return false;
        }

        // 1. 扣除积分
        ParentReward reward = rewardMapper.selectById(redemption.getRewardId());
        boolean success = scoreService.deductPoints(redemption.getUserId(), redemption.getPointsCost(), 
                redemption.getRewardId(), "兑换奖励: " + (reward != null ? reward.getName() : "未知奖励"));
        
        if (!success) {
            throw new RuntimeException("积分余额不足，无法批准");
        }

        // 2. 更新状态
        redemption.setStatus("1");
        return baseMapper.updateById(redemption) > 0;
    }

    @Override
    public Boolean reject(Long redemptionId) {
        ParentRewardRedemption redemption = baseMapper.selectById(redemptionId);
        if (redemption == null || !"0".equals(redemption.getStatus())) {
            return false;
        }
        redemption.setStatus("2");
        return baseMapper.updateById(redemption) > 0;
    }
}
