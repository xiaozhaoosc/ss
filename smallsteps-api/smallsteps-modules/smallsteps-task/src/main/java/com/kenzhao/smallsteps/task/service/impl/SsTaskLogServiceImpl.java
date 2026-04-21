package com.kenzhao.smallsteps.task.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kenzhao.smallsteps.child.service.IScoreService;
import com.kenzhao.smallsteps.common.core.exception.ServiceException;
import com.kenzhao.smallsteps.task.domain.SsTask;
import com.kenzhao.smallsteps.task.domain.SsTaskLog;
import com.kenzhao.smallsteps.task.mapper.SsTaskLogMapper;
import com.kenzhao.smallsteps.task.mapper.SsTaskMapper;
import com.kenzhao.smallsteps.task.service.ISsTaskLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * 任务执行记录Service业务层处理
 */
@RequiredArgsConstructor
@Service
public class SsTaskLogServiceImpl extends ServiceImpl<SsTaskLogMapper, SsTaskLog> implements ISsTaskLogService {

    private final IScoreService scoreService;
    private final SsTaskMapper taskMapper;

    /** 状态: 进行中 */
    private static final String STATUS_ONGOING = "0";
    /** 状态: 已点亮 (成功) */
    private static final String STATUS_LIGHT_UP = "1";
    /** 状态: 待点亮 (审核中) */
    private static final String STATUS_WAITING_LIGHT_UP = "3";

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean submitTask(Long logId) {
        SsTaskLog log = baseMapper.selectById(logId);
        if (log == null) {
            throw new ServiceException("任务记录不存在");
        }
        if (!STATUS_ONGOING.equals(log.getStatus())) {
            throw new ServiceException("当前任务状态不支持提交");
        }
        
        log.setStatus(STATUS_WAITING_LIGHT_UP);
        log.setFinishTime(new Date());
        return baseMapper.updateById(log) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean lightUp(Long logId) {
        SsTaskLog log = baseMapper.selectById(logId);
        if (log == null) {
            throw new ServiceException("任务记录不存在");
        }
        if (!STATUS_WAITING_LIGHT_UP.equals(log.getStatus())) {
            throw new ServiceException("只能点亮处于[待点亮]状态的任务");
        }

        SsTask task = taskMapper.selectById(log.getTaskId());
        if (task == null) {
            throw new ServiceException("原任务定义已不存在");
        }

        log.setStatus(STATUS_LIGHT_UP);
        log.setUpdateTime(new Date());
        baseMapper.updateById(log);

        String reason = String.format("确认点亮任务星星: %s", task.getTitle());
        boolean success = scoreService.addPoints(log.getChildId(), task.getStarReward(), task.getId(), reason);
        if (!success) {
            throw new ServiceException("星星发放异常，请稍后重试");
        }

        return true;
    }
}
