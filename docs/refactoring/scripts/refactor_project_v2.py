import os
import shutil

# Configuration
PROJECT_ROOT = r"d:\kenzhao\cust_projects\smallsteps\projects"
OLD_PACKAGE_SEGMENT = os.path.join("org", "dromara")
NEW_PACKAGE_SEGMENT = os.path.join("com", "kenzhao", "smallsteps")

OLD_PKG_NAME = "org.dromara"
NEW_PKG_NAME = "com.kenzhao.smallsteps"

IGNORE_DIRS = {".git", ".idea", "target", "node_modules", "dist", ".vscode"}
EXTENSIONS_TO_PROCESS = {".java", ".xml", ".yml", ".yaml", ".properties", ".md", ".txt", ".js", ".ts", ".vue"}

def replace_content(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Replace package names
        content = content.replace(OLD_PKG_NAME, NEW_PKG_NAME)
        # Replace Dromara -> SmallSteps (case sensitive)
        content = content.replace("Dromara", "SmallSteps")
        content = content.replace("dromara", "smallsteps")

        if content != original_content:
            print(f"Updating content: {file_path}")
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def move_packages(root_dir):
    for dirpath, dirnames, filenames in os.walk(root_dir, topdown=False):
        if any(ignored in dirpath.split(os.sep) for ignored in IGNORE_DIRS):
            continue

        # Check if this directory ends with org/dromara
        if dirpath.endswith(OLD_PACKAGE_SEGMENT):
            parent_of_org = os.path.dirname(os.path.dirname(dirpath)) # .../src/main/java
            
            # Construct new path: .../src/main/java/com/kenzhao/smallsteps
            new_path = os.path.join(parent_of_org, NEW_PACKAGE_SEGMENT)
            
            print(f"Moving package: {dirpath} -> {new_path}")
            if not os.path.exists(new_path):
                os.makedirs(new_path)
            
            # Move content
            for item in os.listdir(dirpath):
                src = os.path.join(dirpath, item)
                dst = os.path.join(new_path, item)
                if os.path.exists(dst):
                    if os.path.isdir(src):
                        shutil.copytree(src, dst, dirs_exist_ok=True)
                        shutil.rmtree(src)
                else:
                    shutil.move(src, dst)
            
            # Try to remove empty parent dirs (org/dromara -> org)
            try:
                os.rmdir(dirpath) # remove dromara
                os.rmdir(os.path.dirname(dirpath)) # remove org
            except:
                pass

def rename_files(root_dir):
    for dirpath, dirnames, filenames in os.walk(root_dir):
        if any(ignored in dirpath.split(os.sep) for ignored in IGNORE_DIRS):
            continue
            
        for filename in filenames:
            if "Dromara" in filename:
                new_filename = filename.replace("Dromara", "SmallSteps")
                old_path = os.path.join(dirpath, filename)
                new_path = os.path.join(dirpath, new_filename)
                print(f"Renaming file: {filename} -> {new_filename}")
                os.rename(old_path, new_path)

def process_all_files(root_dir):
    for dirpath, dirnames, filenames in os.walk(root_dir):
        if any(ignored in dirpath.split(os.sep) for ignored in IGNORE_DIRS):
            continue
        for filename in filenames:
            ext = os.path.splitext(filename)[1]
            if ext in EXTENSIONS_TO_PROCESS:
                replace_content(os.path.join(dirpath, filename))

def main():
    print("--- Phase 1: Moving org.dromara packages ---")
    move_packages(PROJECT_ROOT)
    
    print("--- Phase 2: Renaming Dromara files ---")
    rename_files(PROJECT_ROOT)
    
    print("--- Phase 3: Updating content ---")
    process_all_files(PROJECT_ROOT)

if __name__ == "__main__":
    main()
