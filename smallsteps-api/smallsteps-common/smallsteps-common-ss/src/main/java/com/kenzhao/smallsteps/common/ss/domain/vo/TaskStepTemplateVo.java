package com.kenzhao.smallsteps.common.ss.domain.vo;

import com.kenzhao.smallsteps.common.ss.domain.TaskStepTemplate;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serializable;

/**
 * ADHD 任务步骤模板视图对象
 */
@Data
@AutoMapper(target = TaskStepTemplate.class)
public class TaskStepTemplateVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long stepId;
    private Integer stepOrder;
    private String content;
    private String visualHint;
    private String audioHint;
    private Integer expectedDuration;
}
