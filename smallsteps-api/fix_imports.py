import os
import glob

# 查找所有 AutoConfiguration.imports 文件
base_path = r"d:\kenzhao\cust_projects\smallsteps\projects\smallsteps-api\smallsteps-common"
pattern = "**/src/main/resources/META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports"

files = glob.glob(os.path.join(base_path, pattern), recursive=True)

for file_path in files:
    print(f"Processing: {file_path}")
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 替换包名
    new_content = content.replace('org.dromara.common', 'com.kenzhao.smallsteps.common')
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"Fixed: {file_path}")

print(f"\nTotal files processed: {len(files)}")
