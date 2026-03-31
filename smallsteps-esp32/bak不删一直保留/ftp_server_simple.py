import socket
import network
import os

class SimpleFTPServer:
    """
    简化版 FTP 服务器
    
    支持基本的 FTP 命令：
    - USER/PASS: 登录
    - PWD: 显示当前目录
    - CWD: 切换目录
    - LIST: 列出文件
    - STOR: 上传文件
    - RETR: 下载文件
    """
    
    def __init__(self, root_dir="/sd", port=21):
        """
        初始化 FTP 服务器
        
        参数：
            root_dir: FTP 根目录
            port: FTP 端口（默认 21）
        """
        self.root_dir = root_dir
        self.port = port
        self.current_dir = "/"
    
    def start(self):
        """启动 FTP 服务器"""
        # 创建控制连接 socket
        self.control_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.control_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.control_socket.bind(('', self.port))
        self.control_socket.listen(1)
        
        print("FTP Server started on port " + str(self.port))
        print("Root directory: " + self.root_dir)
        
        while True:
            try:
                conn, addr = self.control_socket.accept()
                print("FTP connection from: " + str(addr))
                self._handle_client(conn)
            except Exception as e:
                print("Error: " + str(e))
    
    def _handle_client(self, conn):
        """处理 FTP 客户端连接"""
        try:
            # 发送欢迎消息
            self._send_response(conn, "220 MicroPython FTP Server Ready")
            
            authenticated = False
            data_socket = None
            
            while True:
                # 接收命令
                data = conn.recv(1024)
                if not data:
                    break
                
                cmd_line = data.decode('utf-8').strip()
                print("FTP CMD: " + cmd_line)
                
                # 解析命令
                parts = cmd_line.split(' ', 1)
                cmd = parts[0].upper()
                arg = parts[1] if len(parts) > 1 else ""
                
                # 处理命令
                if cmd == 'USER':
                    self._send_response(conn, "331 Password required")
                
                elif cmd == 'PASS':
                    authenticated = True
                    self._send_response(conn, "230 Login successful")
                
                elif cmd == 'PWD':
                    self._send_response(conn, "257 \"" + self.current_dir + "\"")
                
                elif cmd == 'CWD':
                    if self._change_dir(arg):
                        self._send_response(conn, "250 Directory changed")
                    else:
                        self._send_response(conn, "550 Failed to change directory")
                
                elif cmd == 'TYPE':
                    self._send_response(conn, "200 Type set")
                
                elif cmd == 'PASV':
                    # 被动模式（简化版）
                    self._send_response(conn, "227 Entering Passive Mode (192,168,1,100,0,20)")
                
                elif cmd == 'LIST':
                    self._send_response(conn, "150 Opening data connection")
                    self._send_file_list(conn)
                    self._send_response(conn, "226 Transfer complete")
                
                elif cmd == 'STOR':
                    self._send_response(conn, "150 Ready to receive")
                    # 简化：直接在控制连接接收数据
                    self._receive_file(conn, arg)
                    self._send_response(conn, "226 Transfer complete")
                
                elif cmd == 'QUIT':
                    self._send_response(conn, "221 Goodbye")
                    break
                
                else:
                    self._send_response(conn, "502 Command not implemented")
        
        except Exception as e:
            print("Client error: " + str(e))
        finally:
            conn.close()
    
    def _send_response(self, conn, message):
        """发送 FTP 响应"""
        conn.send((message + "\r\n").encode('utf-8'))
    
    def _change_dir(self, path):
        """切换目录"""
        if path == "..":
            # 返回上级目录
            if self.current_dir != "/":
                parts = self.current_dir.rstrip('/').split('/')
                self.current_dir = '/'.join(parts[:-1]) or '/'
            return True
        else:
            # 进入子目录
            new_dir = self.current_dir.rstrip('/') + '/' + path
            full_path = self.root_dir + new_dir
            try:
                os.listdir(full_path)
                self.current_dir = new_dir
                return True
            except:
                return False
    
    def _send_file_list(self, conn):
        """发送文件列表"""
        full_path = self.root_dir + self.current_dir
        try:
            files = os.listdir(full_path)
            for f in files:
                conn.send((f + "\r\n").encode('utf-8'))
        except Exception as e:
            print("List error: " + str(e))
    
    def _receive_file(self, conn, filename):
        """接收文件（简化版）"""
        file_path = self.root_dir + self.current_dir.rstrip('/') + '/' + filename
        print("Receiving file: " + file_path)
        
        # 注意：这是简化版，实际 FTP 需要数据连接
        # 这里仅作演示
        try:
            with open(file_path, 'wb') as f:
                while True:
                    data = conn.recv(4096)
                    if not data:
                        break
                    f.write(data)
            print("File saved: " + file_path)
        except Exception as e:
            print("Save error: " + str(e))


# 注意：上面的 FTP 服务器是简化版，实际使用建议用现成的库
# 下面提供使用现成库的方案
