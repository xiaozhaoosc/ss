package com.kenzhao.smallsteps.parent.service.impl;

import cn.hutool.core.util.IdUtil;
import com.kenzhao.smallsteps.parent.service.IFamilyInviteService;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyInvite;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import com.kenzhao.smallsteps.common.ss.domain.dto.JoinRequestDTO;
import com.kenzhao.smallsteps.common.ss.domain.vo.InviteInfoVo;
import com.kenzhao.smallsteps.parent.mapper.FamilyInviteMapper;
import com.kenzhao.smallsteps.parent.mapper.FamilyJoinRequestMapper;
import com.kenzhao.smallsteps.system.domain.SysDept;
import com.kenzhao.smallsteps.system.domain.SysUser;
import com.kenzhao.smallsteps.system.mapper.SysDeptMapper;
import com.kenzhao.smallsteps.system.mapper.SysUserMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class FamilyInviteServiceImpl implements IFamilyInviteService {

    private final FamilyInviteMapper inviteMapper;
    private final FamilyJoinRequestMapper requestMapper;
    private final SysDeptMapper deptMapper;
    private final SysUserMapper userMapper;

    @Override
    public InviteInfoVo generateInviteCode(Long deptId, Long creatorId) {
        String inviteCode = generateUniqueCode();

        SsFamilyInvite invite = new SsFamilyInvite();
        invite.setDeptId(deptId);
        invite.setInviteCode(inviteCode);
        invite.setCreatorId(creatorId);
        invite.setExpiresAt(LocalDateTime.now().plusDays(7));
        invite.setMaxUses(1);
        invite.setUsedCount(0);
        invite.setStatus("0");
        invite.setDelFlag("0");
        inviteMapper.insert(invite);

        InviteInfoVo vo = new InviteInfoVo();
        vo.setInviteCode(inviteCode);
        vo.setIsValid(true);
        return vo;
    }

    @Override
    public InviteInfoVo validateInviteCode(String inviteCode) {
        SsFamilyInvite invite = inviteMapper.selectByInviteCode(inviteCode);
        InviteInfoVo vo = new InviteInfoVo();
        vo.setInviteCode(inviteCode);

        if (invite == null || !"0".equals(invite.getStatus())) {
            vo.setIsValid(false);
            return vo;
        }
        if (invite.getExpiresAt().isBefore(LocalDateTime.now())) {
            vo.setIsValid(false);
            return vo;
        }
        if (invite.getUsedCount() >= invite.getMaxUses()) {
            vo.setIsValid(false);
            return vo;
        }

        SysDept dept = deptMapper.selectById(invite.getDeptId());
        SysUser creator = userMapper.selectById(invite.getCreatorId());

        vo.setIsValid(true);
        vo.setFamilyName(dept != null ? dept.getDeptName() : "未知家庭");
        vo.setCreatorName(creator != null ? creator.getNickName() : "未知");
        vo.setExpiresAt(invite.getExpiresAt().toString());
        return vo;
    }

    @Override
    public InviteInfoVo getInviteInfo(String inviteCode) {
        return validateInviteCode(inviteCode);
    }

    @Override
    @Transactional
    public void submitJoinRequest(JoinRequestDTO dto, Long applicantId) {
        InviteInfoVo inviteInfo = validateInviteCode(dto.getInviteCode());
        if (!inviteInfo.getIsValid()) {
            throw new RuntimeException("邀请码无效或已过期");
        }

        SysUser applicant = userMapper.selectById(applicantId);
        if (applicant == null) {
            throw new RuntimeException("用户不存在");
        }

        SsFamilyInvite invite = inviteMapper.selectByInviteCode(dto.getInviteCode());
        if (invite == null) {
            throw new RuntimeException("邀请码不存在");
        }

        SsFamilyJoinRequest request = new SsFamilyJoinRequest();
        request.setInviteCode(dto.getInviteCode());
        request.setApplicantId(applicantId);
        request.setTargetDeptId(invite.getDeptId());
        request.setCurrentDeptId(applicant.getDeptId());
        request.setStatus("0");
        request.setDelFlag("0");
        requestMapper.insert(request);
    }

    @Override
    public List<SsFamilyJoinRequest> getPendingRequests(Long deptId) {
        List<SsFamilyJoinRequest> requests = requestMapper.selectPendingByDeptId(deptId);
        for (SsFamilyJoinRequest request : requests) {
            SysUser applicant = userMapper.selectById(request.getApplicantId());
            if (applicant != null) {
                request.setInviteCode(applicant.getNickName());
            }
        }
        return requests;
    }

    @Override
    @Transactional
    public void approveRequest(Long requestId) {
        SsFamilyJoinRequest request = requestMapper.selectById(requestId);
        if (request == null) {
            throw new RuntimeException("申请不存在");
        }

        request.setStatus("1");
        requestMapper.updateById(request);

        SysUser applicant = userMapper.selectById(request.getApplicantId());
        if (applicant != null) {
            applicant.setDeptId(request.getTargetDeptId());
            userMapper.updateById(applicant);
        }

        if (request.getCurrentDeptId() != null) {
            SysDept oldDept = deptMapper.selectById(request.getCurrentDeptId());
            if (oldDept != null) {
                oldDept.setStatus("1");
                deptMapper.updateById(oldDept);
            }
        }

        SsFamilyInvite invite = inviteMapper.selectByInviteCode(request.getInviteCode());
        if (invite != null) {
            invite.setUsedCount(invite.getUsedCount() + 1);
            if (invite.getUsedCount() >= invite.getMaxUses()) {
                invite.setStatus("1");
            }
            inviteMapper.updateById(invite);
        }
    }

    @Override
    public void rejectRequest(Long requestId) {
        SsFamilyJoinRequest request = requestMapper.selectById(requestId);
        if (request == null) {
            throw new RuntimeException("申请不存在");
        }
        request.setStatus("2");
        requestMapper.updateById(request);
    }

    @Override
    public List<SsFamilyJoinRequest> getMyRequests(Long applicantId) {
        return requestMapper.selectByApplicantId(applicantId);
    }

    private String generateUniqueCode() {
        return IdUtil.simpleUUID().substring(0, 8).toUpperCase();
    }
}