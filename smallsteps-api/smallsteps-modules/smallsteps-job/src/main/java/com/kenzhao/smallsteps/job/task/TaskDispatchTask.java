package com.kenzhao.smallsteps.job.task;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
import com.kenzhao.smallsteps.task.mapper.ChildTaskMapper;
import com.kenzhao.smallsteps.task.mapper.ParentTaskMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import java.util.Date;
import java.util.List;

@Slf4j
@Component("taskDispatchTask")
@RequiredArgsConstructor
public class TaskDispatchTask {

    private final ParentTaskMapper parentTaskMapper;
    private final ChildTaskMapper childTaskMapper;

    /**
     * 定时生成每日循环任务
     * 建议每天凌晨执行 (e.g. 0 0 1 * * ?)
     */
    public void dispatchDailyTasks() {
        log.info("[Job] Starting dispatchDailyTasks job...");
        try {
            // 1. 获取所有状态为进行中(0)且设为每日重复(1)的父级主任务 (parentId 为空或0)
            List<ParentTask> activeDailyTasks = parentTaskMapper.selectList(new LambdaQueryWrapper<ParentTask>()
                .eq(ParentTask::getCycleType, 1)
                .eq(ParentTask::getStatus, "0")
                .and(w -> w.isNull(ParentTask::getParentId).or().eq(ParentTask::getParentId, 0L))
            );

            log.info("[Job] Found {} active daily repeating tasks to process.", activeDailyTasks.size());

            Date todayStart = cn.hutool.core.date.DateUtil.beginOfDay(new Date());
            Date todayEnd = cn.hutool.core.date.DateUtil.endOfDay(new Date());

            int createdCount = 0;

            for (ParentTask parentTask : activeDailyTasks) {
                // 找到该任务关联的所有执行儿童。策略是：找到该 taskId 曾经被指派过的所有不同 childId
                List<ChildTask> pastAssignments = childTaskMapper.selectList(new LambdaQueryWrapper<ChildTask>()
                    .eq(ChildTask::getTaskId, parentTask.getTaskId())
                );
                
                // 内存去重 childId
                java.util.Set<Long> childIds = new java.util.HashSet<>();
                for (ChildTask assignment : pastAssignments) {
                    if (assignment.getChildId() != null) {
                        childIds.add(assignment.getChildId());
                    }
                }

                for (Long childId : childIds) {
                    // 2. 检查该儿童今天是否已经有了该任务的今日执行记录
                    Long count = childTaskMapper.selectCount(new LambdaQueryWrapper<ChildTask>()
                        .eq(ChildTask::getTaskId, parentTask.getTaskId())
                        .eq(ChildTask::getChildId, childId)
                        .ge(ChildTask::getTargetDate, todayStart)
                        .le(ChildTask::getTargetDate, todayEnd)
                    );

                    if (count == 0) {
                        // 3. 为该儿童创建今天的 ChildTask 执行记录
                        ChildTask newChildTask = new ChildTask();
                        newChildTask.setTaskId(parentTask.getTaskId());
                        newChildTask.setChildId(childId);
                        newChildTask.setDeptId(parentTask.getDeptId());
                        newChildTask.setStatus("0"); // Ongoing / 进行中
                        newChildTask.setDelFlag("0");
                        newChildTask.setTargetDate(new Date());
                        
                        childTaskMapper.insert(newChildTask);
                        log.info("[Job] Successfully dispatched daily task {} to child {}", parentTask.getTaskId(), childId);
                        createdCount++;
                    }
                }
            }
            log.info("[Job] dispatchDailyTasks job completed. Dispatched {} tasks.", createdCount);
        } catch (Exception e) {
            log.error("[Job Error] Failed to execute dispatchDailyTasks", e);
        }
    }
}
