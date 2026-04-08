package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.child.domain.bo.ChildTaskBo;
import com.kenzhao.smallsteps.child.domain.vo.ChildTaskVo;

import java.util.List;

/**
 * 儿童任务执行服务接口
 */
public interface IChildTaskService {

    /**
     * NFC 刷卡签到
     */
    ChildTaskVo nfcSignin(String nfcId, Long taskId);

    /**
     * 更新任务状态
     */
    boolean updateStatus(ChildTaskBo bo);

    /**
     * 根据用户ID查询任务列表
     */
    List<ChildTaskVo> queryListByUserId(Long userId);

    /**
     * 根据任务ID查询任务详情
     */
    ChildTaskVo queryById(Long taskId);
}