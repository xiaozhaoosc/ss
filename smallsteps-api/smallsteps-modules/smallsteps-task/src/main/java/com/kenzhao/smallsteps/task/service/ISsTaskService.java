package com.kenzhao.smallsteps.task.service;

import com.kenzhao.smallsteps.task.domain.vo.SsTaskVO;

import java.util.List;

/**
 * 任务配置Service接口
 */
public interface ISsTaskService {
    /**
     * 根据儿童ID查询任务列表
     */
    List<SsTaskVO> listByChildId(Long childId);
}
