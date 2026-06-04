import os
import shutil
import re
import sys

# Ensure stdout uses UTF-8 to prevent encoding issues with Chinese paths
sys.stdout.reconfigure(encoding='utf-8')

# Source directory containing all v1, v2, v3, etc. directories
base_dir = r"d:\office\jushuang1\github\ss\答辩\检测"
word_dir = os.path.join(base_dir, "word")

# Output merged document filename
output_filename = "ADHD中小学生儿童行为习惯辅助系统设计与实现241042025赵轩_v31.docx"
output_filepath = os.path.join(word_dir, output_filename)

# Make sure the target word directory exists
os.makedirs(word_dir, exist_ok=True)

# Helper function to extract version number from path/filename for correct sorting sequence
def get_version_key(file_path):
    # Match patterns like v1, v2, v10, v20p in folder names or file names
    # e.g., 'v20p' -> 20.5 (so it sorts after v20), 'v10' -> 10.0, 'v1' -> 1.0
    match = re.search(r'v(\d+)(p)?', file_path, re.IGNORECASE)
    if match:
        num = int(match.group(1))
        is_p = 0.5 if match.group(2) else 0.0
        return num + is_p
    return 999.0  # Fallback for files with no version indicator

def copy_and_merge():
    # 1. Discover all .docx files in subdirectories of base_dir, excluding the 'word' directory itself
    docx_files = []
    for root, dirs, files in os.walk(base_dir):
        # Skip the word directory itself to avoid recursive copying or merging own result
        if os.path.abspath(root).startswith(os.path.abspath(word_dir)):
            continue
            
        for file in files:
            # Only search for valid docx files, skip temp files starting with ~$
            if file.endswith('.docx') and not file.startswith('~$'):
                src_path = os.path.join(root, file)
                docx_files.append(src_path)

    print(f"找到以下待复制的 Word 文档：")
    for f in docx_files:
        print(f" - {f}")

    # 2. Copy files to the word_dir directory
    copied_files = []
    print("\n开始复制文件到 Word 目录...")
    for src in docx_files:
        filename = os.path.basename(src)
        
        # In case different folders have the same filename, prepend folder name to make it unique
        parent_dir = os.path.basename(os.path.dirname(src))
        unique_name = f"{parent_dir}_{filename}"
        dest_path = os.path.join(word_dir, unique_name)
        
        shutil.copy2(src, dest_path)
        copied_files.append(dest_path)
        print(f" 复制: {src} -> {dest_path}")

    # 3. Sort the copied files by version number (v1, v2, v3, v4, v5, v6, v7, v10, v20p)
    copied_files.sort(key=get_version_key)
    print("\n合并文件顺序排序结果：")
    for idx, f in enumerate(copied_files):
        print(f" {idx+1}. {os.path.basename(f)} (解析版本: {get_version_key(f)})")

    if not copied_files:
        print("未找到任何待合并的 Word 文档！")
        return

    # 4. Perform the merging of docx files
    print("\n开始合并 Word 文档...")
    
    # Try merging using MS Word COM first (best formatting preservation on Windows)
    try:
        import win32com.client
        print("尝试使用 MS Word COM 接口进行完美格式合并...")
        
        word = win32com.client.Dispatch("Word.Application")
        word.Visible = False
        
        # Open the first document as base
        doc = word.Documents.Open(os.path.abspath(copied_files[0]))
        
        for file_to_merge in copied_files[1:]:
            # Move cursor to end of document
            word.Selection.EndKey(Unit=6) # wdStory = 6
            # Insert a page break
            word.Selection.InsertBreak(Type=7) # wdPageBreak = 7
            # Insert the file content
            word.Selection.InsertFile(os.path.abspath(file_to_merge))
            
        doc.SaveAs(os.path.abspath(output_filepath))
        doc.Close()
        word.Quit()
        print(f"\n[成功] 已使用 MS Word COM 完成完美合并！新文件已保存至：\n{output_filepath}")
        return
    except Exception as e:
        print(f"[提示] Word COM 合并失败或未安装 MS Word ({e})，将自动启用 python-docx 备用方案...")

    # Fallback method: python-docx body XML merging
    try:
        from docx import Document
        print("启用 python-docx 模块进行元素级合并...")
        
        merged_doc = Document(copied_files[0])
        
        for file_to_merge in copied_files[1:]:
            sub_doc = Document(file_to_merge)
            # Add page break
            merged_doc.add_page_break()
            
            # Copy all body elements
            for element in sub_doc.element.body:
                if element.tag.endswith('sectPr'):
                    continue
                merged_doc.element.body.append(element)
                
        merged_doc.save(output_filepath)
        print(f"\n[成功] 已使用 python-docx 备用方案完成合并！新文件已保存至：\n{output_filepath}")
    except Exception as e_fallback:
        print(f"[严重错误] 所有合并策略均已失败：{e_fallback}")

if __name__ == '__main__':
    copy_and_merge()
