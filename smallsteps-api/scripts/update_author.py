
import os
import re

TARGET_DIR = r"d:\office\jushuang1\gitee\smallsteps\参考项目\RuoYi"
TARGET_AUTHOR = "赵轩"

def update_author_in_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        modified = False
        new_lines = []
        for line in lines:
            # Match strict Javadoc pattern: " * @author <any>"
            # Also handle potential variations like tabs or extra spaces
            # Use regex to find line starting with optional whitespace, specific "* @author", followed by anything
            new_line = re.sub(r'(^\s*\*\s*@author\s+).*', f'\\1{TARGET_AUTHOR}', line)

            if new_line != line:
                modified = True
                new_lines.append(new_line)
            else:
                new_lines.append(line)

        if modified:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.writelines(new_lines)
            print(f"Updated: {file_path}")
            return True
        return False

    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return False

def main():
    total_updated = 0
    print(f"Starting scan in: {TARGET_DIR}")
    for root, dirs, files in os.walk(TARGET_DIR):
        for file in files:
            if file.endswith(".java"):
                full_path = os.path.join(root, file)
                if update_author_in_file(full_path):
                    total_updated += 1

    print(f"\nCompleted. Total files updated: {total_updated}")

if __name__ == "__main__":
    main()
