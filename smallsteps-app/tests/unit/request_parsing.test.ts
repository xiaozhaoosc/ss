import { describe, it, expect } from 'vitest';

/**
 * 诊断解析逻辑测试
 * 用于验证 request.ts 是否能处理各种奇葩的后端返回格式
 */
function mockParseLogic(rawData: any, statusCode = 200) {
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

describe('Request Parsing Logic', () => {
  it('should handle standard JSON', () => {
    const raw = { code: 500, msg: "儿童账号不存在", data: null };
    const res = mockParseLogic(raw, 500);
    expect(res.msg).toBe("儿童账号不存在");
  });

  it('should handle string with status code prefix', () => {
    const raw = '500 {"code":500,"msg":"未找到该儿童账号","data":null}';
    const res = mockParseLogic(raw, 500);
    expect(res.msg).toBe("未找到该儿童账号");
  });

  it('should handle long error messages', () => {
    const raw = { code: 500, msg: "cannot find converter from ParentRewardBo to ParentReward", data: null };
    const res = mockParseLogic(raw, 500);
    expect(res.msg).toContain("converter");
  });

  it('should handle plain text errors', () => {
    const raw = "Gateway Timeout";
    const res = mockParseLogic(raw, 504);
    expect(res.msg).toContain("Gateway");
  });
});
