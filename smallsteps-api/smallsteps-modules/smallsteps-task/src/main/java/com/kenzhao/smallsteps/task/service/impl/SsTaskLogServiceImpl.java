package com.kenzhao.smallsteps.task.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kenzhao.smallsteps.common.core.exception.ServiceException;
import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
import com.kenzhao.smallsteps.task.mapper.ChildTaskMapper;
import com.kenzhao.smallsteps.task.mapper.ParentTaskMapper;
import com.kenzhao.smallsteps.task.service.ISsTaskLogService;
import com.kenzhao.smallsteps.task.event.TaskLitUpEvent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * 任务执行记录Service业务层处理
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class SsTaskLogServiceImpl extends ServiceImpl<ChildTaskMapper, ChildTask> implements ISsTaskLogService {

    private final ApplicationEventPublisher eventPublisher;
    private final ParentTaskMapper parentTaskMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean submitTask(Long logId) {
        ChildTask taskLog = baseMapper.selectById(logId);
        if (taskLog == null) {
            throw new ServiceException("任务记录不存在");
        }
        if (!ChildTask.STATUS_ONGOING.equals(taskLog.getStatus())) {
            throw new ServiceException("当前任务状态不支持提交");
        }
        
        taskLog.setStatus(ChildTask.STATUS_FINISHED);
        taskLog.setEndTime(new Date());
        if (taskLog.getTargetDate() == null) {
            taskLog.setTargetDate(new Date());
        }
        boolean success = baseMapper.updateById(taskLog) > 0;

        if (success) {
            // [ADHD UX] Instant Gratification - Award stars immediately upon submission
            ParentTask task = parentTaskMapper.selectById(taskLog.getTaskId());
            if (task != null) {
                int points = task.getRewardPoints() != null ? task.getRewardPoints() : 10;
                eventPublisher.publishEvent(new TaskLitUpEvent(this, logId, taskLog.getChildId(), points, task.getTaskId(), task.getTitle()));
                log.info("[ADHD] Task {} submitted by child {}, instant reward issued: {} stars", logId, taskLog.getChildId(), points);
            }
        }
        return success;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean lightUp(Long logId) {
        ChildTask taskLog = baseMapper.selectById(logId);
        if (taskLog == null) {
            throw new ServiceException("任务记录不存在");
        }
        if (!ChildTask.STATUS_FINISHED.equals(taskLog.getStatus())) {
            throw new ServiceException("只能点亮处于[待点亮]状态的任务");
        }

        // 使用 ParentTask 作为任务定义的唯一来源
        ParentTask task = parentTaskMapper.selectById(taskLog.getTaskId());
        if (task == null) {
            throw new ServiceException("任务定义不存在或已被删除");
        }

        taskLog.setStatus(ChildTask.STATUS_LIGHT_UP);
        taskLog.setUpdateTime(new Date());
        baseMapper.updateById(taskLog);

        // 发布事件，由儿童端监听并处理积分
        // 注意：ParentTask 使用 rewardPoints，SsTask 使用 starReward，这里统一使用 rewardPoints
        int points = task.getRewardPoints() != null ? task.getRewardPoints() : 0;
        eventPublisher.publishEvent(new TaskLitUpEvent(this, logId, taskLog.getChildId(), points, task.getTaskId(), task.getTitle()));

        return true;
    }
}
