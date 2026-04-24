package com.kenzhao.smallsteps.task.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentTaskBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentTaskVo;

import java.util.List;
import java.util.Map;

/**
 * 家长任务发布服务接口
 */
public interface IParentTaskService {
    /**
     * 查询家长任务发布列表
     */
    List<ParentTaskVo> queryList(ParentTaskBo bo);

    /**
     * 查询家长任务发布分页列表
     */
    TableDataInfo<ParentTaskVo> queryPageList(ParentTaskBo bo, PageQuery pageQuery);

    /**
     * 根据任务ID查询家长任务发布
     */
    ParentTaskVo queryById(Long taskId);

    /**
     * 获取子任务列表
     */
    List<ParentTaskVo> selectSubTasks(Long taskId);

    /**
     * 新增家长任务发布
     */
    boolean insertByBo(ParentTaskBo bo);

    /**
     * 修改家长任务发布
     */
    boolean updateByBo(ParentTaskBo bo);

    /**
     * 删除家长任务发布
     */
    boolean deleteWithValidById(Long taskId, boolean isValid);

    /**
     * 批量删除家长任务发布
     */
    boolean deleteWithValidByIds(List<Long> taskIds, boolean isValid);

    /**
     * 获取孩子的任务完成情况
     */
    Map<String, Object> getTaskStatusByChildId(Long childId);

    /**
     * 获取孩子的能力雷达图数据
     */
    Map<String, Object> getAbilityRadarByChildId(Long childId);

    /**
     * 获取孩子的周报告
     */
    Map<String, Object> getWeeklyReport(Long childId);

    /**
     * 获取孩子的月报告
     */
    Map<String, Object> getMonthlyReport(Long childId);

    /**
     * 获取AI总结建议
     */
    String getSummaryInsight(Long childId);

    /**
     * 获取周情绪/表现热力图
     */
    List<Map<String, Object>> getWeeklyHeatmap(Long childId);

    /**
     * 获取周深度AI分析报告
     */
    String getWeeklyAiAnalysis(Long childId);
}
