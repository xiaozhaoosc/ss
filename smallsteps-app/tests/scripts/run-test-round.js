const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

/**
 * 自动化测试全链路运行脚本
 * 1. 运行 Playwright 测试
 * 2. 生成 Allure 报告
 */
function runTestRound() {
    console.log('--- Starting Test Round ---');
    
    try {
        // 1. Run Playwright Tests
        console.log('Step 1: Running Playwright tests...');
        execSync('npx playwright test', { stdio: 'inherit' });
    } catch (e) {
        console.warn('Playwright tests finished with some failures.');
    }

    try {
        // 2. Generate Allure Report
        console.log('Step 2: Generating Allure report...');
        execSync('npx allure generate allure-results --clean -o allure-report', { stdio: 'inherit' });
        console.log('Report generated in allure-report/');
    } catch (e) {
        console.error('Failed to generate Allure report:', e.message);
    }

    console.log('--- Test Round Finished ---');
}

runTestRound();
