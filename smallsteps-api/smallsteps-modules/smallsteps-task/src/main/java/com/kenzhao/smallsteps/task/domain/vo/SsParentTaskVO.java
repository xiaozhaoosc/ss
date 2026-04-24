package com.kenzhao.smallsteps.task.domain.vo;

import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 家长任务视图对象
 */
@Data
@AutoMapper(target = ParentTask.class)
public class SsParentTaskVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long parentId;
    private String childIds;
    private String title;
    private String desc;
    private Integer starReward;
    private Date deadline;
    private String status;
    private String proofRequired;
}
