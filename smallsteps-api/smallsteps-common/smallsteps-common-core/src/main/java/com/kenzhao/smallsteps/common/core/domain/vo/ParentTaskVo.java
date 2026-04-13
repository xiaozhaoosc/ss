package com.kenzhao.smallsteps.common.core.domain.vo;

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
     * 父任务ID (用于任务拆解)
     */
    @ExcelProperty(value = "父任务ID")
    private Long parentId;

    /**
     * 任务标题
     */
    @ExcelProperty(value = "任务标题")
    private String title;

    /**
     * 任务内容
     */
    @ExcelProperty(value = "任务内容")
    private String content;

    /**
     * 奖励积分
     */
    @ExcelProperty(value = "奖励积分")
    private Integer rewardPoints;

    /**
     * 任务状态 (0待发布 1进行中 2已完成 3已取消)
     */
    @ExcelProperty(value = "任务状态")
    private String status;

    /**
     * 灯光效果 (硬件交互)
     */
    @ExcelProperty(value = "灯光效果")
    private String lightEffect;

    /**
     * 音频索引 (硬件交互)
     */
    @ExcelProperty(value = "音频索引")
    private String audioIndex;

    /**
     * 创建者
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新者
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 备注
     */
    private String remark;
}
