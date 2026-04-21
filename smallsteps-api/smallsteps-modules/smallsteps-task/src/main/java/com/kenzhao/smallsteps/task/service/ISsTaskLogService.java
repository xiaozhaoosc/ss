package com.kenzhao.smallsteps.task.service;

import com.kenzhao.smallsteps.task.domain.vo.SsTaskLogVO;

/**
 * 任务执行记录Service接口
 */
public interface ISsTaskLogService {

    /**
     * 孩子端提交任务 (申请点亮)
     */
    boolean submitTask(Long logId);

    /**
     * 家长端点亮星星 (确认奖励)
     */
    boolean lightUp(Long logId);
}
