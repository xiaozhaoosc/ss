package com.kenzhao.smallsteps.task.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kenzhao.smallsteps.task.domain.SsTask;
import org.apache.ibatis.annotations.Mapper;

/**
 * 任务配置Mapper接口
 */
@Mapper
public interface SsTaskMapper extends BaseMapper<SsTask> {
}
