package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.ss.domain.ChildAI;
import com.kenzhao.smallsteps.child.service.IChildAIService;
import com.kenzhao.smallsteps.common.core.domain.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 儿童AI交互Controller
 */
@RestController
@RequestMapping("/child/ai")
public class ChildAIController {

    @Autowired
    private IChildAIService childAIService;

    /**
     * 查询儿童AI交互列表
     */
    @GetMapping("/list")
    public R<List<ChildAI>> list(ChildAI childAI) {
        List<ChildAI> list = childAIService.selectChildAIList(childAI);
        return R.ok(list);
    }

    /**
     * 根据交互ID查询儿童AI交互
     */
    @GetMapping("/info/{aiId}")
    public R<ChildAI> info(@PathVariable("aiId") Long aiId) {
        ChildAI childAI = childAIService.selectChildAIByAiId(aiId);
        return R.ok(childAI);
    }

    /**
     * 新增儿童AI交互
     */
    @PostMapping("/add")
    public R<String> add(@RequestBody ChildAI childAI) {
        int result = childAIService.insertChildAI(childAI);
        return result > 0 ? R.ok("新增成功") : R.fail("新增失败");
    }

    /**
     * 修改儿童AI交互
     */
    @PutMapping("/edit")
    public R<String> edit(@RequestBody ChildAI childAI) {
        int result = childAIService.updateChildAI(childAI);
        return result > 0 ? R.ok("修改成功") : R.fail("修改失败");
    }

    /**
     * 删除儿童AI交互
     */
    @DeleteMapping("/remove/{aiId}")
    public R<String> remove(@PathVariable("aiId") Long aiId) {
        int result = childAIService.deleteChildAIByAiId(aiId);
        return result > 0 ? R.ok("删除成功") : R.fail("删除失败");
    }

    /**
     * 批量删除儿童AI交互
     */
    @DeleteMapping("/remove/batch")
    public R<String> removeBatch(@RequestBody Long[] aiIds) {
        int result = childAIService.deleteChildAIByAiIds(aiIds);
        return result > 0 ? R.ok("删除成功") : R.fail("删除失败");
    }

    /**
     * 与AI对话
     */
    @PostMapping("/chat")
    public R<String> chatWithAI(@RequestParam("childId") Long childId, @RequestParam("userInput") String userInput, @RequestParam(value = "emotionType", defaultValue = "5") Integer emotionType) {
        String response = childAIService.chatWithAI(childId, userInput, emotionType);
        return R.ok(response);
    }

    /**
     * 查询儿童最近的AI交互记录
     */
    @GetMapping("/recent/{childId}")
    public R<List<ChildAI>> recentInteractions(@PathVariable("childId") Long childId, @RequestParam(value = "limit", defaultValue = "10") Integer limit) {
        List<ChildAI> list = childAIService.selectRecentInteractionsByChildId(childId, limit);
        return R.ok(list);
    }

    /**
     * 查询儿童情绪趋势
     */
    @GetMapping("/emotion/trend/{childId}")
    public R<List<ChildAI>> emotionTrend(@PathVariable("childId") Long childId, @RequestParam(value = "days", defaultValue = "7") Integer days) {
        List<ChildAI> list = childAIService.selectEmotionTrendByChildId(childId, days);
        return R.ok(list);
    }
}
