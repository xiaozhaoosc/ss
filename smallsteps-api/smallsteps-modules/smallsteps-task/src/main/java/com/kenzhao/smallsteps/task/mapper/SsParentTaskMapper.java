package com.kenzhao.smallsteps.task.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kenzhao.smallsteps.task.domain.SsParentTask;
import org.apache.ibatis.annotations.Mapper;

/**
 * 家长任务Mapper接口
 */
@Mapper
public interface SsParentTaskMapper extends BaseMapper<SsParentTask> {
}
