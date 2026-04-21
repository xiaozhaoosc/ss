package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.parent.service.IParentTaskService;
import com.kenzhao.smallsteps.child.service.IScoreService;
import com.kenzhao.smallsteps.child.service.IChildAIService;
import com.kenzhao.smallsteps.common.ss.domain.ChildAI;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 家长成长观察
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/insight")
public class ParentInsightController extends BaseController {

    private final IParentTaskService parentTaskService;
    private final IScoreService scoreService;
    private final IChildAIService childAIService;

    /**
     * 获取孩子的任务完成情况
     */
    @GetMapping("/task/status/{childId}")
    public R<Map<String, Object>> getTaskStatus(@PathVariable Long childId) {
        Map<String, Object> result = parentTaskService.getTaskStatusByChildId(childId);
        return R.ok(result);
    }

    /**
     * 获取孩子的情绪日报
     */
    @GetMapping({"/emotion/daily/{childId}", "/emotion/daily"})
    public R<List<ChildAI>> getEmotionDaily(@PathVariable(required = false) Long childId, @RequestParam(required = false) Long cid) {
        Long finalChildId = childId != null ? childId : cid;
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        List<ChildAI> emotions = childAIService.selectEmotionTrendByChildId(finalChildId, 1);
        return R.ok(emotions);
    }

    /**
     * 获取孩子的情绪趋势
     */
    @GetMapping({"/emotion/trend/{childId}", "/emotion/trend"})
    public R<List<ChildAI>> getEmotionTrend(@PathVariable(required = false) Long childId, @RequestParam(required = false) Long cid, @RequestParam(defaultValue = "7") Integer days) {
        Long finalChildId = childId != null ? childId : cid;
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        List<ChildAI> emotions = childAIService.selectEmotionTrendByChildId(finalChildId, days);
        return R.ok(emotions);
    }

    /**
     * 获取孩子的能力雷达图数据
     */
    @GetMapping("/ability/radar/{childId}")
    public R<Map<String, Object>> getAbilityRadar(@PathVariable Long childId) {
        Map<String, Object> radarData = parentTaskService.getAbilityRadarByChildId(childId);
        return R.ok(radarData);
    }

    /**
     * 获取孩子的积分历史
     */
    @GetMapping("/score/history/{childId}")
    public TableDataInfo<Map<String, Object>> getScoreHistory(@PathVariable Long childId, PageQuery pageQuery) {
        return scoreService.getScoreHistory(childId, pageQuery);
    }

    /**
     * 获取孩子的周报告
     */
    @GetMapping("/report/weekly/{childId}")
    public R<Map<String, Object>> getWeeklyReport(@PathVariable Long childId) {
        Map<String, Object> report = parentTaskService.getWeeklyReport(childId);
        return R.ok(report);
    }

    /**
     * 获取孩子的月报告
     */
    @GetMapping("/report/monthly/{childId}")
    public R<Map<String, Object>> getMonthlyReport(@PathVariable Long childId) {
        Map<String, Object> report = parentTaskService.getMonthlyReport(childId);
        return R.ok(report);
    }
}
