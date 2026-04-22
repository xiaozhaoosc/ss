package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.ss.domain.vo.ChildTaskVo;
import java.util.List;

/**
 * 儿童任务服务接口 (支持 VO 类型)
 *
 * @author 赵轩
 * @date 2026-04-08
 */
public interface IChildTaskService {

    /**
     * 查询儿童任务列表
     */
    List<ChildTaskVo> selectChildTaskList(ChildTask childTask);

    /**
     * 根据任务ID查询儿童任务
     */
    ChildTaskVo selectChildTaskById(Long id);

    /**
     * 新增儿童任务 (任务执行记录)
     */
    int insertChildTask(ChildTask childTask);

    /**
     * 修改儿童任务
     */
    int updateChildTask(ChildTask childTask);

    /**
     * 删除儿童任务
     */
    int deleteChildTaskById(Long id);

    /**
     * 批量删除儿童任务
     */
    int deleteChildTaskByIds(Long[] ids);

    /**
     * 开始执行任务
     */
    int startTask(Long taskId, Long childId);

    /**
     * 完成任务
     */
    int completeTask(Long taskId, Long childId);

    /**
     * 标记任务失败/放弃
     */
    int failTask(Long taskId, Long childId);

    /**
     * 查询儿童待执行任务
     */
    List<ChildTaskVo> selectPendingTasksByChildId(Long childId);

    /**
     * 查询儿童正在执行的任务
     */
    ChildTaskVo selectCurrentTaskByChildId(Long childId);

    /**
     * NFC刷卡签到
     */
    int nfcCheckIn(String nfcId, Long childId);
}
