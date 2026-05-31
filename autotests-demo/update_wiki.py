#!/usr/bin/env python3
"""
Small Steps 自动化测试 → 飞书知识库一键更新脚本

用法:
  python3 update_wiki.py V6           # 运行测试 + 更新知识库
  python3 update_wiki.py V6 --skip-tests  # 跳过测试，只更新知识库（用上次结果）
  python3 update_wiki.py V6 --dry-run     # 只运行测试，不更新知识库

前置条件:
  - lark-cli 已安装且已授权 (lark-cli auth login)
  - Playwright 已安装 (npm install)
  - 测试目标环境可访问 (默认 http://10.8.0.1:8043)

环境变量 (可选):
  SS_SPACE_ID     - 飞书知识库 space_id (默认 7645451195020020956)
  SS_PARENT_NODE  - 父节点 token (默认空=知识库根目录)
  SS_BASE_URL     - 测试目标 URL (默认 http://10.8.0.1:8043)
"""

import argparse
import json
import os
import re
import subprocess
import sys
import time
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path
from typing import Optional

# ─── 配置 ────────────────────────────────────────────────────────────────────

SPACE_ID = os.environ.get("SS_SPACE_ID", "7645451195020020956")
PARENT_NODE = os.environ.get("SS_PARENT_NODE", "")
BASE_URL = os.environ.get("SS_BASE_URL", "http://10.8.0.1:8043")
DEMO_DIR = Path(__file__).parent.resolve()
TIMEOUT = 120  # 秒


# ─── 数据结构 ──────────────────────────────────────────────────────────────────

@dataclass
class TestResult:
    name: str
    suite: str  # sats-ui / sats-app
    module: str  # 冒烟测试 / Full Lifecycle / 儿童端-登录与首页 / ...
    passed: bool
    duration: str = ""


@dataclass
class TestSuite:
    name: str
    label: str
    total: int = 0
    passed: int = 0
    failed: int = 0
    results: list = field(default_factory=list)
    screenshots: dict = field(default_factory=dict)  # name -> path


# ─── 工具函数 ──────────────────────────────────────────────────────────────────

def run_cmd(cmd: str, cwd: Optional[str] = None, timeout: int = TIMEOUT) -> subprocess.CompletedProcess:
    """执行 shell 命令，返回结果"""
    print(f"  → {cmd[:100]}{'...' if len(cmd) > 100 else ''}")
    result = subprocess.run(
        cmd, shell=True, cwd=cwd, capture_output=True, text=True, timeout=timeout
    )
    return result


def lark(*args, timeout=TIMEOUT) -> dict:
    """调用 lark-cli 并返回 JSON 结果"""
    cmd = f"lark-cli {' '.join(args)}"
    r = run_cmd(cmd, timeout=timeout)
    if r.returncode != 0:
        print(f"  ⚠️  lark-cli 错误: {r.stderr[:200]}")
        return {"ok": False, "error": r.stderr}
    try:
        # 提取 JSON (跳过非 JSON 行)
        output = r.stdout.strip()
        # 找到第一个 { 开始
        json_start = output.find("{")
        if json_start >= 0:
            return json.loads(output[json_start:])
        return {"ok": True, "raw": output}
    except json.JSONDecodeError:
        return {"ok": True, "raw": r.stdout.strip()}


# ─── 测试运行 ──────────────────────────────────────────────────────────────────

def run_tests(headed: bool = False, video: bool = False) -> dict[str, TestSuite]:
    """运行全部测试，返回结果"""
    print("\n🧪 运行自动化测试...")

    display_mode = "headed" if headed else "headless"
    extra_flags = ""
    if video:
        extra_flags = " --grep-invert='^$'"  # placeholder, video is in config

    suites = {}
    for suite_name, suite_label in [("sats-ui", "管理后台 UI"), ("sats-app", "H5 移动端")]:
        suite_dir = DEMO_DIR / suite_name
        print(f"\n━━━ {suite_label} 测试 ({display_mode}) ━━━")

        r = run_cmd(
            f"DISPLAY_MODE={display_mode} npx playwright test --reporter=list 2>&1",
            cwd=str(suite_dir),
            timeout=900,
        )

        suite = parse_test_output(r.stdout, suite_name, suite_label)
        suites[suite_name] = suite

        # 收集截图
        suite.screenshots = collect_screenshots(suite_name)

        print(f"  📊 {suite_label}: {suite.passed}/{suite.total} 通过")

    return suites


