import re

with open('docs/todo/word/20260420.sql', 'r', encoding='utf-8') as f:
    sql_content = f.read()

tables = [
    'sys_user', 'ss_child', 'ss_parent_task', 'ss_task_log',
    'ss_child_score', 'ss_score_history', 'ss_parent_reward',
    'ss_parent_reward_redemption', 'ss_emotion_record'
]

for table in tables:
    print(f'\n=== Table: {table} ===')
    create_pattern = r'CREATE TABLE "public"\."' + table + r'" \((.*?)\)\s*;'
    create_match = re.search(create_pattern, sql_content, re.DOTALL)
    
    comments = {}
    comment_pattern = r'COMMENT ON COLUMN "public"\."' + table + r'"\."([^"]+)" IS \'([^\']+)\';'
    for col, comment in re.findall(comment_pattern, sql_content):
        comments[col] = comment
        
    if create_match:
        lines = create_match.group(1).split('\n')
        for line in lines:
            line = line.strip().strip(',')
            if line.startswith('"'):
                parts = line.split(' ')
                col_name = parts[0].strip('"')
                col_type = parts[1]
                is_null = '否' if 'NOT NULL' in line else '是'
                comment = comments.get(col_name, '')
                
                # Format: 字段名称 | 类型 | 长度 | 必填 | 说明
                length = '-'
                if '(' in col_type:
                    col_type, length = col_type.split('(')
                    length = length.replace(')', '')
                
                if 'int' in col_type or 'serial' in col_type:
                    if col_type == 'int8': length = '20'
                    elif col_type == 'int4': length = '11'
                
                required = '是' if is_null == '否' else '否'
                print(f"| {col_name} | {col_type} | {length} | {required} | {comment} |")
