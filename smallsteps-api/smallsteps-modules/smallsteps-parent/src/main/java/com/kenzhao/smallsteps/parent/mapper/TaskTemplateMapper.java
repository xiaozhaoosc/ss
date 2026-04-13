package com.kenzhao.smallsteps.parent.mapper;

import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.common.ss.domain.TaskTemplate;
import com.kenzhao.smallsteps.common.ss.domain.vo.TaskTemplateVo;
import org.apache.ibatis.annotations.Mapper;

/**
 * ADHD 任务模板Mapper
 */
@Mapper
public interface TaskTemplateMapper extends BaseMapperPlus<TaskTemplate, TaskTemplateVo> {
}
