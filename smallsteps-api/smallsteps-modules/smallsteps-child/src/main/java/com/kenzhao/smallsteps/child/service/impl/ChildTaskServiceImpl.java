package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.ss.domain.vo.ChildTaskVo;
import com.kenzhao.smallsteps.child.mapper.ChildTaskMapper;
import com.kenzhao.smallsteps.child.service.IChildTaskService;
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
    private final com.kenzhao.smallsteps.parent.service.IParentTaskService parentTaskService;

    @Override
    public List<ChildTaskVo> selectChildTaskList(ChildTask childTask) {
        List<ChildTask> list = childTaskMapper.selectList(new LambdaQueryWrapper<>(childTask)
                .orderByDesc(ChildTask::getCreateTime));
        return list.stream().map(this::toVo).collect(Collectors.toList());
    }
    
    // ... other methods ...

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
        return 1;
    }

    @Override
    public int completeTask(Long taskId, Long childId, String proof) {
        LambdaQueryWrapper<ChildTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ChildTask::getTaskId, taskId)
                .eq(ChildTask::getChildId, childId)
                .eq(ChildTask::getStatus, 1); // 正在执行中
        
        ChildTask taskLog = childTaskMapper.selectOne(queryWrapper);
        if (taskLog != null) {
            taskLog.setStatus(2); // 已完成
            taskLog.setEndTime(new java.util.Date());
            taskLog.setProof(proof);
            return childTaskMapper.updateById(taskLog);
        }
        return 0;
    }

    @Override
    public int failTask(Long taskId, Long childId) {
        return 1;
    }

    @Override
    public List<ChildTaskVo> selectPendingTasksByChildId(Long childId) {
        return List.of();
    }

    @Override
    public ChildTaskVo selectCurrentTaskByChildId(Long childId) {
        return null;
    }

    @Override
    public int nfcCheckIn(String nfcId, Long childId) {
        return 1;
    }
}
