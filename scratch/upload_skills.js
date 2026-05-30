const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const SPACE_ID = '7645635962633997248'; // "ken的工作空间" 的 space_id

// 敏感信息过滤清洗函数
function cleanContent(text) {
  let clean = text;
  
  // 1. 替换密码、API密钥、数据库密码等敏感字符串为 "kenzhaopasswordkey"
  clean = clean.replace(/abdSSsaf#[a-zA-Z0-9\^#~!@]+/g, 'kenzhaopasswordkey');
  clean = clean.replace(/ui123456789~/g, 'kenzhaopasswordkey');
  clean = clean.replace(/Aa123456/g, 'kenzhaopasswordkey');
  clean = clean.replace(/admin123/g, 'kenzhaopasswordkey');
  clean = clean.replace(/gly321\?\?gly321!!/g, 'kenzhaopasswordkey');

  // 2. 替换所有 Staging/局域网 IP
  clean = clean.replace(/10\.8\.0\.\d+/g, 'kenzhaopasswordkey');
  clean = clean.replace(/192\.168\.\d+\.\d+/g, 'kenzhaopasswordkey');

  // 3. 替换任何可能包含 token/secret/password/key 等敏感字眼的字面值
  clean = clean.replace(/password: '[^']+'/gi, "password: 'kenzhaopasswordkey'");
  clean = clean.replace(/password: "[^"]+"/gi, 'password: "kenzhaopasswordkey"');

  return clean;
}

// 执行命令行并解析为 JSON
function runCmd(cmd) {
  try {
    const stdout = execSync(cmd, { encoding: 'utf-8', stdio: ['pipe', 'pipe', 'pipe'] });
    const jsonStart = stdout.indexOf('{');
    if (jsonStart !== -1) {
      const jsonStr = stdout.substring(jsonStart);
      return JSON.parse(jsonStr);
    }
    return { ok: true, stdout };
  } catch (e) {
    console.error(`❌ 执行命令失败: ${cmd}`);
    if (e.stderr) {
      console.error("Stderr:", e.stderr.toString());
    }
    throw e;
  }
}

async function uploadAllSkills() {
  console.log("🚀 [Lark Upload] 开始整理项目及全局 Skills...");

  // 1. 定义我们所使用的 skills 列表
  const skillsToProcess = [
    {
      category: 'global',
      name: 'android-cli',
      localPath: 'C:\\Users\\kenzhao\\.gemini\\config\\plugins\\android-cli-plugin\\skills\\SKILL.md'
    },
    {
      category: 'global',
      name: 'workflow-skill-creator',
      localPath: 'C:\\Users\\kenzhao\\.gemini\\config\\plugins\\science\\skills\\workflow_skill_creator\\SKILL.md'
    },
    {
      category: 'global',
      name: 'literature-search-arxiv',
      localPath: 'C:\\Users\\kenzhao\\.gemini\\config\\plugins\\science\\skills\\literature_search_arxiv\\SKILL.md'
    },
    {
      category: 'project',
      name: 'knowledge_garden',
      localPath: 'D:\\kenzhao\\cust_projects\\ss\\.agent\\skills\\knowledge_garden\\SKILL.md'
    }
  ];

  // 2. 检查并创建根分类目录（去重机制）
  let parentGlobalToken = '';
  let parentProjectToken = '';

  console.log("🔍 检查当前空间根目录下的已有节点...");
  try {
    const rootList = runCmd(`lark-cli wiki +node-list --space-id ${SPACE_ID} --as user`);
    if (rootList.ok && rootList.data && rootList.data.items) {
      for (const item of rootList.data.items) {
        if (item.title === "全局通用技能 (Global Universal Skills)") {
          parentGlobalToken = item.node_token;
        } else if (item.title === "本地项目技能 (Project Specific Skills)") {
          parentProjectToken = item.node_token;
        }
      }
    }
  } catch (e) {
    console.log("⚠️ 无法获取根目录节点列表，将默认创建新节点");
  }

  if (!parentGlobalToken) {
    console.log("📁 正在创建 '全局通用技能 (Global)' 目录节点...");
    const createGlobalDir = runCmd(`lark-cli wiki +node-create --space-id ${SPACE_ID} --as user --title "全局通用技能 (Global Universal Skills)"`);
    parentGlobalToken = createGlobalDir.data.node_token;
    console.log(`✅ 创建成功! Token: ${parentGlobalToken}`);
  } else {
    console.log(`📁 复用已有 '全局通用技能 (Global)' 目录节点 Token: ${parentGlobalToken}`);
  }

  if (!parentProjectToken) {
    console.log("📁 正在创建 '本地项目技能 (Project)' 目录节点...");
    const createProjectDir = runCmd(`lark-cli wiki +node-create --space-id ${SPACE_ID} --as user --title "本地项目技能 (Project Specific Skills)"`);
    parentProjectToken = createProjectDir.data.node_token;
    console.log(`✅ 创建成功! Token: ${parentProjectToken}`);
  } else {
    console.log(`📁 复用已有 '本地项目技能 (Project)' 目录节点 Token: ${parentProjectToken}`);
  }

  // 3. 逐个处理并上传每一个 Skill
  for (const skill of skillsToProcess) {
    console.log(`\n📄 正在整理技能: [${skill.category}] ${skill.name}...`);
    
    // 读取本地 MD 文件
    if (!fs.existsSync(skill.localPath)) {
      console.log(`⚠️ 文件不存在: ${skill.localPath}，跳过该技能。`);
      continue;
    }
    const rawContent = fs.readFileSync(skill.localPath, 'utf-8');

    // 清理敏感词与安全隐私信息
    const cleanedContent = cleanContent(rawContent);

    // 写入 scratch 目录作为临时清洁的 MD 文件
    const scratchDir = path.resolve(__dirname, '../scratch');
    if (!fs.existsSync(scratchDir)) {
      fs.mkdirSync(scratchDir, { recursive: true });
    }
    const cleanFilePath = path.join(scratchDir, `clean_${skill.name}.md`);
    fs.writeFileSync(cleanFilePath, cleanedContent, 'utf-8');
    console.log(`🧹 敏感词清理完成，已安全存储至临时文件: ${cleanFilePath}`);

    // 检查子文档节点是否已存在
    const parentToken = skill.category === 'global' ? parentGlobalToken : parentProjectToken;
    let docToken = '';
    
    console.log(`🔍 检查分类目录下是否已存在子文档 "${skill.name}"...`);
    try {
      const childList = runCmd(`lark-cli wiki +node-list --space-id ${SPACE_ID} --parent-node-token ${parentToken} --as user`);
      if (childList.ok && childList.data && childList.data.items) {
        for (const item of childList.data.items) {
          if (item.title === skill.name) {
            docToken = item.obj_token; // 注意：写入文档需要的是 obj_token！
            console.log(`📁 复用已有子文档节点, Document Token: ${docToken}`);
            break;
          }
        }
      }
    } catch (e) {
      console.log("⚠️ 获取子节点列表失败，将默认创建新文档");
    }

    if (!docToken) {
      console.log(`📝 在飞书 Wiki 对应目录下新建子节点 "${skill.name}"...`);
      const createSubNode = runCmd(`lark-cli wiki +node-create --parent-node-token ${parentToken} --as user --title "${skill.name}"`);
      docToken = createSubNode.data.obj_token;
      console.log(`✅ 新节点创建成功! Document Token: ${docToken}`);
    }

    // 上传并覆盖写入文档内容
    console.log("📤 正在将安全整理后的 Markdown 一键上传写入飞书文档...");
    // 飞书 docs +update (API v2) 规范参数
    const uploadCmd = `lark-cli docs +update --api-version v2 --as user --doc "${docToken}" --command overwrite --doc-format markdown --content "@./scratch/clean_${skill.name}.md"`;
    const uploadRes = runCmd(uploadCmd);
    
    if (uploadRes.ok) {
      console.log(`🎉 技能 [${skill.name}] 已 100% 成功整理并安全导入飞书知识库！`);
    } else {
      console.error(`❌ 技能 [${skill.name}] 导入失败！`);
    }
  }

  console.log("\n🎊 [Lark Upload] 本项目所使用的全部 Skills 已成功整理、清洗，并按照目录发布至“ken的工作空间”！");
}

uploadAllSkills().catch(console.error);
