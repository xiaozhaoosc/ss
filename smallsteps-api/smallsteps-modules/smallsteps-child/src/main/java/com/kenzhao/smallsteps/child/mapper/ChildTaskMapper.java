package com.kenzhao.smallsteps.child.mapper;

import com.kenzhao.smallsteps.child.domain.ChildTask;
import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Mapper;

/**
 * 儿童任务执行Mapper接口
 *
 * @author 赵轩
 * @date 2026-04-08
 */
@Mapper
public interface ChildTaskMapper extends BaseMapperPlus<ChildTask, ChildTask> {

}
