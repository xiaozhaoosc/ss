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
    @GetMapping("/info/{id}")
    public R<ChildAI> info(@PathVariable("id") Long id) {
        ChildAI childAI = childAIService.selectChildAIById(id);
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
    @DeleteMapping("/remove/{id}")
    public R<String> remove(@PathVariable("id") Long id) {
        int result = childAIService.deleteChildAIById(id);
        return result > 0 ? R.ok("删除成功") : R.fail("删除失败");
    }

    /**
     * 批量删除儿童AI交互
     */
    @DeleteMapping("/remove/batch")
    public R<String> removeBatch(@RequestBody Long[] ids) {
        int result = childAIService.deleteChildAIByIds(ids);
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
    @GetMapping({"/recent/{childId}", "/recent"})
    public R<List<ChildAI>> recentInteractions(@PathVariable(required = false) Long childId, @RequestParam(required = false) Long cid, @RequestParam(value = "limit", defaultValue = "10") Integer limit) {
        Long finalChildId = childId != null ? childId : cid;
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        List<ChildAI> list = childAIService.selectRecentInteractionsByChildId(finalChildId, limit);
        return R.ok(list);
    }

    /**
     * 查询儿童情绪趋势
     */
    @GetMapping({"/emotion/trend/{childId}", "/emotion/trend"})
    public R<List<ChildAI>> emotionTrend(@PathVariable(required = false) Long childId, @RequestParam(required = false) Long cid, @RequestParam(value = "days", defaultValue = "7") Integer days) {
        Long finalChildId = childId != null ? childId : cid;
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        List<ChildAI> list = childAIService.selectEmotionTrendByChildId(finalChildId, days);
        return R.ok(list);
    }
}
