package com.kenzhao.smallsteps.task.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.task.domain.SsParentTask;
import com.kenzhao.smallsteps.task.domain.vo.SsParentTaskVO;
import com.kenzhao.smallsteps.task.mapper.SsParentTaskMapper;
import com.kenzhao.smallsteps.task.service.ISsParentTaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 家长任务Service业务层处理
 */
@RequiredArgsConstructor
@Service
public class SsParentTaskServiceImpl extends ServiceImpl<SsParentTaskMapper, SsParentTask> implements ISsParentTaskService {

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean publishTask(SsParentTaskVO taskVO) {
        SsParentTask entity = MapstructUtils.convert(taskVO, SsParentTask.class);
        if (entity == null) {
            return false;
        }
        entity.setStatus("0");
        return baseMapper.insert(entity) > 0;
    }
}
