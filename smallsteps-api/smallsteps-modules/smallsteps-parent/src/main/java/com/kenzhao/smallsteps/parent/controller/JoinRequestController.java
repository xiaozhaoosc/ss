package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import com.kenzhao.smallsteps.common.ss.domain.dto.JoinRequestDTO;
import com.kenzhao.smallsteps.common.ss.domain.vo.InviteInfoVo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.parent.service.IFamilyInviteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Tag(name = "加入申请", description = "加入申请相关接口")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/family")
public class JoinRequestController extends BaseController {

    private final IFamilyInviteService familyInviteService;

    @Operation(summary = "获取邀请信息")
    @GetMapping("/invite/info")
    public R<InviteInfoVo> getInviteInfo(@RequestParam String code) {
        return R.ok(familyInviteService.getInviteInfo(code));
    }

    @Operation(summary = "提交加入申请")
    @PostMapping("/join-request")
    public R<Void> submitJoinRequest(@RequestBody JoinRequestDTO dto) {
        Long userId = LoginHelper.getUserId();
        familyInviteService.submitJoinRequest(dto, userId);
        return R.ok();
    }

    @Operation(summary = "获取我的申请列表")
    @GetMapping("/my-requests")
    public R<List<SsFamilyJoinRequest>> getMyRequests() {
        Long userId = LoginHelper.getUserId();
        return R.ok(familyInviteService.getMyRequests(userId));
    }
}