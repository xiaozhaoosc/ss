import psycopg2
import sys

def run_sql(file_path):
    conn = None
    try:
        # 数据库连接信息 (基于用户提供的运行参数)
        conn = psycopg2.connect(
            database="smallsteps_db",
            user="smallsteps",
            password="abdSSsaf#1236548^",
            host="10.8.0.1",
            port="15432"
        )
        conn.autocommit = True
        cur = conn.cursor()
        
        with open(file_path, 'r', encoding='utf-8') as f:
            sql = f.read()
            
        cur.execute(sql)
        print("SQL executed successfully!")
        
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)
    finally:
        if conn:
            conn.close()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python run_sql.py <sql_file_path>")
        sys.exit(1)
    run_sql(sys.argv[1])
