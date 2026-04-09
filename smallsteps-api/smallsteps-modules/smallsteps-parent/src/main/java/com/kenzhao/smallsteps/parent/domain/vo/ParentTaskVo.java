package com.kenzhao.smallsteps.parent.domain.vo;

import com.alibaba.excel.annotation.ExcelProperty;
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
     * 父任务ID (用于任务拆解)
     */
    @ExcelProperty(value = "父任务ID")
    private Long parentId;

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
    @ExcelProperty(value = "难度等级(1-5)")
    private Integer difficulty;

    /**
     * 支架强度/辅助强度(1-5)
     */
    @ExcelProperty(value = "支架强度(1-5)")
    private Integer promptLevel;

    /**
     * 循环类型(0单次 1每日 2每周)
     */
    @ExcelProperty(value = "循环类型")
    private Integer cycleType;

    /**
     * 奖励积分
     */
    @ExcelProperty(value = "奖励积分")
    private Integer rewardPoints;

    /**
     * 灯光效果代码
     */
    @ExcelProperty(value = "灯光效果代码")
    private String lightEffect;

    /**
     * 音频索引代码
     */
    @ExcelProperty(value = "音频索引代码")
    private String audioEffect;

    /**
     * 截止时间
     */
    @ExcelProperty(value = "截止时间")
    private Date deadline;

    /**
     * 状态(0进行中 1已完成 2已过期)
     */
    @ExcelProperty(value = "状态(0进行中 1已完成 2已过期)")
    private String status;

    /**
     * 状态名称
     */
    private String statusName;

}
