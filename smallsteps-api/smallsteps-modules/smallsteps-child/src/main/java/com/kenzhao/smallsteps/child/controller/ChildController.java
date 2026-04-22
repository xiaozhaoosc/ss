package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.ss.domain.Child;
import com.kenzhao.smallsteps.child.service.IChildService;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 儿童信息控制层
 *
 * @author 赵轩
 * @date 2026-04-14
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/ss/child")
public class ChildController extends BaseController {

    private final IChildService childService;

    /**
     * 查询儿童信息列表
     */
    @GetMapping("/list")
    public R<List<Child>> list(Child child) {
        List<Child> list = childService.selectChildList(child);
        return R.ok(list);
    }

    /**
     * 获取儿童信息详细信息
     */
    @GetMapping(value = "/{id}")
    public R<Child> getInfo(@PathVariable("id") Long id) {
        return R.ok(childService.selectChildById(id));
    }

    /**
     * 新增儿童信息
     */
    @PostMapping
    public R<Void> add(@RequestBody Child child) {
        return toAjax(childService.insertChild(child));
    }

    /**
     * 修改儿童信息
     */
    @PutMapping
    public R<Void> edit(@RequestBody Child child) {
        return toAjax(childService.updateChild(child));
    }

    /**
     * 删除儿童信息
     */
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable Long[] ids) {
        return toAjax(childService.deleteChildByIds(ids));
    }
}
