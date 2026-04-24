package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;
import java.util.Date;

/**
 * 儿童任务执行对象 (对应 ss_task_log)
 *
 * @author 赵轩
 * @date 2026-04-08
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_task_log")
public class ChildTask extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 家庭ID (对应 sys_dept.dept_id)
     */
    private Long deptId;

    /**
     * 关联任务定义ID (对应 ss_parent_task.task_id)
     */
    private Long taskId;

    /**
     * 执行儿童 ID
     */
    private Long childId;

    /**
     * 预定执行日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date targetDate;

    /**
     * 实际专注时长 (秒)
     */
    private Integer actualDuration;

    /**
     * 任务状态 (0:待办, 1:进行中, 2:已完成, 3:放弃)
     */
    private Integer status;

    /**
     * 开始时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /**
     * 完成时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    /**
     * 任务证明图片/资料
     */
    private String proof;

    /**
     * 删除标志 (0代表存在 2代表删除)
     */
    @TableLogic
    private String delFlag;

}
