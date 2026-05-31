// global-setup.ts — 清除 ken2zhao 的登录锁定，确保测试可以正常登录
import { execSync } from 'node:child_process';

async function globalSetup() {
  try {
    execSync(
      `ssh -p 2216 -o StrictHostKeyChecking=no ken3zhao@10.8.0.1 "docker exec ss-redis redis-cli -a 'abdSSsaf#1236548^' del 'pwd_err_cnt:ken2zhao'"`,
      { timeout: 10000, stdio: 'pipe' }
    );
    console.log('✅ 已清除 ken2zhao 登录锁定');
  } catch (e: unknown) {
    console.warn('⚠️ 无法清除登录锁定:', (e as Error).message);
  }
}

export default globalSetup;
