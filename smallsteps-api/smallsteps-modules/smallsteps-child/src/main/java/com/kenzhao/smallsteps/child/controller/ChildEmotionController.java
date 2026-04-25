package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.child.service.IChildEmotionService;
import com.kenzhao.smallsteps.common.core.domain.R;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@cn.dev33.satoken.annotation.SaCheckLogin
@RequiredArgsConstructor
@RestController
@RequestMapping("/child/emotion")
public class ChildEmotionController {
    
    private final IChildEmotionService childEmotionService;
    private final com.kenzhao.smallsteps.child.service.IChildService childService;

    @PostMapping("/submit")
    public R<Void> submitEmotion(@RequestBody EmotionSubmitDto dto) {
        validateChildAccess(dto.getChildId());
        childEmotionService.saveEmotion(dto.getChildId(), dto.getMoodLevel(), dto.getMoodType(), dto.getDescription());
        return R.ok();
    }

    /**
     * 校验当前登录家长是否有权访问该儿童数据
     */
    private void validateChildAccess(Long childId) {
        if (childId == null) return;
        com.kenzhao.smallsteps.common.ss.domain.Child child = childService.selectChildById(childId);
        Long currentUserId = com.kenzhao.smallsteps.common.satoken.utils.LoginHelper.getUserId();
        if (child == null || !child.getParentId().equals(currentUserId)) {
            throw new com.kenzhao.smallsteps.common.core.exception.ServiceException("无权访问该儿童数据");
        }
    }

    @Data
    public static class EmotionSubmitDto {
        private Long childId;
        private Integer moodLevel;
        private String moodType;
        private String description;
    }
}
