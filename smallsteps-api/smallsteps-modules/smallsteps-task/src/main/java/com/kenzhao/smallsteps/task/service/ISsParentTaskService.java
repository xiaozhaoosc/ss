package com.kenzhao.smallsteps.task.service;

import com.kenzhao.smallsteps.task.domain.vo.SsParentTaskVO;

/**
 * 家长任务Service接口
 */
public interface ISsParentTaskService {
    /**
     * 发布新任务给孩子
     */
    boolean publishTask(SsParentTaskVO taskVO);
}
