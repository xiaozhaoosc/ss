package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.parent.domain.bo.ParentGrowthBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentGrowthVo;

import java.util.List;

/**
 * 家长成长观察服务接口
 */
public interface IParentGrowthService {

    /**
     * 获取情绪日报
     */
    ParentGrowthVo getEmotionDaily(Long userId, String date);

    /**
     * 获取能力雷达图
     */
    ParentGrowthVo getAbilityRadar(Long userId, String period);

    /**
     * 获取成长轨迹
     */
    List<ParentGrowthVo> getGrowthTrack(Long userId, String startDate, String endDate);

    /**
     * 记录情绪状态
     */
    boolean recordEmotion(ParentGrowthBo bo);
}