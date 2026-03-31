import os
import shutil
import re

# Configuration
PROJECT_ROOT = r"d:\kenzhao\cust_projects\smallsteps\projects"
OLD_NAME = "ruoyi"
NEW_NAME = "smallsteps"
OLD_AUTHOR = "ruoyi"
NEW_AUTHOR = "kenzhao"
OLD_PACKAGE = "com.ruoyi"
NEW_PACKAGE = "com.kenzhao.smallsteps"
OLD_PACKAGE_PATH = os.path.join("com", "ruoyi")
NEW_PACKAGE_PATH = os.path.join("com", "kenzhao", "smallsteps")

# Mappings for case-sensitive replacements
REPLACEMENTS = {
    "com.ruoyi": "com.kenzhao.smallsteps",
    "ruoyi": "smallsteps",
    "RuoYi": "SmallSteps",
    "RUOYI": "SMALLSTEPS",
    f"@author {OLD_AUTHOR}": f"@author {NEW_AUTHOR}"
}

IGNORE_DIRS = {".git", ".idea", "target", "node_modules", "dist", ".vscode"}
EXTENSIONS_TO_PROCESS = {".java", ".xml", ".yml", ".yaml", ".properties", ".md", ".txt", ".js", ".ts", ".vue", ".json", ".html", ".css", ".scss", ".sql", ".bat", ".sh"}

def replace_content(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Apply strict replacements first
        content = content.replace("com/ruoyi", "com/kenzhao/smallsteps")
        
        # Apply configured replacements
        for old, new in REPLACEMENTS.items():
             # Use regex for word boundaries for "ruoyi" -> "smallsteps" to avoid replacing substrings in other words if necessary
             # But here, "ruoyi" is quite specific.
             content = content.replace(old, new)

        if content != original_content:
            print(f"Updating content: {file_path}")
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
    except Exception as e:
        print(f"Error processing file {file_path}: {e}")

def rename_directories(root_dir):
    """
    Renames directories:
    1. ruoyi-xxx -> smallsteps-xxx
    2. com/ruoyi -> com/kenzhao/smallsteps
    """
    # Walk bottom-up to rename children before parents
    for dirpath, dirnames, filenames in os.walk(root_dir, topdown=False):
        # Skip ignore dirs
        if any(ignored in dirpath.split(os.sep) for ignored in IGNORE_DIRS):
            continue

        dirname = os.path.basename(dirpath)
        parent_dir = os.path.dirname(dirpath)
        
        # 1. Handle Package Path: com/ruoyi -> com/kenzhao/smallsteps
        if dirname == "ruoyi" and os.path.basename(parent_dir) == "com":
            # Found com/ruoyi
            # Construct new specific path
            grandparent = os.path.dirname(parent_dir) # src/main/java
             # Check if we are effectively in a source root (structure usually ends with com/ruoyi)
             # strict check: join(grandparent, "com", "ruoyi") == dirpath
            
            new_path_structure = os.path.join(parent_dir, "kenzhao", "smallsteps")
            
            print(f"Moving package: {dirpath} -> {new_path_structure}")
            if not os.path.exists(new_path_structure):
                os.makedirs(new_path_structure)
            
            # Move contents
            for item in os.listdir(dirpath):
                src = os.path.join(dirpath, item)
                dst = os.path.join(new_path_structure, item)
                if os.path.exists(dst): 
                     # Merge if exists (shouldn't happen in clean refactor but safety first)
                     if os.path.isdir(src):
                         shutil.copytree(src, dst, dirs_exist_ok=True)
                         shutil.rmtree(src)
                     else:
                         shutil.move(src, dst)
                else:
                    shutil.move(src, dst)
            
            # Remove old empty dir
            try:
                os.rmdir(dirpath)
            except OSError:
                pass # Not empty?
            
            continue

        # 2. Handle Module Names: ruoyi-xxx -> smallsteps-xxx
        if dirname.startswith("ruoyi-"):
            new_dirname = dirname.replace("ruoyi-", "smallsteps-")
            new_path = os.path.join(parent_dir, new_dirname)
            print(f"Renaming directory: {dirpath} -> {new_path}")
            os.rename(dirpath, new_path)

def process_file_content(root_dir):
    for dirpath, dirnames, filenames in os.walk(root_dir):
        if any(ignored in dirpath.split(os.sep) for ignored in IGNORE_DIRS):
            continue
            
        for filename in filenames:
            ext = os.path.splitext(filename)[1]
            if ext in EXTENSIONS_TO_PROCESS or filename == 'Dockerfile':
                file_path = os.path.join(dirpath, filename)
                replace_content(file_path)
            
            # Helper to rename files like "RuoYiConfig.java" -> "SmallStepsConfig.java"
            if "RuoYi" in filename:
                new_filename = filename.replace("RuoYi", "SmallSteps")
                new_path = os.path.join(dirpath, new_filename)
                print(f"Renaming file: {filename} -> {new_filename}")
                os.rename(os.path.join(dirpath, filename), new_path)
                # If we renamed the file, we need to process the NEW file content
                if ext in EXTENSIONS_TO_PROCESS:
                     replace_content(new_path)

def main():
    print(f"Starting refactor on {PROJECT_ROOT}...")
    
    # 1. Rename directories (and packages)
    print("--- Phase 1: Renaming Directories & Packages ---")
    rename_directories(PROJECT_ROOT)
    
    # 2. Replace content
    print("--- Phase 2: Updating File Content ---")
    process_file_content(PROJECT_ROOT)
    
    print("Refactor complete.")

if __name__ == "__main__":
    main()
