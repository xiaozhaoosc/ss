import os

# Configuration
PROJECT_ROOT = r"d:\kenzhao\cust_projects\smallsteps\projects"

REPLACEMENTS = {
    "RuoYi-Vue-Plus": "SmallSteps-Vue-Plus",
    "Ruoyi-Vue-Plus": "SmallSteps-Vue-Plus",
    "ruoyi-vue-plus": "smallsteps-vue-plus",
    "Copyright (c) 2018 RuoYi": "Copyright (c) 2026 SmallSteps",
    "Copyright (c) 2019 RuoYi": "Copyright (c) 2026 SmallSteps",
    "requirepass ruoyi123": "requirepass smallsteps123",
    "SA_PASSWORD: \"Ruoyi@123\"": "SA_PASSWORD: \"SmallSteps@123\"",
}

EXTENSIONS_TO_PROCESS = {".md", ".yml", ".yaml", ".conf", "LICENSE"}

def replace_content(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        for old, new in REPLACEMENTS.items():
            content = content.replace(old, new)

        if content != original_content:
            print(f"Cleaning leftovers in: {file_path}")
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    print("--- Cleaning leftover strings ---")
    for dirpath, dirnames, filenames in os.walk(PROJECT_ROOT):
        if "node_modules" in dirpath: continue
        
        for filename in filenames:
            if filename in ["LICENSE"] or os.path.splitext(filename)[1] in EXTENSIONS_TO_PROCESS:
                 replace_content(os.path.join(dirpath, filename))
    print("Cleanup complete.")

if __name__ == "__main__":
    main()
