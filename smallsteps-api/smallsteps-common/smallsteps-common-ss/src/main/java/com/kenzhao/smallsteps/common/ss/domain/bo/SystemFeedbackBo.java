package com.kenzhao.smallsteps.common.ss.domain.bo;

import com.kenzhao.smallsteps.common.core.validate.AddGroup;
import com.kenzhao.smallsteps.common.core.validate.EditGroup;
import com.kenzhao.smallsteps.common.ss.domain.SystemFeedback;
import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 意见反馈业务对象
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = SystemFeedback.class)
public class SystemFeedbackBo extends SystemFeedback {

    @NotBlank(message = "反馈内容不能为空", groups = {AddGroup.class, EditGroup.class})
    @Override
    public String getContent() {
        return super.getContent();
    }
}
