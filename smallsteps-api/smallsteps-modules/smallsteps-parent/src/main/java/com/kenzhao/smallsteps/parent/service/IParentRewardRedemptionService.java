package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentRewardRedemptionBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentRewardRedemptionVo;

/**
 * 奖励兑换记录Service接口
 */
public interface IParentRewardRedemptionService {

    /**
     * 查询兑换记录列表
     */
    TableDataInfo<ParentRewardRedemptionVo> queryPageList(ParentRewardRedemptionBo bo, PageQuery pageQuery);

    /**
     * 发起兑换申请
     */
    Boolean insertByBo(ParentRewardRedemptionBo bo);

    /**
     * 批准兑换
     */
    Boolean approve(Long redemptionId);

    /**
     * 拒绝兑换
     */
    Boolean reject(Long redemptionId, String reason);
}
