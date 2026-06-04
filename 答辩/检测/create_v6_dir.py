import os
import shutil

# Create v6 directory
v6_dir = r'd:\office\jushuang1\github\ss\答辩\检测\v6'
os.makedirs(v6_dir, exist_ok=True)

# Copy original 73论文.md to v6 as 73论文_v6.md
src_md = r'd:\office\jushuang1\github\ss\答辩\检测\原文\73论文.md'
dst_md = os.path.join(v6_dir, '73论文_v6.md')
shutil.copyfile(src_md, dst_md)
print(f'Copied {src_md} to {dst_md}')
