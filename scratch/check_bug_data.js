const { Client } = require('pg');

const config = {
  host: '10.8.0.1',
  port: 15432,
  user: 'smallsteps',
  password: 'abdSSsaf#1236548^',
  database: 'smallsteps_db',
};

async function runDiagnostics() {
  const client = new Client(config);
  try {
    await client.connect();
    console.log("🚀 [Database] Connected successfully!");

    // 执行删除其中一条重复数据（保留较新的2026-05-30，删除较旧的2026-05-29）
    console.log("\n--- Cleaning up duplicate row from ss_parent_reward_redemption ---");
    const deleteRes = await client.query(`
      DELETE FROM ss_parent_reward_redemption 
      WHERE redemption_id = 2060300000000000041 
        AND create_time < '2026-05-30 00:00:00';
    `);
    console.log(`✅ Successfully deleted ${deleteRes.rowCount} duplicate row(s).`);

    // 重新验证结果
    console.log("\n--- Re-verifying Redemptions with ID 2060300000000000041 ---");
    const checkRes = await client.query(`
      SELECT * FROM ss_parent_reward_redemption 
      WHERE redemption_id = 2060300000000000041;
    `);
    console.log("Remaining records in DB:", checkRes.rows);

  } catch (error) {
    console.error("❌ Error running cleanup:", error);
  } finally {
    await client.end();
    console.log("🔌 Connected closed.");
  }
}

runDiagnostics().catch(console.error);
