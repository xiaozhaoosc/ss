import socket
import network
import config
from sd_manager import SDManager

class WebServer:
    """
    简单的 HTTP Web 服务器
    
    功能：
    - 提供文件上传页面
    - 处理文件上传请求
    - 显示 SD 卡文件列表
    """
    
    def __init__(self, sd_manager, port=80):
        """
        初始化 Web 服务器
        
        参数：
            sd_manager: SDManager 实例
            port: 服务器端口（默认 80）
        """
        self.sd = sd_manager
        self.port = port
        self.socket = None
    
    def start(self):
        """启动 Web 服务器"""
        # 连接 WiFi
        if not self._connect_wifi():
            return False
        
        # 创建 socket
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.socket.bind(('', self.port))
        self.socket.listen(1)
        
        print("Web server started")
        print("Access at: http://" + self._get_ip() + ":" + str(self.port))
        
        # 主循环
        while True:
            try:
                conn, addr = self.socket.accept()
                print("Connection from: " + str(addr))
                self._handle_request(conn)
            except Exception as e:
                print("Error handling request: " + str(e))
    
    def _connect_wifi(self):
        """连接 WiFi"""
        wlan = network.WLAN(network.STA_IF)
        wlan.active(True)
        
        if not wlan.isconnected():
            print("Connecting to WiFi...")
            wlan.connect(config.WIFI_SSID, config.WIFI_PASS)
            
            # 等待连接
            timeout = 10
            while not wlan.isconnected() and timeout > 0:
                import time
                time.sleep(1)
                timeout -= 1
            
            if not wlan.isconnected():
                print("Failed to connect to WiFi")
                return False
        
        print("WiFi connected")
        print("IP: " + wlan.ifconfig()[0])
        return True
    
    def _get_ip(self):
        """获取 IP 地址"""
        wlan = network.WLAN(network.STA_IF)
        return wlan.ifconfig()[0]
    
    def _handle_request(self, conn):
        """处理 HTTP 请求"""
        try:
            # 读取请求头
            request = conn.recv(1024).decode('utf-8')
            
            # 解析请求
            lines = request.split('\r\n')
            if len(lines) == 0:
                conn.close()
                return
            
            # 获取请求行
            request_line = lines[0]
            parts = request_line.split(' ')
            if len(parts) < 2:
                conn.close()
                return
            
            method = parts[0]
            path = parts[1]
            
            print("Request: " + method + " " + path)
            
            # 路由处理
            if method == 'GET' and path == '/':
                self._serve_upload_page(conn)
            elif method == 'GET' and path == '/list':
                self._serve_file_list(conn)
            elif method == 'POST' and path == '/upload':
                self._handle_upload(conn, request)
            else:
                self._serve_404(conn)
            
        except Exception as e:
            print("Error in _handle_request: " + str(e))
        finally:
            conn.close()
    
    def _serve_upload_page(self, conn):
        """提供上传页面"""
        html = """<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DFPlayer File Upload</title>
    <style>
        body { font-family: Arial; max-width: 600px; margin: 50px auto; padding: 20px; }
        h1 { color: #333; }
        .form-group { margin: 20px 0; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, select { width: 100%; padding: 8px; box-sizing: border-box; }
        button { background: #4CAF50; color: white; padding: 10px 20px; border: none; cursor: pointer; font-size: 16px; }
        button:hover { background: #45a049; }
        .file-list { margin-top: 30px; border-top: 2px solid #ddd; padding-top: 20px; }
        .file-item { padding: 5px; border-bottom: 1px solid #eee; }
    </style>
</head>
<body>
    <h1>🎵 DFPlayer File Upload</h1>
    
    <form action="/upload" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Folder (01-99):</label>
            <select name="folder" required>
                <option value="01">01</option>
                <option value="02">02</option>
                <option value="03">03</option>
                <option value="04">04</option>
                <option value="05">05</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>File Number (001-255):</label>
            <input type="text" name="filenum" pattern="[0-9]{3}" placeholder="001" required>
        </div>
        
        <div class="form-group">
            <label>Audio File (.mp3):</label>
            <input type="file" name="file" accept=".mp3,.wav" required>
        </div>
        
        <button type="submit">Upload</button>
    </form>
    
    <div class="file-list">
        <h2>Files on SD Card</h2>
        <div id="files">Loading...</div>
    </div>
    
    <script>
        fetch('/list')
            .then(r => r.text())
            .then(data => {
                document.getElementById('files').innerHTML = data || 'No files';
            });
    </script>
</body>
</html>"""
        
        response = "HTTP/1.1 200 OK\r\n"
        response += "Content-Type: text/html; charset=utf-8\r\n"
        response += "Content-Length: " + str(len(html)) + "\r\n"
        response += "\r\n"
        response += html
        
        conn.send(response.encode('utf-8'))
    
    def _serve_file_list(self, conn):
        """提供文件列表"""
        html = ""
        
        # 列出所有文件夹
        folders = self.sd.list_files("/")
        for folder in sorted(folders):
            if folder.startswith('.'):
                continue
            
            html += "<div class='file-item'><strong>/" + folder + "/</strong></div>"
            
            # 列出文件夹中的文件
            files = self.sd.list_files("/" + folder)
            for file in sorted(files):
                size = self.sd.get_file_size("/" + folder + "/" + file)
                html += "<div class='file-item'>  " + file + " (" + str(size) + " bytes)</div>"
        
        response = "HTTP/1.1 200 OK\r\n"
        response += "Content-Type: text/html; charset=utf-8\r\n"
        response += "Content-Length: " + str(len(html)) + "\r\n"
        response += "\r\n"
        response += html
        
        conn.send(response.encode('utf-8'))
    
    def _handle_upload(self, conn, request):
        """处理文件上传"""
        # 简化版：这里需要解析 multipart/form-data
        # 由于 MicroPython 内存限制，这里只提供基本框架
        
        response = "HTTP/1.1 200 OK\r\n"
        response += "Content-Type: text/html\r\n"
        response += "\r\n"
        response += "<html><body><h1>Upload feature coming soon!</h1>"
        response += "<p>Due to MicroPython memory limitations, please use FTP or other methods to upload files.</p>"
        response += "<a href='/'>Back</a></body></html>"
        
        conn.send(response.encode('utf-8'))
    
    def _serve_404(self, conn):
        """404 页面"""
        response = "HTTP/1.1 404 Not Found\r\n"
        response += "Content-Type: text/html\r\n"
        response += "\r\n"
        response += "<html><body><h1>404 Not Found</h1></body></html>"
        
        conn.send(response.encode('utf-8'))


def start_server():
    """启动 Web 服务器的便捷函数"""
    import config
    
    # 初始化 SD 卡
    sd = SDManager(
        sck_pin=config.SD_SCK_PIN,
        mosi_pin=config.SD_MOSI_PIN,
        miso_pin=config.SD_MISO_PIN,
        cs_pin=config.SD_CS_PIN
    )
    
    if not sd.mount():
        print("Failed to mount SD card. Please check connections.")
        return
    
    # 确保文件夹存在
    sd.ensure_dfplayer_folders()
    
    # 启动服务器
    server = WebServer(sd)
    server.start()
