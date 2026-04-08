package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 家长端情绪树洞控制器
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/emotion")
public class ParentEmotionController extends BaseController {

    /**
     * 获取情绪录音列表
     */
    @GetMapping("/list")
    public TableDataInfo<?> getEmotionList(PageQuery pageQuery) {
        // TODO: 实现获取情绪录音列表的逻辑
        return TableDataInfo.build(null);
    }

    /**
     * 获取情绪录音详情
     */
    @GetMapping("/{recordId}")
    public R<?> getEmotionDetail(@PathVariable Long recordId) {
        // TODO: 实现获取情绪录音详情的逻辑
        return R.ok("获取情绪录音详情成功");
    }

    /**
     * 回复情绪录音
     */
    @PostMapping("/reply")
    public R<?> replyEmotion(@RequestBody ReplyRequest request) {
        // TODO: 实现回复情绪录音的逻辑
        return R.ok("回复情绪录音成功");
    }

    // 请求参数类
    public static class ReplyRequest {
        private Long recordId;
        private String replyContent;

        public Long getRecordId() {
            return recordId;
        }

        public void setRecordId(Long recordId) {
            this.recordId = recordId;
        }

        public String getReplyContent() {
            return replyContent;
        }

        public void setReplyContent(String replyContent) {
            this.replyContent = replyContent;
        }
    }
}
