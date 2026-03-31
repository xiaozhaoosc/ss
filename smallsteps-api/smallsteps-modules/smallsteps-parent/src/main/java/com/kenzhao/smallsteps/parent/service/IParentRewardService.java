package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.parent.domain.vo.ParentRewardVo;
import com.kenzhao.smallsteps.parent.domain.bo.ParentRewardBo;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 家长奖励配置Service接口
 *
 * @author 赵轩
 * @date 2026-02-01
 */
public interface IParentRewardService {

    /**
     * 查询家长奖励配置
     */
    ParentRewardVo queryById(Long rewardId);

    /**
     * 查询家长奖励配置列表
     */
    TableDataInfo<ParentRewardVo> queryPageList(ParentRewardBo bo, PageQuery pageQuery);

    /**
     * 查询家长奖励配置列表
     */
    List<ParentRewardVo> queryList(ParentRewardBo bo);

    /**
     * 新增家长奖励配置
     */
    Boolean insertByBo(ParentRewardBo bo);

    /**
     * 修改家长奖励配置
     */
    Boolean updateByBo(ParentRewardBo bo);

    /**
     * 校验并批量删除家长奖励配置信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
