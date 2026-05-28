const { Client } = require('pg');

const client = new Client({
  host: '10.8.0.1',
  port: 15432,
  user: 'smallsteps',
  password: 'abdSSsaf#1236548^',
  database: 'smallsteps_db',
});

async function run() {
  await client.connect();
  console.log("Connected to PostgreSQL successfully!");
  
  // 1. 查询所有 sys_user
  const users = await client.query("SELECT user_id, user_name, nick_name, user_type, dept_id FROM sys_user;");
  console.log("\n--- All sys_user ---");
  console.log(users.rows);

  // 2. 查找 2059933262075191300
  const searchId = '2059933262075191300';
  for (const table of ['sys_user', 'ss_child', 'ss_family_member', 'sys_dept']) {
    try {
      const res = await client.query(`SELECT * FROM ${table} WHERE id::text = '${searchId}' OR id::text LIKE '20599332620751913%' OR user_id::text = '${searchId}' OR user_id::text LIKE '20599332620751913%';`);
      console.log(`\n--- Matches in ${table} ---`);
      console.log(res.rows);
    } catch (e) {
      // 字段不匹配则忽略
    }
  }

  await client.end();
}

run().catch(console.error);
