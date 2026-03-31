package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 儿童端模块健康检查
 */
@RestController
@RequestMapping("/child/health")
public class ChildHealthController {

    @GetMapping
    public R<String> check() {
        return R.ok("Child Module is Active");
    }
}
