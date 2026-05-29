package com.kenzhao.smallsteps.parent.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.SystemFeedback;
import com.kenzhao.smallsteps.common.ss.domain.bo.SystemFeedbackBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.SystemFeedbackVo;
import com.kenzhao.smallsteps.parent.mapper.SystemFeedbackMapper;
import com.kenzhao.smallsteps.parent.service.ISystemFeedbackService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 意见反馈Service业务层处理实现类
 */
@RequiredArgsConstructor
@Service
public class SystemFeedbackServiceImpl implements ISystemFeedbackService {

    private final SystemFeedbackMapper baseMapper;

    /**
     * 分页查询系统意见反馈列表 (多表 Left Join 分页实现)
     */
    @Override
    public TableDataInfo<SystemFeedbackVo> queryPageList(SystemFeedbackBo bo, PageQuery pageQuery) {
        Page<SystemFeedbackVo> result = baseMapper.selectFeedbackPage(pageQuery.build(), bo);
        return TableDataInfo.build(result);
    }

    /**
     * 新增系统意见反馈
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean insertByBo(SystemFeedbackBo bo) {
        SystemFeedback add = MapstructUtils.convert(bo, SystemFeedback.class);
        add.setStatus("0"); // 默认：0-未处理
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setFeedbackId(add.getFeedbackId());
        }
        return flag;
    }

    /**
     * 处理/标记反馈为已处理状态
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean processFeedback(Long feedbackId, String remark) {
        SystemFeedback update = new SystemFeedback();
        update.setFeedbackId(feedbackId);
        update.setStatus("1"); // 标记为已处理：1
        update.setRemark(remark);
        return baseMapper.updateById(update) > 0;
    }
}
