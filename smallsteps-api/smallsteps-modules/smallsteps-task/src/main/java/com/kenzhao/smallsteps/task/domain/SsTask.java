package com.kenzhao.smallsteps.task.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.tenant.core.TenantEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 任务配置实体类 ss_task
 *
 * @author 赵轩
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_task")
public class SsTask extends TenantEntity {

    /**
     * 任务ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 儿童ID
     */
    private Long childId;

    /**
     * 任务标题
     */
    private String title;

    /**
     * 图标
     */
    private String icon;

    /**
     * 奖励星星数
     */
    private Integer starReward;

    /**
     * 难度 (1-5)
     */
    private Integer difficulty;

    /**
     * 任务类型 (1: 普通, 2: 挑战等)
     */
    private String type;

    /**
     * 调度配置 (Cron或每日/每周标识)
     */
    private String scheduleConf;

    /**
     * 子任务列表 (JSONB)
     */
    private String subTasks;

    /**
     * 语音提示URL
     */
    private String voicePrompt;

    /**
     * 引导图URL
     */
    private String guideImage;

    /**
     * 状态 (0: 启用, 1: 停用)
     */
    private String status;

    /**
     * 删除标志 (0: 正常, 2: 删除)
     */
    private String delFlag;
}