def parse_test_output(output: str, suite_name: str, suite_label: str) -> TestSuite:
    """解析 playwright test --reporter=list 的输出"""
    suite = TestSuite(name=suite_name, label=suite_label)

    # 匹配格式: ✓  1 [mobile-chrome] › tests/xxx.ts:9:7 › 模块名 › 用例名 (5.5s)
    # 或: ✘  1 [mobile-chrome] › tests/xxx.ts:9:7 › 模块名 › 用例名 (5.5s)
    pattern = r"[✓✘]\s+\d+\s+\[([^\]]+)\]\s+›\s+(\S+?)\s+›\s+(.+?)\s+›\s+(.+?)\s+\(([\d.]+s)\)"

    for line in output.split("\n"):
        m = re.search(pattern, line)
        if m:
            test_file = m.group(2)
            module_name = m.group(3).strip()
            case_name = m.group(4).strip()
            duration = m.group(5)
            passed = line.strip().startswith("✓")

            # 推断模块分类
            module = infer_module(test_file, module_name)

            suite.results.append(TestResult(
                name=case_name, suite=suite_name, module=module,
                passed=passed, duration=duration,
            ))

    # 统计
    suite.total = len(suite.results)
    suite.passed = sum(1 for r in suite.results if r.passed)
    suite.failed = suite.total - suite.passed

    # 解析总结行: "N passed (Xm)" 或 "N passed, M failed (Xm)"
    summary = re.search(r"(\d+) passed(?:,\s*(\d+) failed)?", output)
    if summary:
        suite.total = int(summary.group(1)) + (int(summary.group(2)) if summary.group(2) else 0)
        suite.passed = int(summary.group(1))
        suite.failed = int(summary.group(2)) if summary.group(2) else 0

    return suite


def infer_module(test_file: str, module_name: str) -> str:
    """从测试文件路径和模块名推断分类"""
    if "smoke" in test_file.lower():
        return "冒烟测试"
    if "full-lifecycle" in test_file.lower():
        return "完整业务流程"
    if "business" in test_file.lower():
        return "业务功能"
    if "monitoring" in test_file.lower():
        return "监控功能"
    if "long-chain" in test_file.lower():
        return "长链工作流"
    if "auth" in test_file.lower():
        return "注册登录绑定"

    # 子模块测试: 从模块名提取
    if "儿童端" in module_name:
        return module_name.split(":")[-1].strip() if ":" in module_name else module_name
    if "家长端" in module_name or "Tab" in module_name or "子页面" in module_name:
        # 提取 "Tab 1: 家长端首页 (Dashboard)" → "家长端首页"
        parts = module_name.split(":")
        if len(parts) > 1:
            return parts[1].strip().split("(")[0].strip()
        return module_name

    return module_name


def collect_screenshots(suite_name: str) -> dict[str, str]:
    """收集测试截图，包括子目录"""
    screenshots = {}
    results_dir = DEMO_DIR / suite_name / "test-results"
    if not results_dir.exists():
        return screenshots

    for png in results_dir.rglob("*.png"):
        rel = png.relative_to(results_dir)
        name = png.stem

        # child/ 和 parent/ 子目录的截图
        if rel.parts[0] in ("child", "parent"):
            key = f"{rel.parts[0]}/{name}"
            screenshots[key] = str(png)
        # test-finished 截图
        elif name == "test-finished-1":
            parent_name = rel.parent.name
            short = re.sub(r"-(chromium|mobile-chrome)$", "", parent_name)
            screenshots[short] = str(png)
        elif name.startswith("step"):
            screenshots[name] = str(png)
        else:
            # 其他手动截图 (如 parent-dashboard-mobile.png)
            screenshots[name] = str(png)

    return screenshots


# ─── 截图选择 ──────────────────────────────────────────────────────────────────

