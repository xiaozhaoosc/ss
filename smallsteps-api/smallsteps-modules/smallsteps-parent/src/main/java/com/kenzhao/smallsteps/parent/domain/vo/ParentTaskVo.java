package com.kenzhao.smallsteps.parent.domain.vo;

import cn.idev.excel.annotation.ExcelProperty;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 家长任务发布视图对象 parent_task
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Data
public class ParentTaskVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 任务ID
     */
    @ExcelProperty(value = "任务ID")
    private Long taskId;

    /**
     * 用户ID
     */
    @ExcelProperty(value = "用户ID")
    private Long userId;

    /**
     * 任务标题
     */
    @ExcelProperty(value = "任务标题")
    private String title;

    /**
     * 任务描述
     */
    @ExcelProperty(value = "任务描述")
    private String description;

    /**
     * 任务图标
     */
    @ExcelProperty(value = "任务图标")
    private String icon;

    /**
     * 难度等级(1-5)
     */
    @ExcelProperty(value = "难度等级")
    private Integer difficulty;

    /**
     * 奖励积分
     */
    @ExcelProperty(value = "奖励积分")
    private Integer rewardPoints;

    /**
     * 状态(0正常 1停用)
     */
    @ExcelProperty(value = "状态")
    private String status;

}
