/**
 * 诊断解析逻辑测试脚本
 * 用于验证 request.ts 是否能处理各种奇葩的后端返回格式
 */

function mockParseLogic(rawData, statusCode = 200) {
    let data = rawData;
    
    // 模拟 request.ts 中的解析逻辑
    if (typeof data === 'string') {
        const jsonMatch = data.match(/\{[\s\S]*\}/);
        if (jsonMatch) {
            try {
                data = JSON.parse(jsonMatch[0]);
            } catch (e) {
                data = { msg: data };
            }
        } else {
            data = { msg: data };
        }
    }

    data = data || {};
    const code = data.code || statusCode;
    const msg = data.msg || data.message || (statusCode === 200 ? '' : `服务器异常(${statusCode})`);
    
    return { code, msg, data };
}

// 测试用例 1: 标准 JSON
const case1 = { code: 500, msg: "儿童账号不存在", data: null };
const res1 = mockParseLogic(case1, 500);
console.log('Case 1 (Standard JSON):', res1.msg === "儿童账号不存在" ? 'PASS' : 'FAIL', res1.msg);

// 测试用例 2: 带状态码前缀的字符串 (用户反馈的情况)
const case2 = '500 {"code":500,"msg":"未找到该儿童账号","data":null}';
const res2 = mockParseLogic(case2, 500);
console.log('Case 2 (String with Prefix):', res2.msg === "未找到该儿童账号" ? 'PASS' : 'FAIL', res2.msg);

// 测试用例 3: 包含长报错的 JSON (MapStruct 错误)
const case3 = { code: 500, msg: "cannot find converter from ParentRewardBo to ParentReward", data: null };
const res3 = mockParseLogic(case3, 500);
console.log('Case 3 (Long Message):', res3.msg.includes("converter") ? 'PASS' : 'FAIL', res3.msg);

// 测试用例 4: 纯文本错误
const case4 = "Gateway Timeout";
const res4 = mockParseLogic(case4, 504);
console.log('Case 4 (Plain Text):', res4.msg.includes("Gateway") ? 'PASS' : 'FAIL', res4.msg);
