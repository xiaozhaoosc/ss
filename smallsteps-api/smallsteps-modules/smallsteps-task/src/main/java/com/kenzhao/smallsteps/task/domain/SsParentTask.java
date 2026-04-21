package com.kenzhao.smallsteps.task.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.tenant.core.TenantEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * 家长任务发布实体类 ss_parent_task
 *
 * @author 赵轩
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_parent_task")
public class SsParentTask extends TenantEntity {

    /**
     * 主键
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 发起家长ID
     */
    private Long parentId;

    /**
     * 接收该任务的小朋友ID列表 (int8[] in PG)
     */
    private String childIds;

    /**
     * 任务标题
     */
    private String title;

    /**
     * 任务详情
     */
    @TableField("`desc`")
    private String desc;

    /**
     * 星星奖励
     */
    private Integer starReward;

    /**
     * 截止时间
     */
    private LocalDateTime deadline;

    /**
     * 状态 (0: 待认领/进行中, 1: 已完成, 2: 已取消)
     */
    private String status;

    /**
     * 是否需要上传凭证 (0: 不需要, 1: 需要)
     */
    private String proofRequired;

    /**
     * 删除标志
     */
    private String delFlag;
}
