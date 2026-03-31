package com.kenzhao.smallsteps.parent.domain.vo;

import cn.idev.excel.annotation.ExcelProperty;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 家长奖励配置视图对象 parent_reward
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Data
public class ParentRewardVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 奖励ID
     */
    @ExcelProperty(value = "奖励ID")
    private Long rewardId;

    /**
     * 用户ID
     */
    @ExcelProperty(value = "用户ID")
    private Long userId;

    /**
     * 奖励名称
     */
    @ExcelProperty(value = "奖励名称")
    private String name;

    /**
     * 所需积分
     */
    @ExcelProperty(value = "所需积分")
    private Integer pointsRequired;

    /**
     * 库存(-1表示无限)
     */
    @ExcelProperty(value = "库存")
    private Integer stock;

    /**
     * 奖励图标
     */
    @ExcelProperty(value = "图标")
    private String icon;

    /**
     * 状态(0正常 1停用)
     */
    @ExcelProperty(value = "状态")
    private String status;

}
