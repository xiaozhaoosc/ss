package com.kenzhao.smallsteps.child.service.impl;

import com.kenzhao.smallsteps.child.service.IChildRewardService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ChildRewardServiceImpl implements IChildRewardService {

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean redeemReward(Long rewardId, Long childId) {
        // 1. check reward exists and stock
        // 2. check child score >= points_required
        // 3. deduct score (freeze)
        // 4. insert into ss_parent_reward_redemption status=0 (pending)
        return true;
    }
}