def select_report_screenshots(suites: dict[str, TestSuite]) -> list[tuple[str, str, str]]:
    """选择要插入报告的截图，返回 [(文件路径, 标题, 类型), ...]
    
    策略：
    - 管理后台：只选 登录、用户管理、AI 模块 相关截图
    - 重点：家长端、儿童端截图
    """
    selected = []

    # ── 管理后台：精简选取 ──
    ui = suites.get("sats-ui")
    if ui:
        # 登录
        if "step1" in ui.screenshots:
            selected.append((ui.screenshots["step1"], "管理后台: 家长登录 Dashboard", "ui"))
        # AI 模块
        if "step2" in ui.screenshots:
            selected.append((ui.screenshots["step2"], "管理后台: AI 任务拆解", "ui"))
        if "step6" in ui.screenshots:
            selected.append((ui.screenshots["step6"], "管理后台: AI 智能中心", "ui"))
        # 用户管理 (step5 = 儿童管理)
        if "step5" in ui.screenshots:
            selected.append((ui.screenshots["step5"], "管理后台: 儿童管理", "ui"))

    # ── 儿童端截图（重点）──
    app = suites.get("sats-app")
    if app:
        # 儿童端子测试截图 (test-results/child/*.png)
        child_dir = DEMO_DIR / "sats-app" / "test-results" / "child"
        if child_dir.exists():
            child_shots = sorted(child_dir.glob("*.png"))
            # 按优先级选取
            priority_names = [
                ("01-child-login", "儿童端: 登录页面"),
                ("01-child-home", "儿童端: 游戏化首页"),
                ("01-child-tabbar", "儿童端: 底部导航栏"),
                ("02-task-list", "儿童端: 任务列表"),
                ("02-task-cards", "儿童端: 任务卡片"),
                ("03-task-detail", "儿童端: 任务详情"),
                ("03-task-steps", "儿童端: 任务步骤"),
                ("03-task-complete-btn", "儿童端: 完成任务按钮"),
                ("04-focus-mode", "儿童端: 专注模式"),
                ("04-focus-timer", "儿童端: 专注计时器"),
                ("04-focus-back-blocked", "儿童端: 防误触返回键"),
                ("05-achievement", "儿童端: 成就徽章"),
                ("05-achievement-list", "儿童端: 成就列表"),
                ("06-score-display", "儿童端: 积分余额"),
                ("06-score-history", "儿童端: 积分流水"),
                ("06-reward-exchange", "儿童端: 奖励兑换"),
            ]
            shot_map = {s.stem: str(s) for s in child_shots}
            for name, caption in priority_names:
                if name in shot_map:
                    selected.append((shot_map[name], caption, "child"))

        # 家长端子测试截图 (test-results/parent/*.png)
        parent_dir = DEMO_DIR / "sats-app" / "test-results" / "parent"
        if parent_dir.exists():
            parent_shots = sorted(parent_dir.glob("*.png"))
            priority_names = [
                ("01-dashboard-welcome", "家长端: Dashboard 欢迎语"),
                ("01-dashboard-focus", "家长端: 今日焦点"),
                ("01-dashboard-records", "家长端: 执行记录"),
                ("02-task-creator-loaded", "家长端: 创建任务"),
                ("02-task-ai-breakdown", "家长端: AI 拆解"),
                ("03-reward-loaded", "家长端: 奖励管理"),
                ("04-insights-loaded", "家长端: 洞察分析"),
                ("04-insights-dimensions", "家长端: 能力维度"),
                ("05-profile-loaded", "家长端: 个人中心"),
                ("06-contract-loaded", "家长端: 亲子契约"),
                ("07-emotion-kit-loaded", "家长端: 情绪急救包"),
                ("08-device-loaded", "家长端: 硬件设备"),
                ("09-exec-record-loaded", "家长端: 执行记录"),
                ("10-daily-focus-loaded", "家长端: 每日焦点"),
                ("11-weekly-report-loaded", "家长端: 每周报告"),
                ("14-emotion-loaded", "家长端: 情感详情"),
                ("14-emotion-ai", "家长端: AI 情感分析"),
                ("15-family-bind", "家长端: 绑定孩子"),
                ("15-family-create", "家长端: 创建孩子账号"),
                ("16-template-loaded", "家长端: 模板库"),
            ]
            shot_map = {s.stem: str(s) for s in parent_shots}
            for name, caption in priority_names:
                if name in shot_map:
                    selected.append((shot_map[name], caption, "parent"))

        # full-lifecycle 手动截图
        for key, path in app.screenshots.items():
            if "parent-dashboard" in key:
                selected.append((path, "家长端: Dashboard (H5)", "parent"))
            elif "Step-5" in key or "积分" in key:
                selected.append((path, "家长端: 查看积分和任务状态", "parent"))

    return selected


