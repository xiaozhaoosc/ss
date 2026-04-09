package com.kenzhao.smallsteps.parent.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.system.domain.SysUser;
import com.kenzhao.smallsteps.system.domain.vo.SysUserVo;
import com.kenzhao.smallsteps.system.service.ISysUserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 家长端 - 家庭管理控制器
 * 
 * @author 赵轩
 * @date 2026-04-09
 */
@Tag(name = "家长端-家庭管理", description = "用于管理家庭成员关系，基于 sys_dept 进行概念映射")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/family")
public class ParentFamilyController extends BaseController {

    private final ISysUserService userService;

    /**
     * 获取家庭成员列表
     * 基于当前家长的 deptId 查询同部门的所有用户（包括其他家长和关联的儿童）
     */
    @Operation(summary = "查询家庭成员列表", description = "返回与当前登录家长处于同一 sys_dept 的所有成员")
    @GetMapping("/members")
    public R<List<SysUserVo>> getFamilyMembers() {
        Long deptId = LoginHelper.getDeptId();
        if (deptId == null) {
            return R.fail("当前用户未关联家庭");
        }
        SysUser userQuery = new SysUser();
        userQuery.setDeptId(deptId);
        List<SysUserVo> list = userService.selectUserList(userQuery);
        return R.ok(list);
    }

    /**
     * 绑定儿童到当前家庭
     * 逻辑：通过用户名或手机号查找到该儿童账号，将其 dept_id 修改为当前家长的 dept_id
     */
    @Operation(summary = "绑定儿童到家庭", description = "将指定儿童账号加入当前家长的家庭组(sys_dept)")
    @PostMapping("/bind-child")
    public R<Void> bindChild(@RequestBody ChildBindDTO bindDTO) {
        Long deptId = LoginHelper.getDeptId();
        if (deptId == null) {
            return R.fail("家长尚未归属任何家庭，请先联系管理员创建家庭。");
        }

        SysUser child = userService.selectUserByUserName(bindDTO.getUserName());
        if (child == null) {
            return R.fail("未找到该儿童账号");
        }

        // 修改儿童的所属部门
        SysUser updateChild = new SysUser();
        updateChild.setUserId(child.getUserId());
        updateChild.setDeptId(deptId);
        
        return toAjax(userService.updateUser(updateChild));
    }

    /**
     * 绑定请求 DTO
     */
    @lombok.Data
    public static class ChildBindDTO {
        private String userName;
    }
}
