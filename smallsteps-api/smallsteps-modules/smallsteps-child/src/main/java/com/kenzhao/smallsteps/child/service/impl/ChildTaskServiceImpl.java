package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.child.domain.ChildTask;
import com.kenzhao.smallsteps.child.domain.vo.ChildTaskVo;
import com.kenzhao.smallsteps.child.mapper.ChildTaskMapper;
import com.kenzhao.smallsteps.child.service.IChildTaskService;
import com.kenzhao.smallsteps.parent.service.IParentTaskService;
import com.kenzhao.smallsteps.parent.service.IScoreService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * 儿童任务服务实现
 */
@Service
@RequiredArgsConstructor
public class ChildTaskServiceImpl implements IChildTaskService {

    private final ChildTaskMapper childTaskMapper;
    private final IScoreService scoreService;
    private final IParentTaskService parentTaskService;

    @Override
    public List<ChildTask> selectChildTaskList(ChildTask childTask) {
        return childTaskMapper.selectList(new LambdaQueryWrapper<ChildTask>()
                .eq(childTask.getChildId() != null, ChildTask::getChildId, childTask.getChildId())
                .eq(childTask.getStatus() != null, ChildTask::getStatus, childTask.getStatus())
                .orderByDesc(ChildTask::getStartTime));
    }

    @Override
    public ChildTask selectChildTaskByTaskId(Long logId) {
        return childTaskMapper.selectById(logId);
    }

    @Override
    public int insertChildTask(ChildTask childTask) {
        childTask.setCreateTime(new Date());
        return childTaskMapper.insert(childTask);
    }

    @Override
    public int updateChildTask(ChildTask childTask) {
        childTask.setUpdateTime(new Date());
        return childTaskMapper.updateById(childTask);
    }

    @Override
    public int deleteChildTaskByTaskId(Long logId) {
        return childTaskMapper.deleteById(logId);
    }

    @Override
    public int deleteChildTaskByTaskIds(Long[] logIds) {
        return childTaskMapper.deleteBatchIds(List.of(logIds));
    }

    @Override
    @Transactional
    public int startTask(Long taskId, Long childId) {
        // 创建一个新的任务执行记录 (Log)
        ChildTask log = new ChildTask();
        log.setTaskId(taskId);
        log.setChildId(childId);
        log.setStatus(1); // 1-进行中
        log.setStartTime(new Date());
        log.setTargetDate(new Date());
        return childTaskMapper.insert(log);
    }

    @Override
    @Transactional
    public int completeTask(Long taskId, Long childId) {
        // 查找该儿童正在进行的该任务记录
        ChildTask log = childTaskMapper.selectOne(new LambdaQueryWrapper<ChildTask>()
                .eq(ChildTask::getTaskId, taskId)
                .eq(ChildTask::getChildId, childId)
                .eq(ChildTask::getStatus, 1) // 正在进行中
                .orderByDesc(ChildTask::getStartTime)
                .last("LIMIT 1"));

        if (log != null) {
            log.setStatus(2); // 2-已完成
            log.setEndTime(new Date());
            
            // 计算时长 (秒)
            if (log.getStartTime() != null) {
                long duration = (log.getEndTime().getTime() - log.getStartTime().getTime()) / 1000;
                log.setActualDuration((int) duration);
            }
            
            int rows = childTaskMapper.updateById(log);
            
            // 奖励逻辑待整合 (后期通过 AOP 或 事件驱动)
            // scoreService.addPoints(childId, 10, taskId, "完成任务奖励");
            
            return rows;
        }
        return 0;
    }

    @Override
    public int failTask(Long taskId, Long childId) {
        ChildTask log = childTaskMapper.selectOne(new LambdaQueryWrapper<ChildTask>()
                .eq(ChildTask::getTaskId, taskId)
                .eq(ChildTask::getChildId, childId)
                .eq(ChildTask::getStatus, 1)
                .orderByDesc(ChildTask::getStartTime)
                .last("LIMIT 1"));

        if (log != null) {
            log.setStatus(3); // 3-放弃/失败
            log.setEndTime(new Date());
            return childTaskMapper.updateById(log);
        }
        return 0;
    }

    @Override
    public List<ChildTaskVo> selectPendingTasksByChildId(Long childId) {
        List<ChildTask> logs = childTaskMapper.selectList(new LambdaQueryWrapper<ChildTask>()
                .eq(ChildTask::getChildId, childId)
                .eq(ChildTask::getStatus, 0));
        return toVoList(logs);
    }

    @Override
    public ChildTaskVo selectCurrentTaskByChildId(Long childId) {
        ChildTask log = childTaskMapper.selectOne(new LambdaQueryWrapper<ChildTask>()
                .eq(ChildTask::getChildId, childId)
                .eq(ChildTask::getStatus, 1)
                .orderByDesc(ChildTask::getStartTime)
                .last("LIMIT 1"));
        return toVo(log);
    }

    private ChildTaskVo toVo(ChildTask log) {
        if (log == null) return null;
        ChildTaskVo vo = new ChildTaskVo();
        // 简单属性复制 (理想应使用 BeanUtils)
        vo.setLogId(log.getLogId());
        vo.setTaskId(log.getTaskId());
        vo.setChildId(log.getChildId());
        vo.setStatus(log.getStatus());
        vo.setStartTime(log.getStartTime());
        vo.setEndTime(log.getEndTime());
        vo.setActualDuration(log.getActualDuration());
        
        // 关联母版信息 (获取硬件效果代码)
        if (log.getTaskId() != null) {
            vo.setTaskDefinition(parentTaskService.queryById(log.getTaskId()));
        }
        return vo;
    }

    private List<ChildTaskVo> toVoList(List<ChildTask> logs) {
        return logs.stream().map(this::toVo).toList();
    }

    @Override
    public int nfcCheckIn(String nfcId, Long childId) {
        // NFC签到逻辑 (简化：记录一次成功签到)
        return 1;
    }
}
