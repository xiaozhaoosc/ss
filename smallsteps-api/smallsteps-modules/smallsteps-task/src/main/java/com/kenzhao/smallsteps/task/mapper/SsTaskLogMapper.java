package com.kenzhao.smallsteps.task.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kenzhao.smallsteps.task.domain.SsTaskLog;
import org.apache.ibatis.annotations.Mapper;

/**
 * 任务执行记录Mapper接口
 */
@Mapper
public interface SsTaskLogMapper extends BaseMapper<SsTaskLog> {
}
