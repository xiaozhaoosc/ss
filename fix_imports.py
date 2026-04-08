import os

def fix_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        new_content = content.replace('com.kenzhao.smallsteps.common.core.domain.BaseEntity', 'com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity')
        
        if new_content != content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f'Fixed: {file_path}')
    except Exception as e:
        print(f'Error processing {file_path}: {e}')

base_dir = r'smallsteps-api/smallsteps-modules/smallsteps-parent'
for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith('.java'):
            fix_file(os.path.join(root, file))
