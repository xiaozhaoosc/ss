package com.kenzhao.smallsteps.system.domain.vo;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serializable;
import java.util.Date;

/**
 * AI调用日志视图对象
 *
 * @author kenzhao
 */
@Data
public class SysAiLogVo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 日志ID
     */
    private Long id;

    /**
     * 场景Key
     */
    private String sceneKey;

    /**
     * 模型ID
     */
    private Long modelId;

    /**
     * 模型名称
     */
    private String modelName;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 输入内容
     */
    private String inputContent;

    /**
     * 输出内容
     */
    private String outputContent;

    /**
     * 耗时(ms)
     */
    private Long costTime;

    /**
     * 状态（0正常 1失败）
     */
    private String status;

    /**
     * 创建时间
     */
    private Date createTime;

}
