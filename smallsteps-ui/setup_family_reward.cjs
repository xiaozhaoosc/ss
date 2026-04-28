const axios = require('axios');

async function setupFamilyAndReward() {
  console.log('开始设置家庭绑定关系和奖励数据...\n');

  const baseURL = 'http://localhost:8081/ssapi';
  let token = null;

  try {
    console.log('1. 管理员登录...');
    const loginResponse = await axios.post(`${baseURL}/auth/login`, {
      username: 'admin',
      password: 'admin123',
      clientId: 'e5cd7e4891bf95d1d19206ce24a7b32e',
      grantType: 'password'
    });
    
    if (loginResponse.data.code === 200) {
      token = loginResponse.data.data.accessToken;
      console.log('✅ 管理员登录成功');
    } else {
      console.log('❌ 管理员登录失败:', loginResponse.data.msg);
      return;
    }

    const headers = {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    };

    console.log('\n2. 查询用户列表...');
    const usersResponse = await axios.get(`${baseURL}/system/user/list`, { headers });
    const users = usersResponse.data.data;
    
    const ken2zhao = users.find(u => u.userName === 'ken2zhao');
    const parent_zhang = users.find(u => u.userName === 'parent_zhang');
    const child_xiaoming = users.find(u => u.userName === 'child_xiaoming');
    const child_xiaohong = users.find(u => u.userName === 'child_xiaohong');

    console.log(`找到用户:`);
    console.log(`  - ken2zhao: ${ken2zhao ? '存在' : '不存在'}`);
    console.log(`  - parent_zhang: ${parent_zhang ? '存在' : '不存在'}`);
    console.log(`  - child_xiaoming: ${child_xiaoming ? '存在' : '不存在'}`);
    console.log(`  - child_xiaohong: ${child_xiaohong ? '存在' : '不存在'}`);

    console.log('\n3. 查询部门列表...');
    const deptResponse = await axios.get(`${baseURL}/system/dept/list`, { headers });
    const depts = deptResponse.data.data;
    let familyDept = depts.find(d => d.deptName === '测试家庭');
    
    if (!familyDept) {
      console.log('   创建测试家庭部门...');
      const createDeptResponse = await axios.post(`${baseURL}/system/dept`, {
        deptName: '测试家庭',
        parentId: 0,
        orderNum: 1,
        status: '0'
      }, { headers });
      familyDept = createDeptResponse.data.data;
      console.log('   ✅ 测试家庭部门创建成功');
    }
    console.log(`   测试家庭部门ID: ${familyDept.deptId}`);

    console.log('\n4. 设置家庭绑定关系...');
    const usersToUpdate = [ken2zhao, parent_zhang, child_xiaoming, child_xiaohong];
    const userNames = ['ken2zhao', 'parent_zhang', 'child_xiaoming', 'child_xiaohong'];
    
    for (let i = 0; i < usersToUpdate.length; i++) {
      if (usersToUpdate[i]) {
        try {
          await axios.put(`${baseURL}/system/user`, {
            userId: usersToUpdate[i].userId,
            userName: usersToUpdate[i].userName,
            nickName: usersToUpdate[i].nickName,
            deptId: familyDept.deptId,
            status: '0'
          }, { headers });
          console.log(`   ✅ ${userNames[i]} 已绑定到测试家庭`);
        } catch (e) {
          console.log(`   ❌ ${userNames[i]} 绑定失败: ${e.message}`);
        }
      }
    }

    console.log('\n5. 设置用户角色...');
    const rolesResponse = await axios.get(`${baseURL}/system/role/list`, { headers });
    const roles = rolesResponse.data.data;
    const parentRole = roles.find(r => r.roleName === '家长');
    const childRole = roles.find(r => r.roleName === '儿童');

    console.log(`   家长角色ID: ${parentRole?.roleId}, 儿童角色ID: ${childRole?.roleId}`);

    if (ken2zhao && parentRole) {
      await axios.put(`${baseURL}/system/user/authRole`, {
        userId: ken2zhao.userId,
        roleIds: parentRole.roleId.toString()
      }, { headers });
      console.log('   ✅ ken2zhao 已分配家长角色');
    }

    if (parent_zhang && parentRole) {
      await axios.put(`${baseURL}/system/user/authRole`, {
        userId: parent_zhang.userId,
        roleIds: parentRole.roleId.toString()
      }, { headers });
      console.log('   ✅ parent_zhang 已分配家长角色');
    }

    if (child_xiaoming && childRole) {
      await axios.put(`${baseURL}/system/user/authRole`, {
        userId: child_xiaoming.userId,
        roleIds: childRole.roleId.toString()
      }, { headers });
      console.log('   ✅ child_xiaoming 已分配儿童角色');
    }

    if (child_xiaohong && childRole) {
      await axios.put(`${baseURL}/system/user/authRole`, {
        userId: child_xiaohong.userId,
        roleIds: childRole.roleId.toString()
      }, { headers });
      console.log('   ✅ child_xiaohong 已分配儿童角色');
    }

    console.log('\n6. 注入奖励数据...');
    if (ken2zhao) {
      const rewards = [
        { name: '玩30分钟游戏', pointsRequired: 20, stock: -1, icon: '🎮' },
        { name: '乐高积木一套', pointsRequired: 100, stock: 3, icon: '🧱' },
        { name: '看一集奥特曼', pointsRequired: 15, stock: -1, icon: '🦸' },
        { name: '额外半小时玩耍', pointsRequired: 25, stock: -1, icon: '🏃' },
        { name: '冰淇淋一个', pointsRequired: 10, stock: 10, icon: '🍦' },
        { name: '绘本一本', pointsRequired: 50, stock: 5, icon: '📚' }
      ];

      for (const reward of rewards) {
        try {
          await axios.post(`${baseURL}/parent/reward`, {
            userId: ken2zhao.userId,
            name: reward.name,
            pointsRequired: reward.pointsRequired,
            stock: reward.stock,
            icon: reward.icon,
            status: '0'
          }, { headers });
          console.log(`   ✅ 添加奖励: ${reward.name}`);
        } catch (e) {
          console.log(`   ❌ 添加奖励失败 ${reward.name}: ${e.message}`);
        }
      }
    }

    console.log('\n========== 家庭绑定与奖励数据设置完成 ==========');
    console.log('\n已完成以下操作:');
    console.log('✅ 家庭绑定关系建立');
    console.log('  - ken2zhao (家长)');
    console.log('  - parent_zhang (家长)');
    console.log('  - child_xiaoming (儿童)');
    console.log('  - child_xiaohong (儿童)');
    console.log('✅ 角色分配完成');
    console.log('✅ 奖励数据注入完成 (6个奖励项目)');

  } catch (error) {
    console.error('执行过程中发生错误:', error.message);
    if (error.response) {
      console.error('响应数据:', error.response.data);
    }
    throw error;
  }
}

setupFamilyAndReward().catch(console.error);