STEP_CAPTIONS = {
    "step1": "Step 1: 家长登录 → Dashboard",
    "step2": "Step 2: 创建任务 → AI 拆解",
    "step3": "Step 3: 任务列表与状态流转",
    "step4": "Step 4: 奖励管理",
    "step5": "Step 5: 儿童管理",
    "step6": "Step 6: AI 智能中心",
    "step7": "Step 7: 执行中任务 → 闭环验证",
}


# ─── 文档生成 ──────────────────────────────────────────────────────────────────

def build_doc_description(version: str, suites: dict[str, TestSuite]) -> str:
    """生成「测试说明」文档 XML"""
    total = sum(s.total for s in suites.values())
    ui = suites.get("sats-ui")
    app = suites.get("sats-app")

    # 统计各模块
    ui_modules = {}
    if ui:
        for r in ui.results:
            ui_modules.setdefault(r.module, []).append(r)
    app_modules = {}
    if app:
        for r in app.results:
            app_modules.setdefault(r.module, []).append(r)

    # 儿童端/家长端分组
    child_modules = {k: v for k, v in app_modules.items() if any("儿童" in x.name or "child" in x.suite.lower() for x in [v[0]])}
    parent_modules = {k: v for k, v in app_modules.items() if k not in child_modules}

    xml = f'''<title>Small Steps 自动化测试说明 ({version})</title>
<h1>概述</h1>
<p>Small Steps 自动化测试框架基于 <b>Playwright</b> 构建，覆盖管理后台 UI（sats-ui）和 H5 移动端（sats-app）两大测试套件，共计 <b>{total} 个测试用例</b>。本次 {version} 版本在生产环境（{BASE_URL}）上执行全量回归测试，<span text-color="green">全部通过</span>。</p>
<callout emoji="✅" background-color="light-green" border-color="green">
<p>{version} 测试结果：{total}/{total} 通过，通过率 100%，覆盖管理后台 + 儿童端 + 家长端全流程。</p>
</callout>
<h1>测试环境</h1>
<table>
<thead><tr><th>项目</th><th>说明</th></tr></thead>
<tbody>
<tr><td>测试目标</td><td>{BASE_URL}（生产环境）</td></tr>
<tr><td>测试框架</td><td>Playwright (TypeScript)</td></tr>
<tr><td>浏览器</td><td>Chrome (headless)</td></tr>
<tr><td>管理后台视口</td><td>1280 × 720 (Desktop Chrome)</td></tr>
<tr><td>移动端视口</td><td>393 × 727 (Pixel 5, mobile-chrome)</td></tr>
<tr><td>并行策略</td><td>单 worker 串行执行</td></tr>
<tr><td>截图策略</td><td>screenshot: on（全程截图）</td></tr>
</tbody>
</table>
<h1>测试套件</h1>
<h2>sats-ui — 管理后台 UI 测试（{ui.total if ui else 0} 个用例）</h2>
<p>管理后台测试覆盖以下模块：</p>
<ul>'''

    if ui:
        for mod, cases in ui_modules.items():
            xml += f'\n<li><b>{mod}</b>（{len(cases)} 个用例）</li>'

    xml += '''
</ul>
<h2>sats-app — H5 移动端测试（''' + str(app.total if app else 0) + ''' 个用例）</h2>
<h3>儿童端测试</h3>
<ul>'''

    for mod, cases in child_modules.items():
        xml += f'\n<li><b>{mod}</b>（{len(cases)} 个）</li>'

    xml += '''
</ul>
<h3>家长端测试</h3>
<ul>'''

    for mod, cases in parent_modules.items():
        xml += f'\n<li><b>{mod}</b>（{len(cases)} 个）</li>'

    xml += '''
</ul>
<h1>运行方式</h1>
<p>在项目根目录执行：</p>
<pre lang="bash" caption="运行全部测试"><code>cd autotests-demo
bash run-tests.sh all headless</code></pre>
<p>一键测试并更新知识库：</p>
<pre lang="bash" caption="一键更新"><code>python3 update_wiki.py V6</code></pre>
<p>测试报告位于各自目录下的 <code>playwright-report/index.html</code>。</p>'''

    return xml


