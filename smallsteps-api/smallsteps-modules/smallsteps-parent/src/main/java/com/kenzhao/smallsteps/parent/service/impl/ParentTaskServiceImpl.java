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

    @Override
    public List<ParentTaskVo> queryList(ParentTaskBo bo) {
        List<ParentTask> list = parentTaskMapper.selectList(new LambdaQueryWrapper<ParentTask>());
        return toVoList(list);
    }

    @Override
    public TableDataInfo<ParentTaskVo> queryPageList(ParentTaskBo bo, PageQuery pageQuery) {
        // 简化实现，实际项目中应该使用分页查询
        List<ParentTask> list = parentTaskMapper.selectList(new LambdaQueryWrapper<ParentTask>());
        List<ParentTaskVo> voList = toVoList(list);
        return TableDataInfo.build(voList);
    }

    @Override
    public ParentTaskVo queryById(Long taskId) {
        ParentTask parentTask = parentTaskMapper.selectById(taskId);
        return toVo(parentTask);
    }

    @Override
    public boolean insertByBo(ParentTaskBo bo) {
        ParentTask parentTask = new ParentTask();
        // 复制属性
        parentTask.setParentId(bo.getParentId());
        parentTask.setUserId(bo.getUserId());
        parentTask.setTitle(bo.getTitle());
        parentTask.setDescription(bo.getDescription());
        parentTask.setStatus(bo.getStatus());
        parentTask.setDifficulty(bo.getDifficulty());
        parentTask.setPromptLevel(bo.getPromptLevel());
        parentTask.setCycleType(bo.getCycleType());
        parentTask.setRewardPoints(bo.getRewardPoints());
        parentTask.setLightEffect(bo.getLightEffect());
        parentTask.setAudioEffect(bo.getAudioEffect());
        parentTask.setCreateBy(bo.getCreateBy());
        parentTask.setCreateTime(bo.getCreateTime());
        parentTask.setUpdateBy(bo.getUpdateBy());
        parentTask.setUpdateTime(bo.getUpdateTime());
        return parentTaskMapper.insert(parentTask) > 0;
    }

    @Override
    public boolean updateByBo(ParentTaskBo bo) {
        ParentTask parentTask = new ParentTask();
        // 复制属性
        parentTask.setTaskId(bo.getTaskId());
        parentTask.setParentId(bo.getParentId());
        parentTask.setUserId(bo.getUserId());
        parentTask.setTitle(bo.getTitle());
        parentTask.setDescription(bo.getDescription());
        parentTask.setStatus(bo.getStatus());
        parentTask.setDifficulty(bo.getDifficulty());
        parentTask.setPromptLevel(bo.getPromptLevel());
        parentTask.setCycleType(bo.getCycleType());
        parentTask.setRewardPoints(bo.getRewardPoints());
        parentTask.setLightEffect(bo.getLightEffect());
        parentTask.setAudioEffect(bo.getAudioEffect());
        parentTask.setUpdateBy(bo.getUpdateBy());
        parentTask.setUpdateTime(bo.getUpdateTime());
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

        // 模拟数据
        result.put("totalTasks", 10);
        result.put("completedTasks", 6);
        result.put("pendingTasks", 4);
        result.put("completionRate", 60);

        return result;
    }

    @Override
    public Map<String, Object> getAbilityRadarByChildId(Long childId) {
        Map<String, Object> result = new HashMap<>();

        // 模拟能力雷达图数据
        List<String> abilities = List.of("专注力", "执行力", "创造力", "社交能力", "情绪管理", "学习能力");
        List<Integer> scores = List.of(75, 80, 65, 70, 60, 85);

        result.put("abilities", abilities);
        result.put("scores", scores);

        return result;
    }

    @Override
    public Map<String, Object> getWeeklyReport(Long childId) {
        Map<String, Object> result = new HashMap<>();

        // 模拟周报告数据
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

        // 模拟月报告数据
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

    /**
     * 转换为VO列表
     */
    private List<ParentTaskVo> toVoList(List<ParentTask> list) {
        List<ParentTaskVo> voList = new ArrayList<>();
        for (ParentTask parentTask : list) {
            voList.add(toVo(parentTask));
        }
        return voList;
    }

    /**
     * 转换为VO
     */
    private ParentTaskVo toVo(ParentTask parentTask) {
        if (parentTask == null) {
            return null;
        }
        ParentTaskVo vo = new ParentTaskVo();
        // 复制属性
        vo.setTaskId(parentTask.getTaskId());
        vo.setUserId(parentTask.getUserId());
        vo.setTitle(parentTask.getTitle());
        vo.setDescription(parentTask.getDescription());
        vo.setStatus(parentTask.getStatus());
        vo.setRewardPoints(parentTask.getRewardPoints());
        vo.setDeadline(parentTask.getDeadline());
        vo.setCreateBy(parentTask.getCreateBy());
        vo.setCreateTime(parentTask.getCreateTime());
        vo.setUpdateBy(parentTask.getUpdateBy());
        vo.setUpdateTime(parentTask.getUpdateTime());

        // 设置状态名称
        vo.setStatusName("1".equals(parentTask.getStatus()) ? "已完成" : "未完成");

        return vo;
    }
}
