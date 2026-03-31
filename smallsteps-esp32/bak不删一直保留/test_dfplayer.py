from lib.dfplayermini import DFPlayerMini
import config
import time

# ========================================
# DFPlayer Mini 测试脚本
# ========================================
# 硬件接线：
#   DFPlayer VCC → 5V 电源板
#   DFPlayer GND → GND (共地)
#   DFPlayer TX  → ESP32 GPIO 18 (RX)
#   DFPlayer RX  → ESP32 GPIO 17 (TX)
#   DFPlayer SPK_1/SPK_2 → 扬声器
# ========================================
# SD 卡准备：
#   - 格式：FAT32
#   - 容量：≤32GB
#   - 文件夹结构：
#     /01/001.mp3
#     /01/002.mp3
#     /01/003.mp3
# ========================================

def test_dfplayer():
    print("=== DFPlayer Mini Test ===\n")
    
    # 初始化 DFPlayer
    print("[1] Initializing DFPlayer...")
    print("UART ID: " + str(config.DFPLAYER_UART_ID))
    print("TX Pin: " + str(config.DFPLAYER_TX_PIN))
    print("RX Pin: " + str(config.DFPLAYER_RX_PIN))
    
    try:
        player = DFPlayerMini(
            uart_id=config.DFPLAYER_UART_ID,
            tx_pin=config.DFPLAYER_TX_PIN,
            rx_pin=config.DFPLAYER_RX_PIN
        )
        print("DFPlayer initialized successfully!\n")
    except Exception as e:
        print("Failed to initialize DFPlayer: " + str(e))
        return
    
    # 重置模块
    print("[2] Resetting DFPlayer...")
    player.reset()
    print("Reset complete. Waiting for module to stabilize...\n")
    time.sleep(2)
    
    # 设置音量（0-30）
    print("[3] Setting volume to 20...")
    player.volume(20)
    time.sleep(0.5)
    print("Volume set.\n")
    
    # 测试 1: 播放文件夹 1 的第 1 首歌
    print("[Test 1] Playing folder 01, file 001...")
    player.play(folder=1, file=1)
    print("Playing... (5 seconds)")
    time.sleep(5)
    player.stop()
    print("Stopped.\n")
    time.sleep(1)
    
    # 测试 2: 播放文件夹 1 的第 2 首歌
    print("[Test 2] Playing folder 01, file 002...")
    player.play(folder=1, file=2)
    print("Playing... (5 seconds)")
    time.sleep(5)
    player.stop()
    print("Stopped.\n")
    time.sleep(1)
    
    # 测试 3: 音量调节
    print("[Test 3] Volume Test")
    player.play(folder=1, file=1)
    
    print("Volume 10...")
    player.volume(10)
    time.sleep(3)
    
    print("Volume 25...")
    player.volume(25)
    time.sleep(3)
    
    player.stop()
    print("Volume test complete.\n")
    time.sleep(1)
    
    # 测试 4: EQ 音效测试
    print("[Test 4] EQ Test (Normal -> Pop -> Rock)")
    player.play(folder=1, file=1)
    
    print("EQ: Normal")
    player.eq(0)
    time.sleep(3)
    
    print("EQ: Pop")
    player.eq(1)
    time.sleep(3)
    
    print("EQ: Rock")
    player.eq(2)
    time.sleep(3)
    
    player.stop()
    print("EQ test complete.\n")
    time.sleep(1)
    
    # 测试 5: 播放控制（下一曲/上一曲）
    print("[Test 5] Playback Control Test")
    print("Playing folder 01, file 001...")
    player.play(folder=1, file=1)
    time.sleep(3)
    
    print("Next track...")
    player.next()
    time.sleep(3)
    
    print("Previous track...")
    player.prev()
    time.sleep(3)
    
    player.stop()
    print("Playback control test complete.\n")
    
    print("=== All Tests Completed ===")
    print("\nTroubleshooting:")
    print("- No sound? Check:")
    print("  1. SD card is FAT32 format")
    print("  2. Audio files are named correctly (001.mp3, 002.mp3)")
    print("  3. Files are in /01/ folder")
    print("  4. Speaker is connected to SPK_1 and SPK_2")
    print("  5. 5V power is connected to DFPlayer VCC")
    print("\n- Garbled sound? Check:")
    print("  1. Audio file format (use 128kbps MP3)")
    print("  2. SD card quality (try a different card)")

if __name__ == "__main__":
    test_dfplayer()