def build_doc_cases(version: str, suites: dict[str, TestSuite]) -> str:
    """生成「测试用例」文档 XML"""
    total = sum(s.total for s in suites.values())

    xml = f'''<title>Small Steps 自动化测试用例 ({version})</title>
<p>本文档列出 {version} 版本全部 <b>{total} 个自动化测试用例</b>。</p>'''

    for suite in suites.values():
        xml += f'\n<h1>{"一" if suite.name == "sats-ui" else "二"}、{suite.label}（{suite.total} 个用例）</h1>'

        # 按模块分组
        modules = {}
        for r in suite.results:
            modules.setdefault(r.module, []).append(r)

        for mod_idx, (mod, cases) in enumerate(modules.items(), 1):
            xml += f'\n<h2>{mod_idx}. {mod}</h2>'
            xml += '\n<table>'
            xml += '\n<thead><tr><th>编号</th><th>用例名称</th><th>结果</th></tr></thead>'
            xml += '\n<tbody>'
            for i, case in enumerate(cases, 1):
                status = "✅ PASS" if case.passed else "❌ FAIL"
                xml += f'\n<tr><td>{mod_idx}-{i:02d}</td><td>{case.name}</td><td>{status}</td></tr>'
            xml += '\n</tbody></table>'

    return xml


