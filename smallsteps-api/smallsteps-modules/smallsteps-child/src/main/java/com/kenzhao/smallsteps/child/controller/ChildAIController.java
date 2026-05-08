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
@cn.dev33.satoken.annotation.SaCheckLogin
@RestController
@RequestMapping("/child/ai")
public class ChildAIController {

    @Autowired
    private IChildAIService childAIService;
    
    @Autowired
    private com.kenzhao.smallsteps.child.service.IChildService childService;

    /**
     * 查询儿童AI交互列表
     */
    @GetMapping("/list")
    public R<List<ChildAI>> list(ChildAI childAI) {
        validateChildAccess(childAI.getChildId());
        List<ChildAI> list = childAIService.selectChildAIList(childAI);
        return R.ok(list);
    }

    /**
     * 根据交互ID查询儿童AI交互
     */
    @GetMapping("/info/{id}")
    public R<ChildAI> info(@PathVariable("id") Long id) {
        ChildAI childAI = childAIService.selectChildAIById(id);
        if (childAI != null) {
            validateChildAccess(childAI.getChildId());
        }
        return R.ok(childAI);
    }

    /**
     * 新增儿童AI交互
     */
    @PostMapping("/add")
    public R<String> add(@RequestBody ChildAI childAI) {
        validateChildAccess(childAI.getChildId());
        int result = childAIService.insertChildAI(childAI);
        return result > 0 ? R.ok("新增成功") : R.fail("新增失败");
    }

    /**
     * 修改儿童AI交互
     */
    @PutMapping("/edit")
    public R<String> edit(@RequestBody ChildAI childAI) {
        validateChildAccess(childAI.getChildId());
        int result = childAIService.updateChildAI(childAI);
        return result > 0 ? R.ok("修改成功") : R.fail("修改失败");
    }

    /**
     * 删除儿童AI交互
     */
    @DeleteMapping("/remove/{id}")
    public R<String> remove(@PathVariable("id") Long id) {
        ChildAI childAI = childAIService.selectChildAIById(id);
        if (childAI != null) {
            validateChildAccess(childAI.getChildId());
        }
        int result = childAIService.deleteChildAIById(id);
        return result > 0 ? R.ok("删除成功") : R.fail("删除失败");
    }

    /**
     * 批量删除儿童AI交互
     */
    @DeleteMapping("/remove/batch")
    public R<String> removeBatch(@RequestBody Long[] ids) {
        // Simple bulk check could be expensive; usually we check at least one or the list
        for (Long id : ids) {
            ChildAI childAI = childAIService.selectChildAIById(id);
            if (childAI != null) validateChildAccess(childAI.getChildId());
        }
        int result = childAIService.deleteChildAIByIds(ids);
        return result > 0 ? R.ok("删除成功") : R.fail("删除失败");
    }

    /**
     * 与AI流式对话
     */
    @cn.dev33.satoken.annotation.SaIgnore
    @GetMapping(value = "/chat/stream", produces = org.springframework.http.MediaType.TEXT_EVENT_STREAM_VALUE)
    public org.springframework.web.servlet.mvc.method.annotation.SseEmitter chatWithAIStream(
            @RequestParam Long childId,
            @RequestParam String userInput,
            @RequestParam(required = false) Integer emotionType) {
        return childAIService.chatWithAIStream(childId, userInput, emotionType);
    }

    /**
     * 与AI对话
     */
    @cn.dev33.satoken.annotation.SaIgnore
    @PostMapping("/chat")
    public R<String> chatWithAI(@RequestParam("childId") Long childId, @RequestParam("userInput") String userInput, @RequestParam(value = "emotionType", defaultValue = "5") Integer emotionType) {
        String response = childAIService.chatWithAI(childId, userInput, emotionType);
        return R.ok("操作成功", response);
    }

    /**
     * 查询儿童最近的AI交互记录
     */
    @GetMapping({"/recent/{childId}", "/recent"})
    public R<List<ChildAI>> recentInteractions(@PathVariable(required = false) Long childId, @RequestParam(value = "childId", required = false) Long qid, @RequestParam(required = false) Long cid, @RequestParam(value = "limit", defaultValue = "10") Integer limit) {
        Long finalChildId = childId != null ? childId : (qid != null ? qid : cid);
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        validateChildAccess(finalChildId);
        List<ChildAI> list = childAIService.selectRecentInteractionsByChildId(finalChildId, limit);
        return R.ok(list);
    }

    /**
     * 查询儿童情绪趋势
     */
    @GetMapping({"/emotion/trend/{childId}", "/emotion/trend"})
    public R<List<ChildAI>> emotionTrend(@PathVariable(required = false) Long childId, @RequestParam(value = "childId", required = false) Long qid, @RequestParam(required = false) Long cid, @RequestParam(value = "days", defaultValue = "7") Integer days) {
        Long finalChildId = childId != null ? childId : (qid != null ? qid : cid);
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        validateChildAccess(finalChildId);
        List<ChildAI> list = childAIService.selectEmotionTrendByChildId(finalChildId, days);
        return R.ok(list);
    }

    /**
     * 校验当前登录用户是否有权访问该儿童数据
     */
    private void validateChildAccess(Long childId) {
        if (childId == null) return;
        
        // 超级管理员拥有所有权限
        if (com.kenzhao.smallsteps.common.satoken.utils.LoginHelper.isSuperAdmin()) {
            return;
        }

        com.kenzhao.smallsteps.common.ss.domain.Child child = childService.selectChildById(childId);
        if (child == null) {
            throw new com.kenzhao.smallsteps.common.core.exception.ServiceException("未找到该儿童业务数据");
        }
        
        Long currentUserId = com.kenzhao.smallsteps.common.satoken.utils.LoginHelper.getUserId();
        Long currentDeptId = com.kenzhao.smallsteps.common.satoken.utils.LoginHelper.getDeptId();
        
        // 允许访问的条件：
        // 1. 当前登录者就是该儿童本人 (child.id == currentUserId)
        // 2. 当前登录者是该儿童绑定的家长 (child.parentId == currentUserId)
        // 3. 当前登录者与该儿童处于同一家庭/部门 (child.createDept == currentDeptId)
        boolean isSelf = child.getId().equals(currentUserId);
        boolean isParent = child.getParentId() != null && child.getParentId().equals(currentUserId);
        boolean isFamilyMember = child.getCreateDept() != null && child.getCreateDept().equals(currentDeptId);
        
        if (!isSelf && !isParent && !isFamilyMember) {
            throw new com.kenzhao.smallsteps.common.core.exception.ServiceException("无权访问该儿童数据");
        }
    }
}
