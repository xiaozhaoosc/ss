package com.kenzhao.smallsteps.task.mapper;

import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 儿童任务执行Mapper接口
 */
@Mapper
public interface ChildTaskMapper extends BaseMapperPlus<ChildTask, ChildTask> {

    @Select("SELECT DISTINCT DATE_FORMAT(end_time, '%Y-%m-%d') FROM ss_task_log WHERE child_id = #{childId} AND status = '2' AND del_flag = '0' ORDER BY end_time DESC")
    List<String> selectFinishedDatesByChildId(@Param("childId") Long childId);

}
