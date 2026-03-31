package com.kenzhao.smallsteps.workflow.domain.vo;

import lombok.Data;
import com.kenzhao.smallsteps.common.translation.annotation.Translation;
import com.kenzhao.smallsteps.common.translation.constant.TransConstant;

import java.io.Serial;
import java.io.Serializable;

/**
 * 抄送对象
 *
 * @author 赵轩
 */
@Data
public class FlowCopyVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 用户名称
     */
    @Translation(type = TransConstant.USER_ID_TO_NICKNAME, mapper = "userId")
    private String userName;

    public FlowCopyVo(Long userId) {
        this.userId = userId;
    }

}
