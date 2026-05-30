const { Client } = require('pg');

const config = {
  host: '10.8.0.1',
  port: 15432,
  user: 'smallsteps',
  password: 'abdSSsaf#1236548^',
  database: 'smallsteps_db',
};

async function shiftDates() {
  const client = new Client(config);
  try {
    await client.connect();
    console.log("🚀 [Database] Successfully connected to smallsteps_db at 10.8.0.1:15432");

    // 1. 获取今天和昨天的日期字符串，为了方便查询和打印
    const todayRes = await client.query("SELECT CURRENT_DATE as today, (CURRENT_DATE - INTERVAL '1 day')::date as yesterday;");
    const { today, yesterday } = todayRes.rows[0];
    const todayStr = new Date(today).toISOString().split('T')[0];
    const yesterdayStr = new Date(yesterday).toISOString().split('T')[0];
    
    console.log(`📅 平移时间: 将昨天 (${yesterdayStr}) 及特定日期 (2026-05-29) 的数据平移至今天 (${todayStr})`);

    // 2. 执行平移任务日志 (ss_task_log)
    console.log("🔄 平移任务日志 ss_task_log...");
    const taskLogUpdate = await client.query(`
      UPDATE ss_task_log 
      SET target_date = CURRENT_DATE,
          start_time = CURRENT_DATE + (start_time::time),
          end_time = CASE WHEN end_time IS NOT NULL THEN CURRENT_DATE + (end_time::time) ELSE NULL END,
          create_time = CURRENT_DATE + (create_time::time),
          update_time = CASE WHEN update_time IS NOT NULL THEN CURRENT_DATE + (update_time::time) ELSE NULL END
      WHERE target_date = '2026-05-29' 
         OR target_date = $1::date
         OR DATE(create_time) = '2026-05-29' 
         OR DATE(create_time) = $1::date;
    `, [yesterdayStr]);
    console.log(`✅ ss_task_log 成功平移了 ${taskLogUpdate.rowCount} 条记录`);

    // 3. 执行平移 AI 交互日志 (ss_child_ai)
    console.log("🔄 平移 AI 交互记录 ss_child_ai...");
    const childAiUpdate = await client.query(`
      UPDATE ss_child_ai
      SET create_time = CURRENT_DATE + (create_time::time),
          update_time = CASE WHEN update_time IS NOT NULL THEN CURRENT_DATE + (update_time::time) ELSE NULL END
      WHERE DATE(create_time) = '2026-05-29' 
         OR DATE(create_time) = $1::date;
    `, [yesterdayStr]);
    console.log(`✅ ss_child_ai 成功平移了 ${childAiUpdate.rowCount} 条记录`);

    // 4. 执行平移情绪日志 (ss_emotion_record / ss_child_emotion_record - 兜底捕获异常)
    const tables = ['ss_emotion_record', 'ss_child_emotion_record', 'ss_child_emotion'];
    for (const table of tables) {
      try {
        const updateRes = await client.query(`
          UPDATE ${table}
          SET create_time = CURRENT_DATE + (create_time::time),
              update_time = CASE WHEN update_time IS NOT NULL THEN CURRENT_DATE + (update_time::time) ELSE NULL END
          WHERE DATE(create_time) = '2026-05-29' 
             OR DATE(create_time) = $1::date;
        `, [yesterdayStr]);
        console.log(`✅ ${table} 成功平移了 ${updateRes.rowCount} 条记录`);
      } catch (e) {
        // 忽略表不存在或字段不匹配错误
      }
    }

    // 5. 检查并兜底注入：如果今天没有任何任务记录，或者任务太少，为了在面板上呈现完美效果，我们把测试账号的某些经典任务在今天自动多插入几条已完成记录
    const todayCountRes = await client.query(`SELECT count(*) FROM ss_task_log WHERE target_date = CURRENT_DATE;`);
    const count = parseInt(todayCountRes.rows[0].count);
    console.log(`📊 检查今日总任务记录数: ${count}`);

    if (count < 3) {
      console.log("💡 检测到今日活跃任务较少，正在为小明 (child_id: 10001 / 1002) 自动预置高逼格今日打卡数据...");
      // 我们为 10001 (E2E测试孩子) 和 1002 (图表展示孩子) 都注入几条已完成任务记录
      const children = [10001, 1002];
      let inserted = 0;
      for (const cid of children) {
        // 我们需要把 ss_parent_task 中的任务拿来作为模板
        const tasksRes = await client.query(`SELECT task_id FROM ss_parent_task LIMIT 3;`);
        const taskIds = tasksRes.rows.map(r => r.task_id);
        
        // 如果系统没有任务，我们就随便用 10001, 10002, 10003 这样的 id 注入
        const idsToUse = taskIds.length > 0 ? taskIds : [10001, 10002, 10003];

        for (let i = 0; i < idsToUse.length; i++) {
          const tid = idsToUse[i];
          const insertRes = await client.query(`
            INSERT INTO ss_task_log (dept_id, task_id, child_id, target_date, actual_duration, status, start_time, end_time, autonomy_score, create_time, del_flag)
            VALUES (
              100, 
              $1, 
              $2, 
              CURRENT_DATE, 
              $3, 
              '2', 
              CURRENT_TIMESTAMP - (INTERVAL '1 hour' * $4), 
              CURRENT_TIMESTAMP - (INTERVAL '1 hour' * $4 - INTERVAL '10 minutes'),
              $5,
              CURRENT_TIMESTAMP - (INTERVAL '1 hour' * $4), 
              '0'
            )
            ON CONFLICT DO NOTHING;
          `, [tid, cid, 300 + i * 150, i + 1, 4 + i]);
          inserted += insertRes.rowCount;
        }
      }
      console.log(`🎯 成功兜底注入 ${inserted} 条今日打卡任务记录`);
    }

    // 6. 检查并兜底注入今日 AI 情绪分析记录
    const todayAiRes = await client.query(`SELECT count(*) FROM ss_child_ai WHERE DATE(create_time) = CURRENT_DATE;`);
    const aiCount = parseInt(todayAiRes.rows[0].count);
    console.log(`📊 检查今日 AI 交互记录数: ${aiCount}`);

    if (aiCount < 3) {
      console.log("💡 检测到今日 AI 情绪分析记录较少，正在自动预置今日 AI 情绪图表所需交互数据...");
      const aiData = [
        { cid: 1002, text: '今天在学校画了漂亮的城堡，老师和同学都夸赞我了！', resp: '哇，好棒呀！你真的很擅长画画，继续保持哦！', emo: 1 },
        { cid: 1002, text: '我今天拼乐高拼了很久都拼不好，好沮丧啊。', resp: '没关系的小英雄，遇到困难慢慢来，我们可以先休息一下再试试！', emo: 4 },
        { cid: 1002, text: '爸爸今天带我去吃了冰淇淋，开心极了！', resp: '冰淇淋冰凉甜美，听起来真是一次超级棒的体验呢！', emo: 1 },
        { cid: 10001, text: '今天跟妈妈一起读了绘本，感觉自己很棒。', resp: '真棒！阅读可以让你的知识库越来越丰富哦！', emo: 5 }
      ];

      let aiInserted = 0;
      for (const item of aiData) {
        const insertRes = await client.query(`
          INSERT INTO ss_child_ai (child_id, user_input, ai_response, emotion_type, create_time, create_by, del_flag)
          VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP - INTERVAL '10 minutes', 'admin', '0');
        `, [item.cid, item.text, item.resp, item.emo]);
        aiInserted += insertRes.rowCount;
      }
      console.log(`🎯 成功兜底注入 ${aiInserted} 条今日 AI 情绪交互数据`);
    }

    console.log("🎉 [Database] 时间平移与今日活跃数据自动注入完成！");
  } catch (error) {
    console.error("❌ [Database Error] 执行 SQL 失败:", error);
  } finally {
    await client.end();
    console.log("🔌 [Database] 数据库连接已安全断开");
  }
}

shiftDates().catch(console.error);