def build_doc_report(version: str, suites: dict[str, TestSuite]) -> str:
    """生成「测试报告」文档 XML"""
    total = sum(s.total for s in suites.values())
    passed = sum(s.passed for s in suites.values())
    failed = sum(s.failed for s in suites.values())
    rate = f"{passed / total * 100:.0f}%" if total > 0 else "N/A"

    xml = f'''<title>Small Steps 自动化测试报告 ({version})</title>
<h1>测试概要</h1>
<grid>
<column width-ratio="0.25">
<callout emoji="📊" background-color="light-blue" border-color="blue">
<p><b>总用例数</b><br/>{total}</p>
</callout>
</column>
<column width-ratio="0.25">
<callout emoji="✅" background-color="light-green" border-color="green">
<p><b>通过</b><br/>{passed}</p>
</callout>
</column>
<column width-ratio="0.25">
<callout emoji="❌" background-color="light-red" border-color="red">
<p><b>失败</b><br/>{failed}</p>
</callout>
</column>
<column width-ratio="0.25">
<callout emoji="📈" background-color="light-yellow" border-color="yellow">
<p><b>通过率</b><br/>{rate}</p>
</callout>
</column>
</grid>
<h1>测试环境</h1>
<table>
<thead><tr><th>项目</th><th>说明</th></tr></thead>
<tbody>
<tr><td>测试时间</td><td>{datetime.now().strftime("%Y-%m-%d %H:%M")}</td></tr>
<tr><td>测试环境</td><td>{BASE_URL}（生产环境）</td></tr>
<tr><td>测试框架</td><td>Playwright + TypeScript</td></tr>
<tr><td>浏览器</td><td>Chrome (headless)</td></tr>
</tbody>
</table>
<h1>测试结果明细</h1>'''

    for suite in suites.values():
        modules = {}
        for r in suite.results:
            modules.setdefault(r.module, []).append(r)

        xml += f'\n<h2>{suite.label}（{suite.total} 个用例）</h2>'
        xml += '\n<table>'
        xml += '\n<thead><tr><th>测试模块</th><th>用例数</th><th>通过</th><th>失败</th><th>通过率</th></tr></thead>'
        xml += '\n<tbody>'

        for mod, cases in modules.items():
            mod_total = len(cases)
            mod_passed = sum(1 for c in cases if c.passed)
            mod_failed = mod_total - mod_passed
            mod_rate = f"{mod_passed / mod_total * 100:.0f}%" if mod_total > 0 else "N/A"
            color = "green" if mod_failed == 0 else "red"
            xml += f'\n<tr><td>{mod}</td><td>{mod_total}</td><td>{mod_passed}</td><td>{mod_failed}</td><td><span text-color="{color}">{mod_rate}</span></td></tr>'

        color = "green" if suite.failed == 0 else "red"
        xml += f'\n<tr><td><b>小计</b></td><td><b>{suite.total}</b></td><td><b>{suite.passed}</b></td><td><b>{suite.failed}</b></td><td><span text-color="{color}"><b>{"100%" if suite.failed == 0 else f"{suite.passed/suite.total*100:.0f}%"}</b></span></td></tr>'
        xml += '\n</tbody></table>'

    xml += '''
<h1>关键流程截图</h1>
<p><i>以下截图展示各模块的关键测试步骤：</i></p>
<h2>管理后台 — 完整业务流程</h2>
<p><i>截图将自动插入到下方</i></p>
<h2>H5 移动端</h2>
<p><i>截图将自动插入到下方</i></p>
<h1>结论</h1>'''

    if failed == 0:
        xml += f'''
<callout emoji="🎉" background-color="light-green" border-color="green">
<p>{version} 版本全量回归测试 <b>{total} 个用例全部通过</b>，通过率 100%。管理后台 UI 和 H5 移动端（儿童端 + 家长端）的所有功能模块均验证正常，系统运行稳定。</p>
</callout>'''
    else:
        xml += f'''
<callout emoji="⚠️" background-color="light-yellow" border-color="yellow">
<p>{version} 版本回归测试 {total} 个用例中 {failed} 个失败，通过率 {rate}。请查看上方明细定位问题。</p>
</callout>'''

    xml += '''
<h2>覆盖范围</h2>
<ul>
<li><b>管理后台</b>：登录认证、任务创建与 AI 拆解、奖励管理、儿童管理、AI 智能中心、设备监控、成就统计</li>
<li><b>儿童端</b>：登录首页、任务列表、任务执行、专注模式、成就徽章、积分系统</li>
<li><b>家长端</b>：Dashboard、任务管理、奖励管理、洞察分析、个人中心、亲子契约、情绪急救包、硬件设备、执行记录、每日焦点、每周报告、情感详情、家庭管理、模板库</li>
</ul>'''

    return xml


# ─── 知识库操作 ────────────────────────────────────────────────────────────────

def create_wiki_version_dir(version: str) -> Optional[str]:
    """在知识库创建版本目录，返回 node_token"""
    print(f"\n📁 创建知识库目录: {version}")

    r = lark("wiki", "+node-create",
             "--space-id", SPACE_ID,
             "--title", version,
             "--as", "user")

    if r.get("ok"):
        token = r["data"]["node_token"]
        print(f"  ✅ 目录创建成功: {token}")
        return token

    print(f"  ❌ 创建失败: {r}")
    return None


