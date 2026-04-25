package com.kenzhao.smallsteps;

import com.kenzhao.smallsteps.task.mapper.ChildTaskMapper;
import com.kenzhao.smallsteps.task.mapper.ParentTaskMapper;
import com.kenzhao.smallsteps.child.mapper.ChildAIMapper;
import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
import com.kenzhao.smallsteps.common.ss.domain.ChildAI;
import com.kenzhao.smallsteps.common.ss.domain.ParentReward;
import com.kenzhao.smallsteps.parent.mapper.ParentRewardMapper;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.Random;

@SpringBootTest
@Tag("dev")
public class TestDataGeneratorIT {

    @Autowired
    private ChildTaskMapper childTaskMapper;
    @Autowired
    private ParentTaskMapper parentTaskMapper;
    @Autowired
    private ChildAIMapper childAiMapper;
    @Autowired
    private ParentRewardMapper parentRewardMapper;

    @Test
    @Transactional
    @Rollback(false)
    public void generateData() {
        Long parentId = 2035392423676469250L;
        Long child1 = 10001L;
        Long child2 = 10002L;

        System.out.println("Cleaning up old data...");
        childTaskMapper.delete(new LambdaQueryWrapper<ChildTask>().in(ChildTask::getChildId, child1, child2));
        childAiMapper.delete(new LambdaQueryWrapper<ChildAI>().in(ChildAI::getChildId, child1, child2));
        parentTaskMapper.delete(new LambdaQueryWrapper<ParentTask>().in(ParentTask::getUserId, child1, child2));
        parentRewardMapper.delete(new LambdaQueryWrapper<ParentReward>().eq(ParentReward::getUserId, parentId));

        System.out.println("Inserting parent tasks...");
        insertParentTask(child1, "整理书包", 1, 10, "1");
        insertParentTask(child1, "背诵古诗", 2, 20, "1");
        insertParentTask(child1, "数学口算", 2, 15, "1");
        insertParentTask(child1, "跳绳100下", 3, 30, "1");
        insertParentTask(child1, "自主阅读", 1, 10, "1");
        insertParentTask(child1, "打扫房间", 3, 25, "0");
        
        insertParentTask(child2, "练习钢琴", 3, 50, "1");
        insertParentTask(child2, "刷牙打卡", 1, 5, "1");

        System.out.println("Inserting task logs...");
        Random r = new Random();
        for (int i = 0; i < 30; i++) {
            LocalDateTime time = LocalDateTime.now().minusDays(i);
            for (int j = 0; j < 2; j++) {
                ChildTask log = new ChildTask();
                log.setChildId(child1);
                log.setTaskId(2001L + r.nextInt(5));
                log.setStatus("2");
                log.setAutonomyScore(75 + r.nextInt(23));
                log.setActualDuration(15 + r.nextInt(30));
                log.setCreateTime(Date.from(time.atZone(ZoneId.systemDefault()).toInstant()));
                log.setTargetDate(Date.from(time.atZone(ZoneId.systemDefault()).toInstant()));
                log.setDeptId(200L);
                childTaskMapper.insert(log);
            }
        }

        System.out.println("Inserting AI emotions...");
        String[][] emotions = {
            {"1", "今天拿到小红花了！", "太棒了！为你骄傲！"},
            {"4", "数学题太难了...", "没关系，小步带你慢慢拆解。"},
            {"2", "我的玩具弄丢了", "别难过，我们一起找找。"},
            {"3", "我今天很生气！", "深呼吸，慢慢说发生了什么。"},
            {"5", "感觉今天很平静。", "平静也是一种很好的状态。"},
            {"1", "我交到了新朋友！", "真为你感到开心！"},
            {"5", "我会努力的。", "相信你一定行。"}
        };
        for (int i = 0; i < emotions.length; i++) {
            ChildAI ai = new ChildAI();
            ai.setChildId(child1);
            ai.setEmotionType(Integer.parseInt(emotions[i][0]));
            ai.setUserInput(emotions[i][1]);
            ai.setAiResponse(emotions[i][2]);
            ai.setCreateTime(Date.from(LocalDateTime.now().minusDays(i).atZone(ZoneId.systemDefault()).toInstant()));
            childAiMapper.insert(ai);
        }

        System.out.println("Inserting parent rewards...");
        insertReward(parentId, "看动画片30分钟", 50, 99, "movie");
        insertReward(parentId, "周末去乐高乐园", 500, 1, "fort");
        insertReward(parentId, "多吃一个冰淇淋", 100, 10, "icecream");
        insertReward(parentId, "购买新绘本", 150, 5, "book");

        System.out.println("Successfully generated sufficient test data!");
    }

    private void insertParentTask(Long childId, String title, int diff, int points, String status) {
        ParentTask t = new ParentTask();
        t.setUserId(childId);
        t.setTitle(title);
        t.setDifficulty(diff);
        t.setRewardPoints(points);
        t.setStatus(status);
        t.setDeptId(200L);
        parentTaskMapper.insert(t);
    }

    private void insertReward(Long parentId, String name, int points, int stock, String icon) {
        ParentReward r = new ParentReward();
        r.setUserId(parentId);
        r.setName(name);
        r.setPointsRequired(points);
        r.setStock(stock);
        r.setIcon(icon);
        r.setStatus("0");
        parentRewardMapper.insert(r);
    }
}
