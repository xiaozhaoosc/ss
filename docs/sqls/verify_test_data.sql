-- -------------------------------------------------------------------------------------------------------------------
-- Small Steps 测试数据验证脚本 (PostgreSQL)
-- Author: Antigravity
-- Date: 2026-02-06
-- Description: 验证测试数据是否正确安装
-- -------------------------------------------------------------------------------------------------------------------

\echo '========================================='
\echo 'Small Steps 测试数据验证'
\echo '========================================='
\echo ''

-- 1. 验证租户
\echo '1. 验证租户信息...'
SELECT 
  CASE 
    WHEN COUNT(*) = 1 THEN '✅ 租户创建成功'
    ELSE '❌ 租户创建失败'
  END as status,
  tenant_id,
  company_name,
  contact_user_name,
  contact_phone
FROM sys_tenant 
WHERE tenant_id = 'SS0001';

\echo ''

-- 2. 验证部门
\echo '2. 验证部门信息...'
SELECT 
  CASE 
    WHEN COUNT(*) = 1 THEN '✅ 部门创建成功'
    ELSE '❌ 部门创建失败'
  END as status,
  dept_id,
  dept_name,
  tenant_id
FROM sys_dept 
WHERE dept_id = 200;

\echo ''

-- 3. 验证用户
\echo '3. 验证测试用户...'
SELECT 
  CASE 
    WHEN COUNT(*) = 4 THEN '✅ 所有用户创建成功 (4个)'
    ELSE '❌ 用户创建不完整，当前: ' || COUNT(*) || '个'
  END as status
FROM sys_user 
WHERE user_id >= 1000 AND user_id < 1010;

SELECT 
  user_id,
  user_name,
  nick_name,
  CASE 
    WHEN user_id IN (1000, 1001) THEN '家长'
    WHEN user_id IN (1002, 1003) THEN '儿童'
  END as role_type
FROM sys_user 
WHERE user_id >= 1000 AND user_id < 1010
ORDER BY user_id;

\echo ''

-- 4. 验证角色关联
\echo '4. 验证用户角色关联...'
SELECT 
  CASE 
    WHEN COUNT(*) = 4 THEN '✅ 角色关联成功 (4个)'
    ELSE '❌ 角色关联不完整，当前: ' || COUNT(*) || '个'
  END as status
FROM sys_user_role 
WHERE user_id >= 1000 AND user_id < 1010;

SELECT 
  u.user_name,
  u.nick_name,
  r.role_name,
  r.role_key
FROM sys_user_role ur
JOIN sys_user u ON ur.user_id = u.user_id
JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id >= 1000 AND u.user_id < 1010
ORDER BY u.user_id;

\echo ''

-- 5. 验证儿童档案
\echo '5. 验证儿童档案...'
SELECT 
  CASE 
    WHEN COUNT(*) = 2 THEN '✅ 儿童档案创建成功 (2个)'
    ELSE '❌ 儿童档案创建不完整，当前: ' || COUNT(*) || '个'
  END as status
FROM ss_child 
WHERE tenant_id = 'SS0001';

SELECT 
  id,
  nickname,
  gender,
  level,
  star_balance,
  total_stars
FROM ss_child 
WHERE tenant_id = 'SS0001'
ORDER BY id;

\echo ''

-- 6. 验证任务配置
\echo '6. 验证任务配置...'
SELECT 
  CASE 
    WHEN COUNT(*) >= 4 THEN '✅ 任务配置创建成功 (' || COUNT(*) || '个)'
    ELSE '❌ 任务配置创建不完整，当前: ' || COUNT(*) || '个'
  END as status
FROM ss_task 
WHERE tenant_id = 'SS0001';

SELECT 
  id,
  title,
  star_reward,
  difficulty,
  (SELECT nickname FROM ss_child WHERE id = ss_task.child_id) as child_name
FROM ss_task 
WHERE tenant_id = 'SS0001'
ORDER BY child_id, id;

\echo ''

-- 7. 验证任务记录
\echo '7. 验证任务执行记录...'
SELECT 
  CASE 
    WHEN COUNT(*) >= 7 THEN '✅ 任务记录创建成功 (' || COUNT(*) || '条)'
    ELSE '❌ 任务记录创建不完整，当前: ' || COUNT(*) || '条'
  END as status
FROM ss_task_log 
WHERE tenant_id = 'SS0001';

\echo ''

-- 8. 验证奖励配置
\echo '8. 验证奖励配置...'
SELECT 
  CASE 
    WHEN COUNT(*) >= 5 THEN '✅ 奖励配置创建成功 (' || COUNT(*) || '个)'
    ELSE '❌ 奖励配置创建不完整，当前: ' || COUNT(*) || '个'
  END as status