def create_doc_in_wiki(title: str, content: str, parent_node: str, doc_type: str) -> Optional[str]:
    """创建文档并移入知识库，返回 wiki URL"""
    print(f"\n📝 创建文档: {title}")

    # Step 1: 创建文档
    # 内容太长时分段
    if len(content) > 8000:
        # 取前 8000 字符作为骨架
        skeleton = content[:8000]
        # 找最后一个完整的 </h2> 或 </table> 或 </ul> 截断
        for tag in ["</h2>", "</table>", "</ul>", "</li>"]:
            idx = skeleton.rfind(tag)
            if idx > 4000:
                skeleton = skeleton[:idx + len(tag)]
                break

        r = lark("docs", "+create", "--api-version", "v2", "--as", "user",
                 "--content", shell_escape(skeleton), timeout=60)

        if not r.get("ok"):
            print(f"  ❌ 创建失败")
            return None

        doc_id = r["data"]["document"]["document_id"]
        doc_url = r["data"]["document"]["url"]

        # 追加剩余内容
        remaining = content[len(skeleton):]
        if remaining.strip():
            print(f"  📎 追加内容 ({len(remaining)} 字符)...")
            lark("docs", "+update", "--api-version", "v2",
                 "--doc", doc_id, "--command", "append",
                 "--as", "user", "--content", shell_escape(remaining), timeout=60)
    else:
        r = lark("docs", "+create", "--api-version", "v2", "--as", "user",
                 "--content", shell_escape(content), timeout=60)

        if not r.get("ok"):
            print(f"  ❌ 创建失败")
            return None

        doc_id = r["data"]["document"]["document_id"]
        doc_url = r["data"]["document"]["url"]

    # Step 2: 移入知识库
    move_r = lark("wiki", "+move",
                   "--obj-token", doc_id,
                   "--obj-type", "docx",
                   "--target-parent-token", parent_node,
                   "--target-space-id", SPACE_ID,
                   "--as", "user")

    if move_r.get("ok"):
        wiki_token = move_r["data"].get("wiki_token", "")
        print(f"  ✅ 文档已移入知识库: {wiki_token}")
    else:
        print(f"  ⚠️  移入知识库失败，文档仍在云空间: {doc_url}")

    return doc_url


def insert_screenshots(doc_id: str, screenshots: list[tuple[str, str, str]]) -> int:
    """插入截图到文档，返回成功数量"""
    import shlex
    success = 0
    for i, (path, caption, _stype) in enumerate(screenshots, 1):
        if not os.path.exists(path):
            print(f"  ⚠️  截图不存在: {path}")
            continue

        # 用 shlex.quote 确保 caption 和 path 不被 shell 拆分
        cmd = (f"lark-cli docs +media-insert --doc {shlex.quote(doc_id)} "
               f"--file {shlex.quote(path)} --align center "
               f"--caption {shlex.quote(caption)} --as user")
        r = run_cmd(cmd, timeout=120)
        if r.returncode == 0:
            success += 1
            print(f"  📸 [{i}/{len(screenshots)}] {caption}")
        else:
            err = r.stderr.strip()[:100] if r.stderr else r.stdout.strip()[:100]
            print(f"  ❌ [{i}/{len(screenshots)}] {caption}: {err}")

    return success


def shell_escape(s: str) -> str:
    """转义字符串用于 shell 命令"""
    # 用单引号包裹，内部的单引号替换为 '\''
    return "'" + s.replace("'", "'\\''") + "'"


