from lib.dfplayermini import DFPlayerMini
import config
import time

# ========================================
# DFPlayer 诊断脚本
# ========================================

def diagnose_dfplayer():
    print("=== DFPlayer Diagnostic Tool ===\n")
    
    # 初始化
    print("[1] Initializing DFPlayer...")
    player = DFPlayerMini(
        uart_id=config.DFPLAYER_UART_ID,
        tx_pin=config.DFPLAYER_TX_PIN,
        rx_pin=config.DFPLAYER_RX_PIN
    )
    print("OK\n")
    
    # 重置
    print("[2] Resetting module...")
    player.reset()
    time.sleep(3)  # 等待更长时间
    print("OK\n")
    
    # 设置音量到最大
    print("[3] Setting volume to MAX (30)...")
    player.volume(30)
    time.sleep(0.5)
    print("OK\n")
    
    # 尝试不同的播放命令
    print("[4] Testing different play commands...\n")
    
    # 测试 A: 播放第 1 首歌（按索引）
    print("  [A] Play by index (file 1)...")
    player.play(file=1)
    print("  Waiting 5 seconds... (Listen for sound)")
    time.sleep(5)
    player.stop()
    time.sleep(1)
    
    # 测试 B: 播放文件夹 1 文件 1
    print("  [B] Play folder 01, file 001...")
    player.play(folder=1, file=1)
    print("  Waiting 5 seconds... (Listen for sound)")
    time.sleep(5)
    player.stop()
    time.sleep(1)
    
    # 测试 C: 播放文件夹 1 文件 2
    print("  [C] Play folder 01, file 002...")
    player.play(folder=1, file=2)
    print("  Waiting 5 seconds... (Listen for sound)")
    time.sleep(5)
    player.stop()
    time.sleep(1)
    
    # 测试 D: 连续播放（不停止）
    print("  [D] Continuous play (10 seconds)...")
    player.play(folder=1, file=1)
    print("  Waiting 10 seconds... (Listen for sound)")
    time.sleep(10)
    player.stop()
    
    print("\n=== Diagnostic Complete ===\n")
    print("Troubleshooting Checklist:")
    print("1. Hardware:")
    print("   - Is speaker connected to SPK_1 and SPK_2?")
    print("   - Is speaker working? (Test with another device)")
    print("   - Is DFPlayer VCC connected to 3.3V or 5V?")
    print("   - Is GND connected?")
    print("")
    print("2. SD Card:")
    print("   - Is SD card inserted into DFPlayer slot?")
    print("   - Is SD card FAT32 formatted?")
    print("   - Are files named correctly? (001.mp3, 002.mp3)")
    print("   - Are files in /01/ folder?")
    print("   - Try playing files on computer to verify they work")
    print("")
    print("3. DFPlayer Module:")
    print("   - Is the module damaged?")
    print("   - Try connecting speaker directly to test")
    print("   - Check if LED on DFPlayer blinks during playback")
    print("")
    print("4. Audio Files:")
    print("   - File format: MP3 or WAV")
    print("   - Bitrate: 128kbps recommended (not too high)")
    print("   - Sample rate: 44.1kHz or lower")

if __name__ == "__main__":
    diagnose_dfplayer()