FROM ss_reward 
WHERE tenant_id = 'SS0001';

SELECT 
  id,
  name,
  star_cost,
  stock,
  (SELECT nickname FROM ss_child WHERE id = ss_reward.child_id) as child_name
FROM ss_reward 
WHERE tenant_id = 'SS0001'
ORDER BY child_id, id;

\echo ''

-- 9. 验证兑换记录
\echo '9. 验证奖励兑换记录...'
SELECT 
  CASE 
    WHEN COUNT(*) >= 2 THEN '✅ 兑换记录创建成功 (' || COUNT(*) || '条)'
    ELSE '❌ 兑换记录创建不完整，当前: ' || COUNT(*) || '条'
  END as status
FROM ss_reward_exchange 
WHERE tenant_id = 'SS0001';

\echo ''

-- 10. 验证星星流水
\echo '10. 验证星星流水记录...'
SELECT 
  CASE 
    WHEN COUNT(*) >= 9 THEN '✅ 星星流水创建成功 (' || COUNT(*) || '条)'
    ELSE '❌ 星星流水创建不完整，当前: ' || COUNT(*) || '条'
  END as status
FROM ss_star_record 
WHERE tenant_id = 'SS0001';

-- 验证星星余额计算是否正确
SELECT 
  c.nickname,
  c.star_balance as current_balance,
  COALESCE(SUM(sr.amount), 0) as calculated_balance,
  CASE 
    WHEN c.star_balance = COALESCE(SUM(sr.amount), 0) THEN '✅ 余额正确'
    ELSE '❌ 余额不匹配'
  END as balance_check
FROM ss_child c
LEFT JOIN ss_star_record sr ON c.id = sr.child_id
WHERE c.tenant_id = 'SS0001'
GROUP BY c.id, c.nickname, c.star_balance;

\echo ''

-- 11. 验证情绪记录
\echo '11. 验证情绪记录...'
SELECT 
  CASE 
    WHEN COUNT(*) >= 3 THEN '✅ 情绪记录创建成功 (' || COUNT(*) || '条)'
    ELSE '❌ 情绪记录创建不完整，当前: ' || COUNT(*) || '条'
  END as status
FROM ss_emotion_record 
WHERE tenant_id = 'SS0001';

SELECT 
  id,
  mood_level,
  mood_type,
  LEFT(description, 30) || '...' as description_preview,
  is_read
FROM ss_emotion_record 
WHERE tenant_id = 'SS0001'
ORDER BY record_time DESC;

\echo ''

-- 12. 验证设备绑定
\echo '12. 验证设备绑定...'
SELECT 
  CASE 
    WHEN COUNT(*) >= 1 THEN '✅ 设备绑定创建成功 (' || COUNT(*) || '个)'
    ELSE '❌ 设备绑定创建不完整，当前: ' || COUNT(*) || '个'
  END as status
FROM ss_device 
WHERE tenant_id = 'SS0001';

SELECT 
  serial_number,
  (SELECT nickname FROM ss_child WHERE id = ss_device.child_id) as child_name,
  status,
  battery_level,
  fw_version
FROM ss_device 
WHERE tenant_id = 'SS0001';

\echo ''

-- 13. 验证家庭成员关联
\echo '13. 验证家庭成员关联...'
SELECT 
  CASE 
    WHEN COUNT(*) >= 4 THEN '✅ 家庭成员关联创建成功 (' || COUNT(*) || '条)'
    ELSE '❌ 家庭成员关联创建不完整，当前: ' || COUNT(*) || '条'
  END as status
FROM ss_family_member 
WHERE tenant_id = 'SS0001';

SELECT 
  (SELECT nickname FROM ss_child WHERE id = fm.child_id) as child_name,
  (SELECT nick_name FROM sys_user WHERE user_id = fm.user_id) as parent_name,
  fm.role as relation
FROM ss_family_member fm
WHERE fm.tenant_id = 'SS0001'
ORDER BY fm.child_id, fm.user_id;

\echo ''
\echo '========================================='
\echo '验证完成！'
\echo '========================================='
\echo ''
\echo '测试账号信息：'
\echo '家长端:'
\echo '  用户名: parent_zhang  密码: admin123  (张伟 - 父亲)'
\echo '  用户名: parent_li     密码: admin123  (李娜 - 母亲)'
\echo ''
\echo '儿童端:'
\echo '  用户名: child_xiaoming  密码: admin123  (张小明 - 9岁男孩)'
\echo '  用户名: child_xiaohong  密码: admin123  (张小红 - 7岁女孩)'
\echo ''
\echo '详细文档: docs/sqls/TEST_DATA_README.md'
\echo '========================================='
