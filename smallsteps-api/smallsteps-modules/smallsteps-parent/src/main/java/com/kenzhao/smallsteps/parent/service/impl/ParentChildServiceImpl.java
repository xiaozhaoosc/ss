package com.kenzhao.smallsteps.parent.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.core.constant.SystemConstants;
import com.kenzhao.smallsteps.system.domain.SysDept;
import com.kenzhao.smallsteps.system.domain.SysRole;
import com.kenzhao.smallsteps.system.domain.SysUser;
import com.kenzhao.smallsteps.system.domain.SysUserRole;
import com.kenzhao.smallsteps.common.core.service.ConfigService;
import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
import com.kenzhao.smallsteps.parent.dto.CreateChildRequest;
import com.kenzhao.smallsteps.parent.service.IParentChildService;
import com.kenzhao.smallsteps.system.mapper.SysDeptMapper;
import com.kenzhao.smallsteps.system.mapper.SysRoleMapper;
import com.kenzhao.smallsteps.system.mapper.SysUserMapper;
import com.kenzhao.smallsteps.system.mapper.SysUserRoleMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import cn.hutool.crypto.digest.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 家长创建孩子账号服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ParentChildServiceImpl implements IParentChildService {

    private final SysUserMapper userMapper;
    private final SysUserRoleMapper userRoleMapper;
    private final SysRoleMapper roleMapper;
    private final SysDeptMapper deptMapper;
    private final ConfigService configService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long createChildAccount(CreateChildRequest request) {
        String parentUsername = LoginHelper.getUsername();
        Long parentId = LoginHelper.getUserId();
        
        // 1. 获取家长用户信息
        SysUser parent = userMapper.selectOne(new LambdaQueryWrapper<SysUser>().eq(SysUser::getUserName, parentUsername));
        if (parent == null) {
            throw new RuntimeException("当前登录用户不存在");
        }

        // 2. 检查孩子账号是否已存在
        SysUser existingUser = userMapper.selectOne(new LambdaQueryWrapper<SysUser>().eq(SysUser::getUserName, request.getUsername()));
        if (existingUser != null) {
            throw new RuntimeException("账号已存在");
        }

        // 3. 获取儿童角色ID
        String childRoleId = configService.getConfigValue("ss.child.role");
        if (childRoleId == null || childRoleId.isEmpty()) {
            throw new RuntimeException("未配置儿童角色");
        }

        // 4. 创建孩子用户
        SysUser childUser = new SysUser();
        childUser.setUserName(request.getUsername());
        childUser.setNickName(request.getNickname());
        childUser.setPassword(BCrypt.hashpw(request.getPassword(), BCrypt.gensalt()));
        childUser.setDeptId(parent.getDeptId()); // 继承家长的家庭部门
        childUser.setStatus(SystemConstants.NORMAL);
        
        // 设置可选字段
        if (request.getGender() != null) {
            childUser.setSex(request.getGender());
        }
        
        // 设置创建者信息
        childUser.setCreateBy(parentId);
        childUser.setUpdateBy(parentId);

        // 5. 保存用户
        userMapper.insert(childUser);
        
        // 6. 关联角色
        SysUserRole userRole = new SysUserRole();
        userRole.setUserId(childUser.getUserId());
        userRole.setRoleId(Long.valueOf(childRoleId));
        userRoleMapper.insert(userRole);

        log.info("家长 {} 创建孩子账号成功: {}", parentUsername, request.getUsername());
        return childUser.getUserId();
    }
}