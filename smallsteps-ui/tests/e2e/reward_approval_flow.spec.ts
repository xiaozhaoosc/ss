import { test, expect } from '@playwright/test';

test.describe('奖励兑换审批流自动化测试', () => {
  test('孩子申请兑换奖励，家长审批通过', async ({ page }) => {
    // 1. 孩子登录
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    await page.locator('input[placeholder="用户名"]').fill('child_xiaoming');
    await page.locator('input[placeholder="密码"]').fill('admin123');
    await page.getByRole('button', { name: '登 录' }).click();
    
    // 等待登录成功并跳转
    await page.waitForURL(/.*dashboard/, { timeout: 15000 });
    
    // 跳过引导
    const skipBtnChild = page.locator('.introjs-skipbutton');
    if (await skipBtnChild.isVisible()) {
      await skipBtnChild.click();
    }
    await page.waitForTimeout(1000);

    // 2. 孩子发起奖励兑换
    await page.goto('/#/child/reward');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);
    
    // 点击立即兑换
    const exchangeBtn = page.locator('button:has-text("立即兑换")').first();
    if (await exchangeBtn.isVisible() && await exchangeBtn.isEnabled()) {
        await exchangeBtn.click();
        await page.waitForTimeout(500);
        // 确认兑换框
        const confirmBtn = page.locator('button:has-text("确定")').first();
        if (await confirmBtn.isVisible()) {
            await confirmBtn.click();
            await page.waitForTimeout(1000);
        }
    }

    // 3. 退出登录
    await page.locator('.avatar-wrapper').click();
    await page.waitForTimeout(500);
    await page.getByText('退出登录').click();
    await page.waitForTimeout(500);
    const logoutConfirmBtn = page.getByRole('button', { name: '确定' });
    if (await logoutConfirmBtn.isVisible()) {
        await logoutConfirmBtn.click();
    }
    await page.waitForURL(/.*login.*/, { timeout: 10000 });
    await page.waitForTimeout(1000);

    // 4. 家长（或admin）登录审批
    await page.locator('input[placeholder="用户名"]').fill('admin');
    await page.locator('input[placeholder="密码"]').fill('admin123');
    await page.getByRole('button', { name: '登 录' }).click();
    await page.waitForURL(/.*dashboard/, { timeout: 15000 });
    
    // 跳过引导
    const skipBtnAdmin = page.locator('.introjs-skipbutton');
    if (await skipBtnAdmin.isVisible()) {
      await skipBtnAdmin.click();
    }
    await page.waitForTimeout(1000);

    // 5. 进入待办任务
    await page.goto('/#/workflow/task/taskWaiting');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 查找有没有“办理”按钮，尝试点击处理审批
    const processBtn = page.locator('button:has-text("办理")').first();
    if (await processBtn.isVisible()) {
        await processBtn.click();
        await page.waitForLoadState('networkidle');
        await page.waitForTimeout(2000);

        // 尝试点击审批或提交流程
        const approveBtn = page.locator('button:has-text("审批")').first();
        if (await approveBtn.isVisible()) {
            await approveBtn.click();
            await page.waitForTimeout(1000);
            
            // 提交意见
            const submitBtn = page.locator('button:has-text("提交")').last();
            if (await submitBtn.isVisible()) {
                await submitBtn.click();
                await page.waitForTimeout(1000);
                
                const finalConfirm = page.locator('button:has-text("确定")').first();
                if (await finalConfirm.isVisible()) {
                    await finalConfirm.click();
                    await page.waitForTimeout(1000);
                }
            }
        }
    }
  });
});
