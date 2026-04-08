import os

old_s = 'com.kenzhao.smallsteps.common.core.domain.BaseEntity'
new_s = 'com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity'

def fix_file(path):
    content = None
    # 尝试多种可能的编码读取，特别是 GBK（PowerShell 默认）和 UTF-8
    for enc in ['gbk', 'utf-8-sig', 'utf-8', 'latin-1']:
        try:
            with open(path, 'r', encoding=enc) as f:
                content = f.read()
            break
        except:
            continue
    
    if content is not None:
        # 修正引用
        new_content = content.replace(old_s, new_s)
        # 统一写入为无 BOM 的 UTF-8
        with open(path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return True
    return False

dirs_to_fix = [
    r'smallsteps-api/smallsteps-modules/smallsteps-parent',
    r'smallsteps-api/smallsteps-modules/smallsteps-child',
    r'smallsteps-api/smallsteps-admin'
]

for d in dirs_to_fix:
    if not os.path.exists(d): continue
    for root, dirs, files in os.walk(d):
        for file in files:
            if file.endswith('.java'):
                fix_file(os.path.join(root, file))

print('Encoding normalization and import fix completed.')
