package com.kenzhao.smallsteps.task.mapper;

import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentTaskVo;
import org.apache.ibatis.annotations.Mapper;

/**
 * 家长任务发布Mapper接口
 */
@Mapper
public interface ParentTaskMapper extends BaseMapperPlus<ParentTask, ParentTaskVo> {
}
