package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.parent.dto.CreateChildRequest;
import com.kenzhao.smallsteps.parent.service.IParentChildService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 家长创建孩子账号控制器
 */
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/parent/child")
public class ParentChildController {

    private final IParentChildService parentChildService;

    /**
     * 创建孩子账号
     * 
     * @param request 创建请求
     * @return 创建结果
     */
    @PostMapping("/create")
    public ResponseEntity<R<Map<String, Object>>> createChildAccount(@Valid @RequestBody CreateChildRequest request) {
        try {
            Long childId = parentChildService.createChildAccount(request);
            
            Map<String, Object> result = new HashMap<>();
            result.put("userId", childId);
            result.put("username", request.getUsername());
            result.put("nickname", request.getNickname());
            
            return ResponseEntity.ok(R.ok(result, "创建成功"));
        } catch (RuntimeException e) {
            log.warn("创建孩子账号失败: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(R.fail(e.getMessage()));
        }
    }
}