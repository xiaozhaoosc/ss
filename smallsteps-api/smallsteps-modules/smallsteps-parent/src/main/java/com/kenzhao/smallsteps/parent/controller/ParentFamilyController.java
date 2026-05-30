package com.kenzhao.smallsteps.parent.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.system.domain.bo.SysUserBo;
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
    private final com.kenzhao.smallsteps.child.service.IChildService childService;

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
        List<SysUserVo> list = userService.selectUserListByDept(deptId);
        if (list != null) {
            list = list.stream()
                .filter(u -> !com.kenzhao.smallsteps.common.core.enums.UserStatus.DISABLE.getCode().equals(u.getStatus()))
                .filter(u -> !"admin".equals(u.getUserName()))
                .collect(java.util.stream.Collectors.toList());
        }
        return R.ok(list);
    }

    /**
     * 查询家庭的家长列表
     * 仅返回 userType 为 sys_user 的家长用户
     */
    @Operation(summary = "查询家庭家长列表", description = "返回当前家庭中的所有家长")
    @GetMapping("/parents")
    public R<List<SysUserVo>> getFamilyParents() {
        Long deptId = LoginHelper.getDeptId();
        if (deptId == null) {
            return R.fail("当前用户未关联家庭");
        }
        List<SysUserVo> list = userService.selectUserListByDept(deptId);
        if (list != null) {
            list = list.stream()
                .filter(u -> !com.kenzhao.smallsteps.common.core.enums.UserStatus.DISABLE.getCode().equals(u.getStatus()))
                .filter(u -> !"admin".equals(u.getUserName()))
                .filter(u -> !com.kenzhao.smallsteps.common.core.enums.UserType.CHILD.getUserType().equals(u.getUserType()))
                .collect(java.util.stream.Collectors.toList());
        }
        return R.ok(list);
    }

    /**
     * 查询家庭的儿童列表
     * 仅返回 userType 为 2 的儿童用户，并关联 ss_child 表获取头像等信息
     */
    @Operation(summary = "查询家庭儿童列表", description = "返回当前家庭中的所有儿童及其档案信息")
    @GetMapping("/children")
    public R<List<java.util.Map<String, Object>>> getFamilyChildren() {
        Long deptId = LoginHelper.getDeptId();
        if (deptId == null) {
            return R.fail("当前用户未关联家庭");
        }
        List<SysUserVo> list = userService.selectUserListByDept(deptId);
        if (list == null) {
            return R.ok(java.util.Collections.emptyList());
        }
        List<java.util.Map<String, Object>> children = list.stream()
            .filter(u -> com.kenzhao.smallsteps.common.core.enums.UserType.CHILD.getUserType().equals(u.getUserType()))
            .filter(u -> !com.kenzhao.smallsteps.common.core.enums.UserStatus.DISABLE.getCode().equals(u.getStatus()))
            .map(u -> {
                java.util.Map<String, Object> map = new java.util.LinkedHashMap<>();
                map.put("userId", u.getUserId());
                map.put("userName", u.getUserName());
                map.put("sex", u.getSex());
                map.put("userType", u.getUserType());
                // 关联 ss_child 获取头像和昵称（档案中保存的最新值）
                com.kenzhao.smallsteps.common.ss.domain.Child child = childService.selectChildById(u.getUserId());
                if (child != null) {
                    // 优先使用 ss_child 中的昵称（家长在档案中修改的）
                    String nickname = (child.getNickname() != null && !child.getNickname().isEmpty())
                        ? child.getNickname() : u.getNickName();
                    map.put("nickName", nickname);
                    // 优先使用 ss_child 中的头像 URL（字符串路径）
                    if (child.getAvatarUrl() != null && !child.getAvatarUrl().isEmpty()) {
                        map.put("avatar", child.getAvatarUrl());
                    } else {
                        // SysUserVo.avatar 为 Long 类型（OSS文件ID），直接存入 Object map
                        map.put("avatar", u.getAvatar());
                    }
                } else {
                    map.put("nickName", u.getNickName());
                    map.put("avatar", u.getAvatar());
                }
                return map;
            })
            .collect(java.util.stream.Collectors.toList());
        return R.ok(children);
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

        SysUserVo child = userService.selectUserByUserName(bindDTO.getUserName());
        if (child == null) {
            return R.fail("未找到该儿童账号");
        }

        // 修改儿童的所属部门，直接更新 dept_id 绕过数据权限和角色处理
        return toAjax(userService.updateUserDeptId(child.getUserId(), deptId));
    }

    /**
     * 绑定请求 DTO
     */
    @lombok.Data
    public static class ChildBindDTO {
        private String userName;
    }

    /**
     * 一键创建儿童账户并自动绑定到当前家庭
     */
    @Operation(summary = "创建并绑定儿童账号", description = "在当前家庭下直接为儿童创建登录账号及游戏化档案记录（方案 B 闭环）")
    @PostMapping("/create-child")
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public R<Void> createAndBindChild(@Validated @RequestBody ChildCreateDTO createDTO) {
        Long deptId = LoginHelper.getDeptId();
        if (deptId == null) {
            return R.fail("家长尚未归属任何家庭，请先联系管理员创建家庭。");
        }

        // 1. 校验儿童登录用户名是否已被占用
        SysUserVo existingUser = userService.selectUserByUserName(createDTO.getUsername());
        if (existingUser != null) {
            return R.fail("该登录用户名已被占用");
        }

        // 2. 创建儿童 SysUser 账号记录
        SysUserBo childUserBo = new SysUserBo();
        childUserBo.setUserName(createDTO.getUsername());
        childUserBo.setNickName(createDTO.getNickname());
        childUserBo.setPassword(cn.hutool.crypto.digest.BCrypt.hashpw(createDTO.getPassword()));
        childUserBo.setUserType(com.kenzhao.smallsteps.common.core.enums.UserType.CHILD.getUserType()); // "2"
        childUserBo.setDeptId(deptId); // 直接设为家长的部门（家庭）ID
        
        // 赋予儿童角色 ID，默认使用 11L (即儿童角色)
        childUserBo.setRoleId(11L); 
        
        int rows = userService.insertUser(childUserBo);
        if (rows < 1 || childUserBo.getUserId() == null) {
            throw new com.kenzhao.smallsteps.common.core.exception.ServiceException("创建儿童登录账号失败");
        }

        // 3. 创建儿童在 ss_child 中的游戏化档案记录
        com.kenzhao.smallsteps.common.ss.domain.Child childProfile = new com.kenzhao.smallsteps.common.ss.domain.Child();
        childProfile.setId(childUserBo.getUserId()); // 主键 ID 与账号的 user_id 严格一致
        childProfile.setParentId(LoginHelper.getUserId()); // 绑定当前家长的 user_id 为 parentId
        childProfile.setNickname(createDTO.getNickname());
        childProfile.setGender(createDTO.getGender());
        childProfile.setBirthday(createDTO.getBirthday());
        childProfile.setAvatarUrl("/avatar/boy1.png"); // 默认头像
        childProfile.setLevel(1);
        childProfile.setStarBalance(0);
        childProfile.setTotalStars(0);

        int profileRows = childService.insertChild(childProfile);
        if (profileRows < 1) {
            throw new com.kenzhao.smallsteps.common.core.exception.ServiceException("创建儿童游戏化档案失败");
        }

        return R.ok();
    }

    /**
     * 儿童账号创建 DTO
     */
    @lombok.Data
    public static class ChildCreateDTO {
        @jakarta.validation.constraints.NotBlank(message = "登录用户名不能为空")
        private String username;

        @jakarta.validation.constraints.NotBlank(message = "初始密码不能为空")
        private String password;

        @jakarta.validation.constraints.NotBlank(message = "儿童昵称不能为空")
        private String nickname;

        private String gender; // 性别 (0男 1女 2未知)
        
        @com.fasterxml.jackson.annotation.JsonFormat(pattern = "yyyy-MM-dd")
        private java.util.Date birthday;
    }
}
