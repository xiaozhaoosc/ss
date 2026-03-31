package com.kenzhao.smallsteps.workflow.domain.bo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import com.kenzhao.smallsteps.common.core.validate.AddGroup;

import java.io.Serial;
import java.io.Serializable;

/**
 * 终止任务请求对象
 *
 * @author 赵轩
 */
@Data
public class FlowTerminationBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 任务id
     */
    @NotNull(message = "任务id为空", groups = AddGroup.class)
    private Long taskId;

    /**
     * 审批意见
     */
    private String comment;
}
