package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import com.kenzhao.smallsteps.common.ss.domain.dto.JoinRequestDTO;
import com.kenzhao.smallsteps.common.ss.domain.vo.InviteInfoVo;
import java.util.List;

public interface IFamilyInviteService {

    InviteInfoVo generateInviteCode(Long deptId, Long creatorId);

    InviteInfoVo validateInviteCode(String inviteCode);

    InviteInfoVo getInviteInfo(String inviteCode);

    void submitJoinRequest(JoinRequestDTO dto, Long applicantId);

    List<SsFamilyJoinRequest> getPendingRequests(Long deptId);

    void approveRequest(Long requestId);

    void rejectRequest(Long requestId);

    List<SsFamilyJoinRequest> getMyRequests(Long applicantId);
}