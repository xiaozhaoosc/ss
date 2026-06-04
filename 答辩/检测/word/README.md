# Word文档合并工具

## 功能说明

本工具用于将`检测`目录下各个版本（v1, v2, v3, v4, v7, v10, v20p等）的Word文档合并为一个完整的文档。

## 文件说明

- `merge_word_docs.py` - Python合并脚本
- `run_merge.bat` - Windows批处理文件（一键运行）
- `合并文档.docx` - 合并后的输出文件

## 使用方法

### 方法一：使用批处理文件（推荐）

1. 双击运行 `run_merge.bat`
2. 等待脚本执行完成
3. 合并后的文档将生成在当前目录

### 方法二：使用Python脚本

1. 打开命令行终端
2. 切换到当前目录：
   ```bash
   cd "D:\office\jushuang1\github\ss\答辩\检测\word"
   ```
3. 运行脚本：
   ```bash
   python merge_word_docs.py
   ```

## 依赖要求

- Python 3.x
- python-docx库

如果未安装python-docx，可以通过以下命令安装：
```bash
pip install python-docx
```

## 合并的文档列表

脚本会自动扫描以下目录中的.docx文件：
- v1/论文_v1.docx
- v2/v2.docx
- v3/v3.docx
- v4/v4.docx
- v7/论文_v7.docx
- v10/论文_v10.docx
- v20p/73论文_v20p.docx
- 以及其他子目录中的.docx文件

## 注意事项

1. 合并后的文档会按文件名排序
2. 每个原始文档之间会添加分页符
3. 格式可能需要手动调整
4. 如果文档中有复杂格式（如图片、表格），可能无法完美复制
5. 临时文件（以~$开头）会被自动排除

## 输出文件

合并后的文件将保存为：`合并文档.docx`
