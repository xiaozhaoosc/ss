package com.kenzhao.smallsteps.common.ai.init;

import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class EmotionAnalysisMigrationTest {

    private static final String URL = "jdbc:postgresql://localhost:15432/smallsteps_db?useUnicode=true&characterEncoding=utf8&useSSL=false";
    private static final String USER = "smallsteps";
    private static final String PASS = "ui123456789~";

    @Test
    public void runMigration() {
        System.out.println("Starting Database Migration...");
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             Statement stmt = conn.createStatement()) {

            System.out.println("Connected to Database: " + URL);

            // 1. Create ss_child_ai table (Refactored to use 'id')
            String createTableSql = "CREATE TABLE IF NOT EXISTS ss_child_ai (" +
                    "id bigint NOT NULL PRIMARY KEY," +
                    "child_id bigint NOT NULL," +
                    "user_input text," +
                    "ai_response text," +
                    "emotion_type int," +
                    "context text," +
                    "create_dept bigint," +
                    "create_by bigint," +
                    "create_time timestamp," +
                    "update_by bigint," +
                    "update_time timestamp" +
                    ");";
            stmt.execute(createTableSql);
            System.out.println("Table ss_child_ai created or already exists.");

            // 2. Insert DAILY_EMOTION_ANALYSIS prompt
            String insertPromptSql = "INSERT INTO sys_ai_prompt (id, prompt_key, title, content, status, del_flag, create_by, create_time, remark) " +
                    "VALUES (101, 'DAILY_EMOTION_ANALYSIS', '每日情绪与任务总结', '你是一个专业的 ADHD 儿童心理与行为干预专家。\n" +
                    "今天孩子 {childName} 的活动记录如下：\n" +
                    "【失败/放弃的任务】：\n" +
                    "{failedTasks}\n" +
                    "【负面情绪记录】：\n" +
                    "{negativeEmotions}\n" +
                    "\n" +
                    "请结合以上数据，为家长提供一份简短、温暖且具有指导意义的“每日建议”。\n" +
                    "要求：\n" +
                    "1. 肯定孩子的努力，即便任务没完成。\n" +
                    "2. 给出 1-2 条具体的沟通建议（如：今晚可以尝试给孩子一个拥抱，并说...）。\n" +
                    "3. 语气保持积极、专业、充满人文关怀。\n" +
                    "4. 字数控制在 200 字以内。', '0', '0', '1', NOW(), '每日情绪总结模板') " +
                    "ON CONFLICT (prompt_key) WHERE (del_flag = '0') DO UPDATE SET content = EXCLUDED.content;";
            stmt.execute(insertPromptSql);
            System.out.println("Prompt DAILY_EMOTION_ANALYSIS inserted or updated.");

            // 3. Update route if needed
            String insertRouteSql = "INSERT INTO sys_ai_route (scene_key, strategy, default_model_id, update_by, update_time) " +
                    "VALUES ('DAILY_EMOTION_ANALYSIS', 'PRIORITY_LEVEL', 2001, 1, NOW()) " +
                    "ON CONFLICT (scene_key) DO UPDATE SET default_model_id = EXCLUDED.default_model_id;";
            stmt.execute(insertRouteSql);
            System.out.println("Route DAILY_EMOTION_ANALYSIS inserted or updated.");

            System.out.println("Database Migration Completed Successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Migration Failed", e);
        }
    }
}
