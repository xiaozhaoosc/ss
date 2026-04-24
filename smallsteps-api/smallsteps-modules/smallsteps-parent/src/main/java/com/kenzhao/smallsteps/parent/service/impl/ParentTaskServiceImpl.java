package com.kenzhao.smallsteps.parent.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentTaskBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentTaskVo;
import com.kenzhao.smallsteps.parent.mapper.ParentTaskMapper;
import com.kenzhao.smallsteps.parent.service.IParentTaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 家长任务发布服务实现
 */
@Service
@RequiredArgsConstructor
public class ParentTaskServiceImpl implements IParentTaskService {

    private final ParentTaskMapper parentTaskMapper;
    private final com.kenzhao.smallsteps.common.ai.service.IAiService aiService;

    @Override
    public List<ParentTaskVo> queryList(ParentTaskBo bo) {
        LambdaQueryWrapper<ParentTask> lqw = buildQueryWrapper(bo);
        List<ParentTask> list = parentTaskMapper.selectList(lqw);
        return toVoList(list);
    }

    @Override
    public TableDataInfo<ParentTaskVo> queryPageList(ParentTaskBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ParentTask> lqw = buildQueryWrapper(bo);
        com.baomidou.mybatisplus.extension.plugins.pagination.Page<ParentTask> page = parentTaskMapper.selectPage(pageQuery.build(), lqw);
        return TableDataInfo.build(page.convert(this::toVo));
    }

    private LambdaQueryWrapper<ParentTask> buildQueryWrapper(ParentTaskBo bo) {
        LambdaQueryWrapper<ParentTask> lqw = new LambdaQueryWrapper<>();
        lqw.eq(bo.getTaskId() != null, ParentTask::getTaskId, bo.getTaskId());
        lqw.eq(bo.getParentId() != null, ParentTask::getParentId, bo.getParentId());
        lqw.eq(bo.getUserId() != null, ParentTask::getUserId, bo.getUserId());
        lqw.eq(bo.getDeptId() != null, ParentTask::getDeptId, bo.getDeptId());
        lqw.like(cn.hutool.core.util.StrUtil.isNotBlank(bo.getTitle()), ParentTask::getTitle, bo.getTitle());
        lqw.eq(cn.hutool.core.util.StrUtil.isNotBlank(bo.getStatus()), ParentTask::getStatus, bo.getStatus());
        return lqw;
    }

    @Override
    public ParentTaskVo queryById(Long taskId) {
        ParentTask parentTask = parentTaskMapper.selectById(taskId);
        return toVo(parentTask);
    }

    @Override
    public boolean insertByBo(ParentTaskBo bo) {
        ParentTask parentTask = new ParentTask();
        cn.hutool.core.bean.BeanUtil.copyProperties(bo, parentTask);
        return parentTaskMapper.insert(parentTask) > 0;
    }

    @Override
    public boolean updateByBo(ParentTaskBo bo) {
        ParentTask parentTask = new ParentTask();
        cn.hutool.core.bean.BeanUtil.copyProperties(bo, parentTask);
        return parentTaskMapper.updateById(parentTask) > 0;
    }

    @Override
    public boolean deleteWithValidById(Long taskId, boolean isValid) {
        return parentTaskMapper.deleteById(taskId) > 0;
    }

    @Override
    public boolean deleteWithValidByIds(List<Long> taskIds, boolean isValid) {
        return parentTaskMapper.deleteBatchIds(taskIds) > 0;
    }

    @Override
    public Map<String, Object> getTaskStatusByChildId(Long childId) {
        Map<String, Object> result = new HashMap<>();
        result.put("totalTasks", 10);
        result.put("completedTasks", 6);
        result.put("pendingTasks", 4);
        result.put("completionRate", 60);
        return result;
    }

    @Override
    public Map<String, Object> getAbilityRadarByChildId(Long childId) {
        Map<String, Object> result = new HashMap<>();
        List<String> abilities = List.of("专注力", "执行力", "创造力", "社交能力", "情绪管理", "学习能力");
        List<Integer> scores = List.of(75, 80, 65, 70, 60, 85);
        result.put("abilities", abilities);
        result.put("scores", scores);
        return result;
    }

    @Override
    public Map<String, Object> getWeeklyReport(Long childId) {
        Map<String, Object> result = new HashMap<>();
        result.put("weekStart", "2026-03-23");
        result.put("weekEnd", "2026-03-29");
        result.put("totalTasks", 8);
        result.put("completedTasks", 6);
        result.put("totalPoints", 120);
        result.put("averageCompletionTime", "30分钟");
        result.put("emotionTrend", List.of(5, 4, 5, 3, 4, 5, 4));
        return result;
    }

