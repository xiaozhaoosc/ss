package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童AI交互记录对象 ss_child_ai
 * 
 * @author 赵轩
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_child_ai")
public class ChildAI extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 交互ID */
    @TableId(value = "id")
    private Long id;

    /** 孩子ID */
    private Long childId;

    /** 用户输入 */
    private String userInput;

    /** AI回复内容 */
    private String aiResponse;

    /** 情绪类型 (1-开心, 2-难过, 3-愤怒, 4-焦虑, 5-平静) */
    private Integer emotionType;

    /** 场景上下文 */
    private String context;
}
