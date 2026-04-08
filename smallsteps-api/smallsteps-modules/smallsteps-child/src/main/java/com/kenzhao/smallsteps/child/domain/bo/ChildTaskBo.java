package com.kenzhao.smallsteps.child.domain.bo;

import lombok.Data;

/**
 * 儿童任务执行业务对象
 */
@Data
public class ChildTaskBo {

    /**
     * 任务ID
     */
    private Long taskId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 任务状态
     */
    private String status;

    /**
     * NFC ID
     */
    private String nfcId;

    /**
     * 完成时间
     */
    private String completeTime;
}