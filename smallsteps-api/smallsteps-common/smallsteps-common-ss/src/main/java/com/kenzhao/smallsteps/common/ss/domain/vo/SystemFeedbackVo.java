package com.kenzhao.smallsteps.common.ss.domain.vo;

import com.kenzhao.smallsteps.common.ss.domain.SystemFeedback;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 意见反馈视图对象
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SystemFeedbackVo extends SystemFeedback {
    private static final long serialVersionUID = 1L;

    /** 提交用户的昵称 */
    private String userNickName;

    /** 提交用户的头像 */
    private String userAvatar;
}
