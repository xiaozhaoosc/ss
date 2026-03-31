from sd_manager import SDManager
import config

# ========================================
# SD 卡测试脚本
# ========================================
# 硬件接线：
#   SD 卡 VCC  → ESP32 3.3V
#   SD 卡 GND  → GND
#   SD 卡 MISO → GPIO 13
#   SD 卡 MOSI → GPIO 11 (共用屏幕)
#   SD 卡 SCK  → GPIO 12 (共用屏幕)
#   SD 卡 CS   → GPIO 14
# ========================================

def test_sd_card():
    print("=== SD Card Test ===\n")
    
    # 初始化 SD 卡管理器
    print("[1] Initializing SD card...")
    sd = SDManager(
        sck_pin=config.SD_SCK_PIN,
        mosi_pin=config.SD_MOSI_PIN,
        miso_pin=config.SD_MISO_PIN,
        cs_pin=config.SD_CS_PIN
    )
    
    # 挂载 SD 卡
    if not sd.mount():
        print("Failed to mount SD card!")
        print("\nTroubleshooting:")
        print("- Check SD card is inserted")
        print("- Check SD card is FAT32 formatted")
        print("- Check wiring connections")
        print("- Try a different SD card")
        return
    
    print("\n[2] SD card mounted successfully!\n")
    
    # 创建 DFPlayer 文件夹
    print("[3] Creating DFPlayer folders...")
    sd.ensure_dfplayer_folders()
    print("")
    
    # 列出根目录文件
    print("[4] Listing root directory:")
    files = sd.list_files("/")
    for f in files:
        print("  - " + f)
    print("")
    
    # 测试写入文件
    print("[5] Testing file write...")
    test_data = b"Hello, DFPlayer!"
    if sd.write_file("/01/test.txt", test_data):
        print("Test file written successfully")
    else:
        print("Failed to write test file")
    print("")
    
    # 列出 01 文件夹内容
    print("[6] Listing /01/ folder:")
    files = sd.list_files("/01")
    for f in files:
        size = sd.get_file_size("/01/" + f)
        print("  - " + f + " (" + str(size) + " bytes)")
    print("")
    
    # 删除测试文件
    print("[7] Deleting test file...")
    if sd.delete_file("/01/test.txt"):
        print("Test file deleted")
    print("")
    
    print("=== SD Card Test Complete ===")
    print("\nNext steps:")
    print("1. Use FTP or other tools to upload MP3 files to SD card")
    print("2. Place files in /01/, /02/, etc. folders")
    print("3. Name files as 001.mp3, 002.mp3, etc.")
    print("4. Run test_dfplayer.py to test audio playback")

if __name__ == "__main__":
    test_sd_card()
