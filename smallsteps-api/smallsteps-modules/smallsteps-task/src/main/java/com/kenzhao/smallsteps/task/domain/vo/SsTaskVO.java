package com.kenzhao.smallsteps.task.domain.vo;

import com.kenzhao.smallsteps.task.domain.SsTask;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 任务配置视图对象
 */
@Data
@AutoMapper(target = SsTask.class)
public class SsTaskVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** ID */
    private Long id;
    /** 儿童ID */
    private Long childId;
    /** 标题 */
    private String title;
    /** 图标 */
    private String icon;
    /** 奖励星星数 */
    private Integer starReward;
    /** 难度 */
    private Integer difficulty;
    /** 状态 */
    private String status;
}