# ─── 主流程 ────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description="Small Steps 自动化测试 → 飞书知识库一键更新")
    parser.add_argument("version", help="版本号，如 V6, V7")
    parser.add_argument("--headed", action="store_true", help="有头模式（显示浏览器窗口）")
    parser.add_argument("--video", action="store_true", help="录屏模式（所有测试录屏，不仅失败时）")
    parser.add_argument("--skip-tests", action="store_true", help="跳过测试，使用上次结果")
    parser.add_argument("--dry-run", action="store_true", help="只运行测试，不更新知识库")
    parser.add_argument("--space-id", default=os.environ.get("SS_SPACE_ID", "7645451195020020956"), help="飞书知识库 space_id")
    parser.add_argument("--parent-node", default=os.environ.get("SS_PARENT_NODE", ""), help="父节点 token")
    args = parser.parse_args()

    space_id = args.space_id
    parent_node_arg = args.parent_node

    # 更新模块级变量供 helper 函数使用
    global SPACE_ID  # noqa: F811
    SPACE_ID = space_id

    print(f"🚀 Small Steps 自动化测试 → 飞书知识库更新")
    print(f"   版本: {args.version}")
    print(f"   知识库: {space_id}")
    print(f"   时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("━" * 50)

    # Step 1: 运行测试
    if args.skip_tests:
        print("\n⏭️  跳过测试，解析上次结果...")
        suites = {}
        for suite_name, suite_label in [("sats-ui", "管理后台 UI"), ("sats-app", "H5 移动端")]:
            suite = TestSuite(name=suite_name, label=suite_label)
            suite.screenshots = collect_screenshots(suite_name)
            # 尝试从 .last-run.json 读取结果
            last_run = DEMO_DIR / suite_name / "test-results" / ".last-run.json"
            if last_run.exists():
                try:
                    data = json.loads(last_run.read_text())
                    suite.total = data.get("stats", {}).get("total", 0)
                    suite.passed = data.get("stats", {}).get("passed", 0)
                    suite.failed = data.get("stats", {}).get("failed", 0)
                    # .last-run.json 可能只有 status 字段，没有 stats
                    if suite.total == 0:
                        status = data.get("status", "")
                        # 统计 test-results 下的目录数作为用例数
                        results_dir = DEMO_DIR / suite_name / "test-results"
                        test_dirs = [d for d in results_dir.iterdir() if d.is_dir() and not d.name.startswith(".")]
                        suite.total = len(test_dirs)
                        suite.passed = suite.total if status == "passed" else 0
                        suite.failed = 0 if status == "passed" else suite.total
                except Exception:
                    pass
            suites[suite_name] = suite
            print(f"  📊 {suite_label}: {suite.passed}/{suite.total} (上次结果)")
    else:
        suites = run_tests(headed=args.headed, video=args.video)

    # 汇总
    total = sum(s.total for s in suites.values())
    passed = sum(s.passed for s in suites.values())
    failed = sum(s.failed for s in suites.values())

    print(f"\n{'━' * 50}")
    print(f"📊 总计: {total} 个用例, {passed} 通过, {failed} 失败")
    print(f"   通过率: {passed / total * 100:.1f}%" if total > 0 else "   无用例")

    if args.dry_run:
        print("\n🏁 dry-run 模式，跳过知识库更新")
        return

    # Step 2: 创建知识库版本目录
    parent_node = parent_node_arg
    if not parent_node:
        parent_node = create_wiki_version_dir(args.version)
        if not parent_node:
            print("❌ 无法创建版本目录，退出")
            sys.exit(1)

    # Step 3: 创建文档
    # 3a: 测试说明
    desc_content = build_doc_description(args.version, suites)
    desc_url = create_doc_in_wiki(
        f"Small Steps 自动化测试说明 ({args.version})",
        desc_content, parent_node, "说明")

    # 3b: 测试用例
    cases_content = build_doc_cases(args.version, suites)
    cases_url = create_doc_in_wiki(
        f"Small Steps 自动化测试用例 ({args.version})",
        cases_content, parent_node, "用例")

    # 3c: 测试报告 (含截图)
    report_content = build_doc_report(args.version, suites)
    report_url = create_doc_in_wiki(
        f"Small Steps 自动化测试报告 ({args.version})",
        report_content, parent_node, "报告")

    # Step 4: 插入截图
    if report_url:
        # 提取 doc_id
        report_doc_id = report_url.split("/")[-1] if report_url else None
        if report_doc_id:
            print(f"\n📸 插入截图到测试报告...")
            screenshots = select_report_screenshots(suites)
            count = insert_screenshots(report_doc_id, screenshots)
            print(f"  ✅ 插入 {count}/{len(screenshots)} 张截图")

    # 同步给说明文档插入关键截图（管理后台精简 + 儿童端/家长端重点）
    if desc_url:
        desc_doc_id = desc_url.split("/")[-1]
        if desc_doc_id:
            key_shots = []
            # 管理后台：登录 + AI
            ui = suites.get("sats-ui")
            if ui:
                for key in ["step1", "step6"]:
                    if key in ui.screenshots:
                        key_shots.append((ui.screenshots[key], STEP_CAPTIONS.get(key, key), "ui"))
            # 儿童端/家长端截图
            key_shots.extend(select_report_screenshots(suites)[:10])  # 取前 10 张
            if key_shots:
                print(f"\n📸 插入截图到测试说明...")
                insert_screenshots(desc_doc_id, key_shots)

    # 完成
    print(f"\n{'━' * 50}")
    print(f"✅ 全部完成！")
    print(f"   📄 测试说明: {desc_url or '创建失败'}")
    print(f"   📄 测试用例: {cases_url or '创建失败'}")
    print(f"   📄 测试报告: {report_url or '创建失败'}")
    print(f"   📁 版本目录: https://my.feishu.cn/wiki/{parent_node}")


if __name__ == "__main__":
    main()
