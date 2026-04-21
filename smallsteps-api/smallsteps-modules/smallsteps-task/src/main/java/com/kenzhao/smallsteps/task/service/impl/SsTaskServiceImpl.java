package com.kenzhao.smallsteps.task.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.task.domain.SsTask;
import com.kenzhao.smallsteps.task.domain.vo.SsTaskVO;
import com.kenzhao.smallsteps.task.mapper.SsTaskMapper;
import com.kenzhao.smallsteps.task.service.ISsTaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 任务配置Service业务层处理
 */
@RequiredArgsConstructor
@Service
public class SsTaskServiceImpl extends ServiceImpl<SsTaskMapper, SsTask> implements ISsTaskService {

    @Override
    public List<SsTaskVO> listByChildId(Long childId) {
        List<SsTask> list = baseMapper.selectList(new LambdaQueryWrapper<SsTask>()
            .eq(SsTask::getChildId, childId)
            .eq(SsTask::getStatus, "0")
            .eq(SsTask::getDelFlag, "0"));
        return MapstructUtils.convert(list, SsTaskVO.class);
    }
}
