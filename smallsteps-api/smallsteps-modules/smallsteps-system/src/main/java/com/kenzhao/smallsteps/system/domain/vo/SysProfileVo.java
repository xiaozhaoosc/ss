package com.kenzhao.smallsteps.system.domain.vo;

/**
 * 用户个人信息
 *
 * @param user      用户信息
 * @param roleGroup 用户所属角色组
 * @param postGroup 用户所属岗位组
 * @author 赵轩
 */
public record SysProfileVo(ProfileUserVo user, String roleGroup, String postGroup) {
}
