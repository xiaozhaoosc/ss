import os

# Configuration
PROJECT_ROOT = r"d:\kenzhao\cust_projects\smallsteps\projects"

# Reversions: Incorrect -> Correct
REVERSIONS = {
    "<groupId>com.kenzhao.smallsteps.sms4j</groupId>": "<groupId>org.dromara.sms4j</groupId>",
    "<groupId>com.kenzhao.smallsteps.warm</groupId>": "<groupId>org.dromara.warm</groupId>",
    "<groupId>com.kenzhao.smallsteps.hutool</groupId>": "<groupId>cn.hutool</groupId>", # Just in case
    "<groupId>com.kenzhao.smallsteps.justauth</groupId>": "<groupId>me.zhyd.oauth</groupId>", # Just in case
}

EXTENSIONS_TO_PROCESS = {".xml"}

def replace_content(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        for bad, good in REVERSIONS.items():
            content = content.replace(bad, good)

        if content != original_content:
            print(f"Fixing dependencies in: {file_path}")
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    print("--- Fixing broken dependencies ---")
    for dirpath, dirnames, filenames in os.walk(PROJECT_ROOT):
        if "node_modules" in dirpath: continue
        
        for filename in filenames:
            if filename.endswith(".xml"):
                replace_content(os.path.join(dirpath, filename))
    print("Fix complete.")

if __name__ == "__main__":
    main()
