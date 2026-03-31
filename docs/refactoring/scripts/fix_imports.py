import os

# Configuration
PROJECT_ROOT = r"d:\kenzhao\cust_projects\smallsteps\projects"

# Import Reversions: Incorrect -> Correct
IMPORT_REVERSIONS = {
    "import com.kenzhao.smallsteps.sms4j": "import org.dromara.sms4j",
    "import com.kenzhao.smallsteps.warm": "import org.dromara.warm",
    # Just in case these were also hit
    "import com.kenzhao.smallsteps.hutool": "import cn.hutool",
    "import com.kenzhao.smallsteps.satoken": "import cn.dev33.satoken",
    "import com.kenzhao.smallsteps.justauth": "import me.zhyd.oauth",
    "import com.kenzhao.smallsteps.lock4j": "import com.baomidou.lock",
    "import com.kenzhao.smallsteps.dynamic": "import com.baomidou.dynamic",
    "import com.kenzhao.smallsteps.mybatis": "import com.baomidou.mybatisplus",
}

EXTENSIONS_TO_PROCESS = {".java"}

def replace_content(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        for bad, good in IMPORT_REVERSIONS.items():
            content = content.replace(bad, good)

        if content != original_content:
            print(f"Fixing imports in: {file_path}")
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    print("--- Fixing broken imports ---")
    for dirpath, dirnames, filenames in os.walk(PROJECT_ROOT):
        if "node_modules" in dirpath: continue
        
        for filename in filenames:
            ext = os.path.splitext(filename)[1]
            if ext in EXTENSIONS_TO_PROCESS:
                replace_content(os.path.join(dirpath, filename))
    print("Fix complete.")

if __name__ == "__main__":
    main()
