package com.kenzhao.smallsteps.system.controller.system;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

/**
 * 能量森林 (Forest) 控制器
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/forest")
public class ForestController extends BaseController {

    /**
     * 获取小树成长状态
     */
    @GetMapping("/status/{childId}")
    public R<Map<String, Object>> getStatus(@PathVariable Long childId) {
        Map<String, Object> data = new HashMap<>();
        data.put("level", 2);
        data.put("height", 125);
        data.put("energy", 450);
        data.put("nextLevelExp", 500);
        return R.ok(data);
    }

    /**
     * 灌溉
     */
    @PostMapping("/irrigate")
    public R<Map<String, Object>> irrigate(@RequestBody Map<String, Object> params) {
        // 模拟灌溉逻辑
        Map<String, Object> result = new HashMap<>();
        result.put("addedHeight", 5);
        result.put("newHeight", 130);
        result.put("remainingEnergy", 440);
        return R.ok(result);
    }
}
