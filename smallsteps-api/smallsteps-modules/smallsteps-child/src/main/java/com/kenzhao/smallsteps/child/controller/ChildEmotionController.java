package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.child.service.IChildEmotionService;
import com.kenzhao.smallsteps.common.core.domain.R;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/child/emotion")
public class ChildEmotionController {
    
    private final IChildEmotionService childEmotionService;

    @PostMapping("/submit")
    public R<Void> submitEmotion(@RequestBody EmotionSubmitDto dto) {
        childEmotionService.saveEmotion(dto.getChildId(), dto.getMoodLevel(), dto.getMoodType(), dto.getDescription());
        return R.ok();
    }

    @Data
    public static class EmotionSubmitDto {
        private Long childId;
        private Integer moodLevel;
        private String moodType;
        private String description;
    }
}
