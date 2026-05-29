package com.kenzhao.smallsteps.parent.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.core.validate.AddGroup;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.common.ss.domain.bo.SystemFeedbackBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.SystemFeedbackVo;
import com.kenzhao.smallsteps.parent.service.ISystemFeedbackService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 系统意见反馈控制器
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/feedback")
public class SystemFeedbackController extends BaseController {

    private final ISystemFeedbackService feedbackService;

    /**
     * 查询系统意见反馈列表 (Web 后台使用)
     */
    @SaCheckPermission("smallsteps:feedback:list")
    @GetMapping("/list")
    public TableDataInfo<SystemFeedbackVo> list(SystemFeedbackBo bo, PageQuery pageQuery) {
        return feedbackService.queryPageList(bo, pageQuery);
    }

    /**
     * 新增意见反馈 (APP 移动端使用)
     */
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody SystemFeedbackBo bo) {
        // 安全拦截：强制自动提取当前登录用户的 userId，杜绝越权或虚假数据
        Long loginUserId = LoginHelper.getUserId();
        bo.setUserId(loginUserId);
        return toAjax(feedbackService.insertByBo(bo));
    }

    /**
     * 处理/标记反馈为已处理状态 (Web 后台使用)
     */
    @SaCheckPermission("smallsteps:feedback:edit")
    @PutMapping("/status")
    public R<Void> process(@RequestBody SystemFeedbackBo bo) {
        if (bo.getFeedbackId() == null) {
            return R.fail("反馈ID不能为空");
        }
        return toAjax(feedbackService.processFeedback(bo.getFeedbackId(), bo.getRemark()));
    }
}
