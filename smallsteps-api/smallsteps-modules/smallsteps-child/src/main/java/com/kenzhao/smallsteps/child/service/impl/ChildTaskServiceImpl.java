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

    @Override
    public List<ChildTaskVo> selectChildTaskList(ChildTask childTask) {
        List<ChildTask> list = childTaskMapper.selectList(new LambdaQueryWrapper<>(childTask));
        return list.stream().map(this::toVo).collect(Collectors.toList());
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
    public int completeTask(Long taskId, Long childId) {
        return 1;
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

    private ChildTaskVo toVo(ChildTask childTask) {
        if (childTask == null) return null;
        ChildTaskVo vo = new ChildTaskVo();
        vo.setTaskId(childTask.getTaskId());
        vo.setChildId(childTask.getChildId());
        // vo.setChildTaskId(childTask.getChildTaskId()); // Depends on domain
        return vo;
    }
}
