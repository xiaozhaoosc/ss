package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import com.kenzhao.smallsteps.common.ss.domain.vo.InviteInfoVo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.parent.service.IFamilyInviteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Tag(name = "家庭邀请", description = "家庭邀请相关接口")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/family/invite")
public class FamilyInviteController extends BaseController {

    private final IFamilyInviteService familyInviteService;

    @Operation(summary = "生成分享链接和邀请码")
    @PostMapping("/generate")
    public R<InviteInfoVo> generate() {
        Long userId = LoginHelper.getUserId();
        Long deptId = LoginHelper.getDeptId();
        return R.ok(familyInviteService.generateInviteCode(deptId, userId));
    }

    @Operation(summary = "验证邀请码")
    @GetMapping("/validate")
    public R<InviteInfoVo> validate(@RequestParam String code) {
        return R.ok(familyInviteService.validateInviteCode(code));
    }

    @Operation(summary = "获取待审核的加入申请列表")
    @GetMapping("/requests")
    public R<List<SsFamilyJoinRequest>> getPendingRequests() {
        Long deptId = LoginHelper.getDeptId();
        return R.ok(familyInviteService.getPendingRequests(deptId));
    }

    @Operation(summary = "批准加入申请")
    @PostMapping("/request/{id}/approve")
    public R<Void> approve(@PathVariable Long id) {
        familyInviteService.approveRequest(id);
        return R.ok();
    }

    @Operation(summary = "拒绝加入申请")
    @PostMapping("/request/{id}/reject")
    public R<Void> reject(@PathVariable Long id) {
        familyInviteService.rejectRequest(id);
        return R.ok();
    }
}