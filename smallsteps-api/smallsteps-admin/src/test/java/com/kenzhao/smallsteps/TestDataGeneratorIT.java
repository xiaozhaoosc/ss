//package com.kenzhao.smallsteps;
//
//import com.kenzhao.smallsteps.task.mapper.ChildTaskMapper;
//import com.kenzhao.smallsteps.task.mapper.ParentTaskMapper;
//import com.kenzhao.smallsteps.child.mapper.ChildAIMapper;
//import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
//import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
//import com.kenzhao.smallsteps.common.ss.domain.ChildAI;
//import com.kenzhao.smallsteps.common.ss.domain.ParentReward;
//import com.kenzhao.smallsteps.parent.mapper.ParentRewardMapper;
//import org.junit.jupiter.api.Tag;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
//import org.springframework.test.annotation.Rollback;
//import org.springframework.transaction.annotation.Transactional;
//
//import java.time.LocalDateTime;
//import java.time.ZoneId;
//import java.util.Date;
//import java.util.Random;
//
//@SpringBootTest
//@Tag("dev")
//public class TestDataGeneratorIT {
//
//    @Autowired
//    private ChildTaskMapper childTaskMapper;
//    @Autowired
//    private ParentTaskMapper parentTaskMapper;
//                .credentialsProvider(credentialsProvider)
//                .credentialsProvider(credentialsProvider)
//    private ChildAIMapper childAiMapper;
//    @Autowired
//    private ParentRewardMapper parentRewardMapper;
//
//    @Test
//    @Transactional
//    @Rollback(false)
//    public void generateData() {
//        Long parentId = 2035392423676469250L;
//        Long child1 = 10001L;
//        Long child2 = 10002L;
//
//        System.out.println("Cleaning up old data...");
//        childTaskMapper.delete(new LambdaQueryWrapper<ChildTask>().in(ChildTask::getChildId, child1, child2));
//        childAiMapper.delete(new LambdaQueryWrapper<ChildAI>().in(ChildAI::getChildId, child1, child2));
//        parentTaskMapper.delete(new LambdaQueryWrapper<ParentTask>().in(ParentTask::getUserId, child1, child2));
//        parentRewardMapper.delete(new LambdaQueryWrapper<ParentReward>().eq(ParentReward::getUserId, parentId));
//
//        System.out.println("Inserting parent tasks for E2E...");
//        insertParentTask(child1, "自主刷牙", 1, 5, "0");
//        insertParentTask(child1, "完成数学口算", 2, 10, "0");
//        insertParentTask(child1, "整理书包", 2, 8, "0");
//
//        insertParentTask(child2, "练习钢琴", 3, 50, "0");
//
//        System.out.println("Updating child star balance...");
//
//        System.out.println("Inserting parent rewards for shop verification...");
//        insertReward(parentId, "玩30分钟游戏", 20, -1, "🎮");
//        insertReward(parentId, "乐高积木一套", 100, 3, "🧱");
//        insertReward(parentId, "看一集奥特曼", 15, -1, "🦸");
//
//        System.out.println("Successfully stabilized test data for E2E!");
//    }
//
//    private void insertParentTask(Long childId, String title, int diff, int points, String status) {
//        ParentTask t = new ParentTask();
//        t.setUserId(childId);
//        t.setTitle(title);
//        t.setDifficulty(diff);
//        t.setRewardPoints(points);
//        t.setStatus(status);
//        t.setDeptId(200L);
//        parentTaskMapper.insert(t);
//    }
//
//    private void insertReward(Long parentId, String name, int points, int stock, String icon) {
//        ParentReward r = new ParentReward();
//        r.setUserId(parentId);
//        r.setName(name);
//        r.setPointsRequired(points);
//        r.setStock(stock);
//        r.setIcon(icon);
//        r.setStatus("0");
//        parentRewardMapper.insert(r);
//    }
//}
