package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentTaskVo;
import com.kenzhao.smallsteps.task.mapper.ChildTaskMapper;
import com.kenzhao.smallsteps.child.service.IChildTaskService;
import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.ss.domain.vo.ChildTaskVo;
import com.kenzhao.smallsteps.task.service.IParentTaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 儿童任务务实现
 */
@Service
@RequiredArgsConstructor
public class ChildTaskServiceImpl implements IChildTaskService {

    private final ChildTaskMapper childTaskMapper;
    private final IParentTaskService parentTaskService;
    private final com.kenzhao.smallsteps.child.service.IScoreService scoreService;

    @Override
    public List<ChildTaskVo> selectChildTaskList(ChildTask childTask) {
        List<ChildTask> list = childTaskMapper.selectList(new LambdaQueryWrapper<>(childTask)
                .orderByDesc(ChildTask::getCreateTime));
        return list.stream().map(this::toVo).collect(Collectors.toList());
    }

    private ChildTaskVo toVo(ChildTask childTask) {
        if (childTask == null) return null;
        ChildTaskVo vo = new ChildTaskVo();
        vo.setChildTaskId(childTask.getId());
        vo.setTaskId(childTask.getTaskId());
        vo.setChildId(childTask.getChildId());
        vo.setStatus(String.valueOf(childTask.getStatus()));
        vo.setProof(childTask.getProof());
        vo.setCreateTime(childTask.getCreateTime());
        vo.setEndTime(childTask.getEndTime());

        // Populate task definition
        if (childTask.getTaskId() != null) {
            vo.setTaskDefinition(parentTaskService.queryById(childTask.getTaskId()));
        }
        return vo;
    }

    @Override
    public ChildTaskVo selectChildTaskById(Long id) {
        ChildTask childTask = childTaskMapper.selectById(id);
        return toVo(childTask);
    }

    @Override
    public int insertChildTask(ChildTask childTask) {
        if (childTask.getStatus() == null) {
            childTask.setStatus(ChildTask.STATUS_ONGOING);
        }
        return childTaskMapper.insert(childTask);
    }

    @Override
    public int updateChildTask(ChildTask childTask) {
        return childTaskMapper.updateById(childTask);
    }

    @Override
    public int deleteChildTaskById(Long id) {
        return childTaskMapper.deleteById(id);
    }

    @Override
    public int deleteChildTaskByIds(Long[] ids) {
        return childTaskMapper.deleteBatchIds(List.of(ids));
    }

    @Override
    public int startTask(Long taskId, Long childId) {
        ChildTask task = new ChildTask();
        task.setTaskId(taskId);
        task.setChildId(childId);
        task.setStatus(ChildTask.STATUS_ONGOING);
        task.setStartTime(new java.util.Date());
        task.setTargetDate(new java.util.Date()); // 确保今日任务统计能包含此任务
        return childTaskMapper.insert(task);
    }

    @Override
    public int completeTask(Long taskId, Long childId, String proof) {
        LambdaQueryWrapper<ChildTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ChildTask::getTaskId, taskId)
                .eq(ChildTask::getChildId, childId)
                .eq(ChildTask::getStatus, ChildTask.STATUS_ONGOING);

        ChildTask taskLog = childTaskMapper.selectOne(queryWrapper);
        if (taskLog != null) {
            // ADHD Logic: Instant Gratification - Provide stars immediately upon completion
            taskLog.setStatus(ChildTask.STATUS_LIGHT_UP);
            taskLog.setEndTime(new java.util.Date());
            taskLog.setProof(proof);
            if (taskLog.getTargetDate() == null) {
                taskLog.setTargetDate(new java.util.Date());
            }
            int rows = childTaskMapper.updateById(taskLog);

            if (rows > 0) {
                // Add points/stars to child balance
                ParentTaskVo taskDef = parentTaskService.queryById(taskId);
                int points = (taskDef != null && taskDef.getRewardPoints() != null) ? taskDef.getRewardPoints() : 10;
                String taskTitle = (taskDef != null) ? taskDef.getTitle() : "专注任务";
                scoreService.addPoints(childId, points, taskId, "完成任务: " + taskTitle);
            }
            return rows;
        }
        return 0;
    }

    @Override
    public int failTask(Long taskId, Long childId) {
        LambdaQueryWrapper<ChildTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ChildTask::getTaskId, taskId)
                .eq(ChildTask::getChildId, childId)
                .eq(ChildTask::getStatus, ChildTask.STATUS_ONGOING);

        ChildTask taskLog = childTaskMapper.selectOne(queryWrapper);
        if (taskLog != null) {
            taskLog.setStatus(ChildTask.STATUS_FAILED);
            taskLog.setEndTime(new java.util.Date());
            return childTaskMapper.updateById(taskLog);
        }
        return 0;
    }

    @Override
    public List<ChildTaskVo> selectPendingTasksByChildId(Long childId) {
        List<ChildTask> list = childTaskMapper.selectList(new LambdaQueryWrapper<ChildTask>()
                .eq(ChildTask::getChildId, childId)
                .and(w -> w.eq(ChildTask::getStatus, ChildTask.STATUS_ONGOING)
                        .or().eq(ChildTask::getStatus, "0")) // 包含初始/待领取状态
                .orderByDesc(ChildTask::getCreateTime));
        return list.stream().map(this::toVo).collect(Collectors.toList());
    }

    @Override
    public ChildTaskVo selectCurrentTaskByChildId(Long childId) {
        LambdaQueryWrapper<ChildTask> lqw = new LambdaQueryWrapper<>();
        lqw.eq(ChildTask::getChildId, childId)
           .eq(ChildTask::getStatus, ChildTask.STATUS_ONGOING)
           .orderByDesc(ChildTask::getStartTime)
           .last("limit 1");
        return toVo(childTaskMapper.selectOne(lqw));
    }

    @Override
    public int nfcCheckIn(String nfcId, Long childId) {
        // Logic for NFC mapping to task can be added here
        return 1;
    }
}
