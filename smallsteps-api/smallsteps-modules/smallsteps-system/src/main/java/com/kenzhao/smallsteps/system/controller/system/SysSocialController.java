package com.kenzhao.smallsteps.system.controller.system;

import lombok.RequiredArgsConstructor;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.system.domain.vo.SysSocialVo;
import com.kenzhao.smallsteps.system.service.ISysSocialService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 社会化关系
 *
 * @author 赵轩
 * @date 2023-06-16
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/social")
public class SysSocialController extends BaseController {

    private final ISysSocialService socialUserService;

    /**
     * 查询社会化关系列表
     */
    @GetMapping("/list")
    public R<List<SysSocialVo>> list() {
        return R.ok(socialUserService.queryListByUserId(LoginHelper.getUserId()));
    }

}