    @Override
    public Map<String, Object> getMonthlyReport(Long childId) {
        Map<String, Object> result = new HashMap<>();
        result.put("month", "2026-03");
        result.put("totalTasks", 30);
        result.put("completedTasks", 22);
        result.put("totalPoints", 450);
        result.put("bestDay", "2026-03-15");
        result.put("worstDay", "2026-03-10");
        result.put("abilityImprovement", Map.of("专注力", 10, "执行力", 15, "情绪管理", 5));
        return result;
    }

    @Override
    public List<ParentTaskVo> selectSubTasks(Long taskId) {
        ParentTaskBo bo = new ParentTaskBo();
        bo.setParentId(taskId);
        return queryList(bo);
    }

    @Override
    public String getSummaryInsight(Long childId) {
        // Leo 今天已经完成了 3 个任务，虽然在‘整理书包’时稍微有点分心，但他最后还是靠自己做到了。他现在可能需要一点点休息和您的一个肯定。🌟
        return "Leo 今天已经完成了 3 个任务，虽然在‘整理书包’时稍微有点分心，但他最后还是靠自己做到了。他现在可能需要一点点休息和您的一个肯定。🌟";
    }

    @Override
    public List<Map<String, Object>> getWeeklyHeatmap(Long childId) {
        List<Map<String, Object>> heatmap = new ArrayList<>();
        String[] days = {"周一", "周二", "周三", "周四", "周五", "周六", "周日"};
        int[] levels = {3, 4, 2, 4, 1, 4, 3}; // 0-4 intensity
        String[] statuses = {"稳定", "极佳", "分心", "极佳", "挫折", "极佳", "稳定"};

        for (int i = 0; i < 7; i++) {
            Map<String, Object> day = new HashMap<>();
            day.put("day", days[i]);
            day.put("level", levels[i]);
            day.put("status", statuses[i]);
            heatmap.add(day);
        }
        return heatmap;
    }

    @Override
    public String getWeeklyAiAnalysis(Long childId) {
        // In a real app, this would aggregate task logs and AI logs for the week
        // and send to aiService.chatWithAI or a specialized method.
        return "### 📈 本周成长深度分析\n\n" +
               "**1. 专注力趋势**：\n" +
               "本周 Leo 在上午时段的专注力表现明显优于下午。周二和周四完成了高难度的‘自主阅读’任务，显示出较强的启动动力。\n\n" +
               "**2. 情绪波动观察**：\n" +
               "周五下午出现了一次较大的情绪波动，主要诱因是‘数学作业’的挫折感。但值得注意的是，他在使用‘呼吸灯’功能后，冷静时间缩短了 40%。\n\n" +
               "**3. 建议干预策略**：\n" +
               "- **正向强化**：建议在周六增加一个‘勇气奖励’，肯定他面对困难任务时的坚持。\n" +
               "- **环境优化**：下午时段尝试将任务拆解得更小（每 10 分钟为一个节点）。";
    }

    private List<ParentTaskVo> toVoList(List<ParentTask> list) {
        List<ParentTaskVo> voList = new ArrayList<>();
        for (ParentTask parentTask : list) {
            voList.add(toVo(parentTask));
        }
        return voList;
    }

    private ParentTaskVo toVo(ParentTask parentTask) {
        if (parentTask == null) return null;
        ParentTaskVo vo = new ParentTaskVo();
        cn.hutool.core.bean.BeanUtil.copyProperties(parentTask, vo);
        vo.setStatusName("1".equals(parentTask.getStatus()) ? "已完成" : "未完成");
        
        // Load Sub-tasks if this is a root task
        if (parentTask.getParentId() == null || parentTask.getParentId() == 0) {
            List<ParentTask> subTasks = parentTaskMapper.selectList(new LambdaQueryWrapper<ParentTask>()
                .eq(ParentTask::getParentId, parentTask.getTaskId())
                .orderByAsc(ParentTask::getTaskId)); // Order by ID as a proxy for step order
            if (!subTasks.isEmpty()) {
                List<TaskStepTemplateVo> steps = new ArrayList<>();
                for (ParentTask sub : subTasks) {
                    TaskStepTemplateVo step = new TaskStepTemplateVo();
                    step.setContent(sub.getTitle());
                    step.setExpectedDuration(sub.getRewardPoints()); // Mocking duration with points for now or use difficulty
                    step.setAudioHint(sub.getAudioEffect());
                    steps.add(step);
                }
                vo.setSteps(steps);
            }
        }
        return vo;
    }
}
