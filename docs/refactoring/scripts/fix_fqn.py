import os

# Configuration
PROJECT_ROOT = r"d:\kenzhao\cust_projects\smallsteps\projects"

# Reversions: Incorrect -> Correct
REVERSIONS = {
    "com.kenzhao.smallsteps.sms4j": "org.dromara.sms4j",
    "com.kenzhao.smallsteps.warm": "org.dromara.warm",
    "com.kenzhao.smallsteps.hutool": "cn.hutool",
    "com.kenzhao.smallsteps.satoken": "cn.dev33.satoken",
    "com.kenzhao.smallsteps.justauth": "me.zhyd.oauth",
}

EXTENSIONS_TO_PROCESS = {".java"}

def replace_content(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        for bad, good in REVERSIONS.items():
            content = content.replace(bad, good)

        if content != original_content:
            print(f"Fixing FQN in: {file_path}")
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    print("--- Fixing broken fully qualified names ---")
    for dirpath, dirnames, filenames in os.walk(PROJECT_ROOT):
        if "node_modules" in dirpath: continue
        
        for filename in filenames:
            ext = os.path.splitext(filename)[1]
            if ext in EXTENSIONS_TO_PROCESS:
                replace_content(os.path.join(dirpath, filename))
    print("Fix complete.")

if __name__ == "__main__":
    main()
