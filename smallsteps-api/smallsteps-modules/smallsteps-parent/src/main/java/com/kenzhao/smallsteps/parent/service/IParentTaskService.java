package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.parent.domain.bo.ParentTaskBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentTaskVo;

import java.util.List;
import java.util.Map;

/**
 * 家长任务发布服务接口
 */
public interface IParentTaskService {
    /**
     * 查询家长任务发布列表
     *
     * @param bo 家长任务发布
     * @return 家长任务发布集合
     */
    public List<ParentTaskVo> queryList(ParentTaskBo bo);

    /**
     * 查询家长任务发布分页列表
     *
     * @param bo 家长任务发布
     * @param pageQuery 分页参数
     * @return 家长任务发布分页列表
     */
    public TableDataInfo<ParentTaskVo> queryPageList(ParentTaskBo bo, PageQuery pageQuery);

    /**
     * 根据任务ID查询家长任务发布
     *
     * @param taskId 任务ID
     * @return 家长任务发布
     */
    public ParentTaskVo queryById(Long taskId);

    /**
     * 新增家长任务发布
     *
     * @param bo 家长任务发布
     * @return 结果
     */
    public boolean insertByBo(ParentTaskBo bo);

    /**
     * 修改家长任务发布
     *
     * @param bo 家长任务发布
     * @return 结果
     */
    public boolean updateByBo(ParentTaskBo bo);

    /**
     * 删除家长任务发布
     *
     * @param taskId 任务ID
     * @return 结果
     */
    public boolean deleteWithValidById(Long taskId, boolean isValid);

    /**
     * 批量删除家长任务发布
     *
     * @param taskIds 需要删除的任务ID集合
     * @param isValid 是否验证
     * @return 结果
     */
    public boolean deleteWithValidByIds(List<Long> taskIds, boolean isValid);

    /**
     * 获取孩子的任务完成情况
     *
     * @param childId 孩子ID
     * @return 任务完成情况
     */
    public Map<String, Object> getTaskStatusByChildId(Long childId);

    /**
     * 获取孩子的能力雷达图数据
     *
     * @param childId 孩子ID
     * @return 能力雷达图数据
     */
    public Map<String, Object> getAbilityRadarByChildId(Long childId);

    /**
     * 获取孩子的周报告
     *
     * @param childId 孩子ID
     * @return 周报告
     */
    public Map<String, Object> getWeeklyReport(Long childId);

    /**
     * 获取孩子的月报告
     *
     * @param childId 孩子ID
     * @return 月报告
     */
    public Map<String, Object> getMonthlyReport(Long childId);
}
