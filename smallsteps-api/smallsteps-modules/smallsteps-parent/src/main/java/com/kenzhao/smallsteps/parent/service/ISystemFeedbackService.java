package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.bo.SystemFeedbackBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.SystemFeedbackVo;

/**
 * 意见反馈Service接口
 */
public interface ISystemFeedbackService {

    /**
     * 分页查询系统意见反馈列表
     */
    TableDataInfo<SystemFeedbackVo> queryPageList(SystemFeedbackBo bo, PageQuery pageQuery);

    /**
     * 新增系统意见反馈
     */
    Boolean insertByBo(SystemFeedbackBo bo);

    /**
     * 处理/标记反馈为已处理状态
     */
    Boolean processFeedback(Long feedbackId, String remark);
}
