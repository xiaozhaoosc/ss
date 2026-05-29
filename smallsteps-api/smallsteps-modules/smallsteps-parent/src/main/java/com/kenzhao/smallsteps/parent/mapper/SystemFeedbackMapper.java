package com.kenzhao.smallsteps.parent.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.common.ss.domain.SystemFeedback;
import com.kenzhao.smallsteps.common.ss.domain.vo.SystemFeedbackVo;
import com.kenzhao.smallsteps.common.ss.domain.bo.SystemFeedbackBo;
import org.apache.ibatis.annotations.Param;

/**
 * 意见反馈Mapper接口
 */
public interface SystemFeedbackMapper extends BaseMapperPlus<SystemFeedback, SystemFeedbackVo> {

    /**
     * 联表分页查询系统反馈列表
     */
    Page<SystemFeedbackVo> selectFeedbackPage(Page<SystemFeedbackVo> page, @Param("query") SystemFeedbackBo bo);
}
