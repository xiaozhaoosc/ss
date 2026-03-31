package com.kenzhao.smallsteps.workflow.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import com.kenzhao.smallsteps.workflow.domain.bo.FlowInstanceBo;
import com.kenzhao.smallsteps.workflow.domain.vo.FlowInstanceVo;

/**
 * 实例信息Mapper接口
 *
 * @author 赵轩
 * @date 2024-03-02
 */
public interface FlwInstanceMapper {

    /**
     * 流程实例信息
     *
     * @param page         分页
     * @param queryWrapper 条件
     * @return 结果
     */
    Page<FlowInstanceVo> selectInstanceList(@Param("page") Page<FlowInstanceVo> page, @Param(Constants.WRAPPER) Wrapper<FlowInstanceBo> queryWrapper);

}
