import os

# Configuration
PROJECT_ROOT = r"d:\kenzhao\cust_projects\smallsteps\projects\smallsteps-api\smallsteps-common\smallsteps-ai"

# Reversions: Incorrect -> Correct
REPLACEMENTS = {
    "import com.kenzhao.smallsteps.common.core.domain.BaseEntity;": "import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;",
}

EXTENSIONS_TO_PROCESS = {".java"}

def replace_content(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        for bad, good in REPLACEMENTS.items():
            content = content.replace(bad, good)

        if content != original_content:
            print(f"Fixing imports in: {file_path}")
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    print("--- Fixing BaseEntity imports ---")
    for dirpath, dirnames, filenames in os.walk(PROJECT_ROOT):
        for filename in filenames:
            ext = os.path.splitext(filename)[1]
            if ext in EXTENSIONS_TO_PROCESS:
                replace_content(os.path.join(dirpath, filename))
    print("Fix complete.")

if __name__ == "__main__":
    main()
