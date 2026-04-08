import os
import win32com.client as win32
import traceback

def format_paper_with_template(source_path, template_path, output_path):
    """
    通过挂载Word模板解决样式覆盖问题。
    """
    src_abs = os.path.abspath(source_path)
    tpl_abs = os.path.abspath(template_path)
    out_abs = os.path.abspath(output_path)

    print("=" * 60)
    print("🚀 开始执行：核心样式映射任务")
    print("=" * 60)

    # 1. 检查文件有效性
    for path, desc in [(src_abs, "⭕ 源论文"), (tpl_abs, "⭕ 模板源")]:
        if not os.path.exists(path):
            print(f"❌ 致命错误：找不到{desc} - {path}\n（请检查路径或文件名是否正确拼写）")
            return
        else:
            print(f"{desc} 验证通过")

    print("\n⏳ 正在启动本地 Microsoft Word 进程... (过程视电脑性能可能需要几秒)")
    # 使用 DispatchEx 强制启动一个独立的 Word 实例，防止与当前正在编辑的冲突
    word = win32.DispatchEx('Word.Application')
    
    # 【调试开关】True 表示你能亲眼看到 Word 弹出弹框在全自动排版， False 为后台静默执行
    word.Visible = True 
    # 强制关闭任何提示(如页边距警告)，防止脚本卡住等待人工点击
    word.DisplayAlerts = 0  

    doc = None
    try:
        print(f"📖 正在解析旧版文档格式: {os.path.basename(src_abs)}")
        # 打开文档
        doc = word.Documents.Open(src_abs)

        print(f"🛡️ 正在注入并强制更新模板: {os.path.basename(tpl_abs)}")
        # 核心逻辑：强制将官方模板附加到当前文档
        doc.AttachedTemplate = tpl_abs
        # 激活自动更新文档样式
        doc.UpdateStylesOnOpen = True
        doc.UpdateStyles()
        
        # 智能附加：更新文档中所有的目录域 (如果有)
        print("📑 扫描文档域并更新目录映射...")
        if doc.TablesOfContents.Count > 0:
            for toc in doc.TablesOfContents:
                toc.Update()

        print(f"💾 正在编译输出格式为标准 docx: {os.path.basename(out_abs)}")
        # FileFormat=16 即 wdFormatXMLDocument (标准的 .docx 后缀)
        doc.SaveAs(out_abs, FileFormat=16)
        
        print("\n✅ 【任务完成】排版挂载成功！")
        print(f"📁 最终排版文件路径: {out_abs}")

    except Exception as e:
        print("\n❌ 糟糕，排版过程中发生异常断点:")
        traceback.print_exc()
        print("\n[排错提示] 请确保您已关闭该 Word 文档，不要占用文件读写。")
    finally:
        # 安全退出（极为关键，否则会在后台残留死进程）
        if doc is not None:
            # 不保存对旧文件所做的修改
            doc.Close(SaveChanges=False) 
        word.Quit()
        print("-" * 60)

if __name__ == "__main__":
    # 你的工作区实际绝对路径映射
    SOURCE_FILE = r"d:\kenzhao\cust_projects\ss\论文\v7\v7_上海应用技术大学高等学历继续教育本科计算机专业毕业论文.doc"
    TEMPLATE_FILE = r"d:\kenzhao\cust_projects\ss\论文\3计算机专业-毕业论文格式模板.doc"
    OUTPUT_FILE = r"d:\kenzhao\cust_projects\ss\论文\v7\v7_最终格式合成版.docx"
    
    format_paper_with_template(SOURCE_FILE, TEMPLATE_FILE, OUTPUT_FILE)
