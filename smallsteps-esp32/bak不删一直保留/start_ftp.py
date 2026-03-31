from sd_manager import SDManager
import config
import network
import time

# ========================================
# FTP 服务器启动脚本
# ========================================
# 使用 uftpd 库提供完整的 FTP 服务
# ========================================

def start_ftp_server():
    print("=== Starting FTP Server ===\n")
    
    # 1. 连接 WiFi
    print("[1] Connecting to WiFi...")
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    
    if not wlan.isconnected():
        print("Connecting to: " + config.WIFI_SSID)
        wlan.connect(config.WIFI_SSID, config.WIFI_PASS)
        
        timeout = 10
        while not wlan.isconnected() and timeout > 0:
            time.sleep(1)
            timeout -= 1
        
        if not wlan.isconnected():
            print("Failed to connect to WiFi!")
            return
    
    ip = wlan.ifconfig()[0]
    print("WiFi connected!")
    print("IP Address: " + ip)
    print("")
    
    # 2. 挂载 SD 卡
    print("[2] Mounting SD card...")
    sd = SDManager(
        sck_pin=config.SD_SCK_PIN,
        mosi_pin=config.SD_MOSI_PIN,
        miso_pin=config.SD_MISO_PIN,
        cs_pin=config.SD_CS_PIN
    )
    
    if not sd.mount():
        print("Failed to mount SD card!")
        print("Please check:")
        print("- SD card is inserted")
        print("- SD card is FAT32 formatted")
        print("- Wiring is correct")
        return
    
    print("SD card mounted at /sd")
    print("")
    
    # 3. 创建 DFPlayer 文件夹
    print("[3] Creating DFPlayer folders...")
    sd.ensure_dfplayer_folders()
    print("")
    
    # 4. 启动 FTP 服务器
    print("[4] Starting FTP server...")
    print("")
    print("=" * 50)
    print("FTP Server Ready!")
    print("=" * 50)
    print("Host: " + ip)
    print("Port: 21")
    print("User: micro")
    print("Pass: python")
    print("Root: /sd")
    print("=" * 50)
    print("")
    print("Connect using FTP client:")
    print("  FileZilla: ftp://" + ip)
    print("  WinSCP: ftp://" + ip)
    print("  Command: ftp " + ip)
    print("")
    print("Upload MP3 files to:")
    print("  /01/001.mp3")
    print("  /01/002.mp3")
    print("  /02/001.mp3")
    print("  etc.")
    print("")
    
    try:
        # 尝试使用 uftpd 库
        from uftpd import FTPServer
        ftp = FTPServer(root="/sd")
        ftp.start()
    except ImportError:
        print("ERROR: uftpd library not found!")
        print("")
        print("Please install it first:")
        print("1. In REPL, run:")
        print("   import mip")
        print("   mip.install('github:cpopp/MicroFTPServer')")
        print("")
        print("2. Or manually download uftpd.py and upload to /lib/")
        print("")
        print("Alternative: Use the simple FTP server:")
        print("   from ftp_server_simple import SimpleFTPServer")
        print("   server = SimpleFTPServer('/sd')")
        print("   server.start()")

if __name__ == "__main__":
    start_ftp_server()
