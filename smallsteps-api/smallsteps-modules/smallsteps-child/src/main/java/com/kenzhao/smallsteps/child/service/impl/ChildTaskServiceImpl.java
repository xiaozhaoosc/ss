package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.child.domain.ChildTask;
import com.kenzhao.smallsteps.child.domain.bo.ChildTaskBo;
import com.kenzhao.smallsteps.child.domain.vo.ChildTaskVo;
import com.kenzhao.smallsteps.child.mapper.ChildTaskMapper;
import com.kenzhao.smallsteps.child.service.IChildTaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 儿童任务执行服务实现
 */
@Service
@RequiredArgsConstructor
public class ChildTaskServiceImpl implements IChildTaskService {

    private final ChildTaskMapper childTaskMapper;

    @Override
    public ChildTaskVo nfcSignin(String nfcId, Long taskId) {
        // 查询任务
        ChildTask task = childTaskMapper.selectById(taskId);
        if (task == null) {
            throw new RuntimeException("任务不存在");
        }

        // 更新任务状态和NFC ID
        task.setStatus("1"); // 已完成
        task.setNfcId(nfcId);
        task.setCompleteTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        childTaskMapper.updateById(task);

        // 转换为VO返回
        return convertToVo(task);
    }

    @Override
    public boolean updateStatus(ChildTaskBo bo) {
        ChildTask task = new ChildTask();
        task.setTaskId(bo.getTaskId());
        task.setStatus(bo.getStatus());
        if ("1".equals(bo.getStatus())) {
            task.setCompleteTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        }
        return childTaskMapper.updateById(task) > 0;
    }

    @Override
    public List<ChildTaskVo> queryListByUserId(Long userId) {
        LambdaQueryWrapper<ChildTask> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChildTask::getUserId, userId);
        List<ChildTask> tasks = childTaskMapper.selectList(wrapper);
        return tasks.stream().map(this::convertToVo).collect(Collectors.toList());
    }

    @Override
    public ChildTaskVo queryById(Long taskId) {
        ChildTask task = childTaskMapper.selectById(taskId);
        return task != null ? convertToVo(task) : null;
    }

    /**
     * 转换为VO
     */
    private ChildTaskVo convertToVo(ChildTask task) {
        ChildTaskVo vo = new ChildTaskVo();
        vo.setTaskId(task.getTaskId());
        vo.setTitle(task.getTitle());
        vo.setDescription(task.getDescription());
        vo.setStatus(task.getStatus());
        vo.setRewardPoints(task.getRewardPoints());
        vo.setStartTime(task.getStartTime());
        vo.setCompleteTime(task.getCompleteTime());
        vo.setVoiceFeedback("任务完成！做得很棒！");
        vo.setLightEffect("green_flash");
        return vo;
    }
}