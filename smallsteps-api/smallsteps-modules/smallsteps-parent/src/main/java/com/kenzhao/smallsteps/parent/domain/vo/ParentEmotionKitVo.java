package com.kenzhao.smallsteps.parent.domain.vo;

import com.kenzhao.smallsteps.parent.domain.ParentEmotionKit;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 情绪急救包配置视图对象
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ParentEmotionKitVo extends ParentEmotionKit {
    private static final long serialVersionUID = 1L;

    /** 情绪类型名称 */
    private String emotionTypeName;

    /** 状态名称 */
    private String statusName;
}
