package com.kenzhao.smallsteps.parent.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.common.core.utils.StringUtils;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.parent.domain.ParentTask;
import com.kenzhao.smallsteps.parent.domain.bo.ParentTaskBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentTaskVo;
import com.kenzhao.smallsteps.parent.mapper.ParentTaskMapper;
import com.kenzhao.smallsteps.parent.service.IParentTaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 家长任务发布Service业务层处理
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@RequiredArgsConstructor
@Service
public class ParentTaskServiceImpl implements IParentTaskService {

    private final ParentTaskMapper baseMapper;

    /**
     * 查询家长任务发布
     */
    @Override
    public ParentTaskVo queryById(Long taskId) {
        return baseMapper.selectVoById(taskId);
    }

    /**
     * 查询家长任务发布列表
     */
    @Override
    public TableDataInfo<ParentTaskVo> queryPageList(ParentTaskBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ParentTask> lqw = buildQueryWrapper(bo);
        Page<ParentTaskVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询家长任务发布列表
     */
    @Override
    public List<ParentTaskVo> queryList(ParentTaskBo bo) {
        LambdaQueryWrapper<ParentTask> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<ParentTask> buildQueryWrapper(ParentTaskBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<ParentTask> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, ParentTask::getUserId, bo.getUserId());
        lqw.like(StringUtils.isNotBlank(bo.getTitle()), ParentTask::getTitle, bo.getTitle());
        lqw.eq(bo.getDifficulty() != null, ParentTask::getDifficulty, bo.getDifficulty());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), ParentTask::getStatus, bo.getStatus());
        return lqw;
    }

    /**
     * 新增家长任务发布
     */
    @Override
    public Boolean insertByBo(ParentTaskBo bo) {
        ParentTask add = MapstructUtils.convert(bo, ParentTask.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setTaskId(add.getTaskId());
        }
        return flag;
    }

    /**
     * 修改家长任务发布
     */
    @Override
    public Boolean updateByBo(ParentTaskBo bo) {
        ParentTask update = MapstructUtils.convert(bo, ParentTask.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(ParentTask entity) {
        // TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除家长任务发布
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
