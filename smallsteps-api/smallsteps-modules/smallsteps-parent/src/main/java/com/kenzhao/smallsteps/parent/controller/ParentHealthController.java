package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 家长端模块健康检查
 */
@RestController
@RequestMapping("/parent/health")
public class ParentHealthController {

    @GetMapping
    public R<String> check() {
        return R.ok("Parent Module is Active");
    }
}
