package com.kenzhao.smallsteps.parent.domain.vo;

import lombok.Data;

import java.util.List;

/**
 * 家长成长观察视图对象
 */
@Data
public class ParentGrowthVo {

    /**
     * 记录ID
     */
    private Long recordId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 日期
     */
    private String date;

    /**
     * 情绪状态
     */
    private String emotionState;

    /**
     * 情绪评分
     */
    private Integer emotionScore;

    /**
     * 能力数据
     */
    private List<AbilityData> abilityDataList;

    /**
     * 观察记录
     */
    private String observation;

    /**
     * 成长轨迹数据
     */
    private List<GrowthTrackData> growthTrackDataList;

    /**
     * 能力数据
     */
    @Data
    public static class AbilityData {
        private String abilityType;
        private Integer abilityScore;
    }

    /**
     * 成长轨迹数据
     */
    @Data
    public static class GrowthTrackData {
        private String date;
        private Integer emotionScore;
        private Integer taskCompletionRate;
        private Integer pointsEarned;
    }
}