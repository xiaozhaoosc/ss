package com.kenzhao.smallsteps.task.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 家长任务对象 ss_parent_task
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_parent_task")
public class SsParentTask extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /** 任务ID */
    @TableId
    private Long id;

    /** 家长ID */
    private Long parentId;

    /** 儿童ID(s) */
    private String childIds;

    /** 标题 */
    private String title;

    /** 描述 */
    private String desc;

    /** 奖励星星数 */
    private Integer starReward;

    /** 截止时间 */
    private Date deadline;

    /** 状态 (0:发布中, 1:已完成, 2:已撤回) */
    private String status;

    /** 是否强制上传凭证 (1:是, 0:否) */
    private String proofRequired;
}
