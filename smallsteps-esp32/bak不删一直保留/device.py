from machine import Pin, SPI, I2S, UART
import neopixel
import st7735
from dfplayermini import DFPlayerMini
import network
import bluetooth
import time
import gc
import struct
import config

class HardwareConfig:
    # Pin Definitions (ESP32-S3)
    
    # Display (ST7735)
    PIN_LCD_SCLK = 12
    PIN_LCD_MOSI = 11
    PIN_LCD_MISO = 13 # Not connected, but needed for SoftSPI/HardSPI config
    PIN_LCD_CS   = 10
    PIN_LCD_DC   = 9
    PIN_LCD_RST  = 46
    PIN_LCD_BLK  = 3
    
    # Buttons
    PIN_BTN_UP   = 4
    PIN_BTN_DOWN = 5
    PIN_BTN_OK   = 6
    PIN_BTN_BACK = 7
    
    # Audio (DFPlayer) - UART1
    PIN_DF_TX    = 18 # Connect to DF RX
    PIN_DF_RX    = 17 # Connect to DF TX
    
    # Audio (I2S MAX98357A)
    PIN_I2S_DIN  = 16 # Changed from 47 (Octal S3 conflict)
    PIN_I2S_BCLK = 8  # Changed from 48 (Octal S3 conflict)
    PIN_I2S_LRC  = 21 # Connect VCC to 3.3V if 5V rail is dead

    # Light (WS2812B)
    PIN_RGB      = 15 # Changed to 15 (Must use 3.3V power to match logic level)
    RGB_COUNT    = 12 # 12-LED Ring
    
    # Haptic
    PIN_MOTOR    = 1  # Safe IO for Motor (requires 5V to run properly)
    
    # Microphone (I2S INMP441)
    PIN_MIC_SCK  = 41
    PIN_MIC_WS   = 42
    PIN_MIC_SD   = 2
    
    # NFC (RC522) - Commented out until hardware is connected
    # PIN_NFC_SCLK = 6
    # PIN_NFC_MOSI = 7
    # PIN_NFC_MISO = 2
    # PIN_NFC_RST  = 4
    # PIN_NFC_CS   = 5

class DeviceManager:
    def __init__(self):
        print("Initializing Hardware...")
        self.init_display()
        self.init_buttons()
        self.init_rgb()
        self.init_audio()      # DFPlayer
        self.init_i2s_audio()  # Speaker (MAX98357A)
        self.init_haptic()
        
        # 延迟/懒加载 WiFi 和 BLE 以节省内存 (约 50KB+)
        self.wifi = None
        self.ble = None
        
        gc.collect()
        print(f"Hardware Initialized. Free memory: {gc.mem_free()} bytes")
        
    def init_display(self):
        # SPI2 for S3
        self.spi = SPI(2, baudrate=20000000, polarity=0, phase=0,
                       sck=Pin(HardwareConfig.PIN_LCD_SCLK),
                       mosi=Pin(HardwareConfig.PIN_LCD_MOSI),
                       miso=Pin(HardwareConfig.PIN_LCD_MISO))
                       
        self.tft = st7735.ST7735(self.spi,
                                 dc=Pin(HardwareConfig.PIN_LCD_DC),
                                 cs=Pin(HardwareConfig.PIN_LCD_CS),
                                 rst=Pin(HardwareConfig.PIN_LCD_RST),
                                 blk=Pin(HardwareConfig.PIN_LCD_BLK))
        print("Display Initialized")

    def init_buttons(self):
        self.btn_up   = Pin(HardwareConfig.PIN_BTN_UP, Pin.IN, Pin.PULL_UP)
        self.btn_down = Pin(HardwareConfig.PIN_BTN_DOWN, Pin.IN, Pin.PULL_UP)
        self.btn_ok   = Pin(HardwareConfig.PIN_BTN_OK, Pin.IN, Pin.PULL_UP)
        self.btn_back = Pin(HardwareConfig.PIN_BTN_BACK, Pin.IN, Pin.PULL_UP)
        print("Buttons Initialized")

    def init_rgb(self):
        self.np = neopixel.NeoPixel(Pin(HardwareConfig.PIN_RGB), HardwareConfig.RGB_COUNT)
        self.clear_rgb()
        print("RGB Ring Initialized")

    def clear_rgb(self):
        for i in range(HardwareConfig.RGB_COUNT):
            self.np[i] = (0, 0, 0)
        self.np.write()

    def set_rgb_color(self, r, g, b):
        for i in range(HardwareConfig.RGB_COUNT):
            self.np[i] = (r, g, b)
        self.np.write()

    def init_audio(self):
        try:
            # UART1 for DFPlayer
            self.player = DFPlayerMini(1, tx_pin=HardwareConfig.PIN_DF_TX, rx_pin=HardwareConfig.PIN_DF_RX)
            self.player.reset()
            time.sleep(1) # Wait for reset
            self.player.volume(30) # Max volume
            print("Audio Initialized")
        except Exception as e:
            print(f"Audio Init Failed: {e}")
            self.player = None

    def init_i2s_audio(self, rate=44100):
        try:
            # Try to deinit existing I2S instances to avoid 'ESP_ERR_INVALID_STATE'
            for i in [0, 1]:
                try:
                    dummy = I2S(i)
                    dummy.deinit()
                except:
                    pass
            
            # Use I2S 1 for Speaker (MAX98357A) - avoids conflict with some board internals
            self.audio_out = I2S(1,
                                sck=Pin(HardwareConfig.PIN_I2S_BCLK),
                                ws=Pin(HardwareConfig.PIN_I2S_LRC),
                                sd=Pin(HardwareConfig.PIN_I2S_DIN),
                                mode=I2S.TX,
                                bits=16,
                                format=I2S.MONO,
                                rate=rate,
                                ibuf=10000)
            print(f"I2S Audio (MAX98357A) Initialized on I2S 1 at {rate}Hz")
        except Exception as e:
            print(f"I2S Audio Init Failed: {e}")
            self.audio_out = None

    def init_haptic(self):
        self.motor = Pin(HardwareConfig.PIN_MOTOR, Pin.OUT)
        self.motor.value(0)
        print("Haptic Initialized")

    def vibrate(self, duration_ms=100):
        self.motor.value(1)
        time.sleep_ms(duration_ms)
        self.motor.value(0)

    def init_wifi(self):
        if self.wifi is None:
            from manager import WiFiManager
            self.wifi = WiFiManager()
            print("WiFi Initialized (Manager)")
            gc.collect()

    def connect_wifi(self):
        self.init_wifi()
        success = self.wifi.connect()
        if success:
            # Auto sync time on connection
            self.wifi.sync_time()
            return self.wifi.get_status()
        return False

    def init_ble(self):
        if self.ble is None:
            import bluetooth
            self.ble = bluetooth.BLE()
            self.ble.active(True)
            print("BLE Initialized")
            gc.collect()

    def advertise_ble(self):
        self.init_ble()
        name = config.BLE_NAME
        # Flags (General Discoverable Mode) + Name
        payload = struct.pack("BB", 0x02, 0x01) + struct.pack("B", 0x06) + \
                  struct.pack("BB", len(name) + 1, 0x09) + name.encode()
        
        # Advertise for 100ms interval
        self.ble.gap_advertise(100000, adv_data=payload)
        print(f"Advertising BLE: {name}")
        
    def stop_ble(self):
        self.ble.gap_advertise(None)
        print("BLE Stopped")

    # def init_nfc(self):
    #     import mfrc522
    #     try:
    #         self.nfc = mfrc522.MFRC522(sck=HardwareConfig.PIN_NFC_SCLK,
    #                                    mosi=HardwareConfig.PIN_NFC_MOSI,
    #                                    miso=HardwareConfig.PIN_NFC_MISO,
    #                                    rst=HardwareConfig.PIN_NFC_RST,
    #                                    cs=HardwareConfig.PIN_NFC_CS)
    #         print("NFC Initialized")
    #     except Exception as e:
    #         print(f"NFC Init Failed: {e}")
    #         self.nfc = None

    def record_audio(self, filename="rec.wav", duration_sec=5):
        # 释放已有 I2S 播放资源并强制回收内存
        if hasattr(self, 'audio_out') and self.audio_out:
            print("De-initializing Speaker for Recording...")
            try:
                self.audio_out.deinit()
            except:
                pass
        
        gc.collect()
        
        try:
            # INMP441 通常需要 32-bit Stereo 才能稳定输出
            SAMPLE_RATE = 16000
            audio_in = I2S(1, 
                           sck=Pin(HardwareConfig.PIN_MIC_SCK),
                           ws=Pin(HardwareConfig.PIN_MIC_WS),
                           sd=Pin(HardwareConfig.PIN_MIC_SD),
                           mode=I2S.RX,
                           bits=32,
                           format=I2S.STEREO,
                           rate=SAMPLE_RATE,
                           ibuf=8192)
            
            # WAV 目标参数 (我们保存为 16-bit Mono 以节省空间并提高兼容性)
            BITS_PER_SAMPLE = 16
            NUM_CHANNELS = 1
            BYTE_RATE = SAMPLE_RATE * NUM_CHANNELS * BITS_PER_SAMPLE // 8
            BLOCK_ALIGN = NUM_CHANNELS * BITS_PER_SAMPLE // 8
            DATA_SIZE = SAMPLE_RATE * duration_sec * BLOCK_ALIGN
            
            with open(filename, 'wb') as f:
                # WAV Header
                f.write(b'RIFF')
                f.write(struct.pack('<I', 36 + DATA_SIZE))
                f.write(b'WAVEfmt ')
                f.write(struct.pack('<I', 16))
                f.write(struct.pack('<H', 1))  # PCM
                f.write(struct.pack('<H', NUM_CHANNELS))
                f.write(struct.pack('<I', SAMPLE_RATE))
                f.write(struct.pack('<I', BYTE_RATE))
                f.write(struct.pack('<H', BLOCK_ALIGN))
                f.write(struct.pack('<H', BITS_PER_SAMPLE))
                f.write(b'data')
                f.write(struct.pack('<I', DATA_SIZE))
                
                # 录音转换循环
                # 智能检测左右声道并提取有效数据
                READ_SIZE = 1024 
                buf = bytearray(READ_SIZE)
                out_buf = bytearray(READ_SIZE // 4) 
                
                # 先读取一小段数据检测哪个声道有信号
                print("Detecting active channel...")
                audio_in.readinto(buf)
                
                # 检测左声道和右声道的数据变化量（方差）
                # 全是0xFF或0x00的声道方差为0，有真实信号的声道方差大
                left_values = []
                right_values = []
                for i in range(0, min(512, len(buf)), 8):
                    # 提取字节1和2（小端序的有效16位）
                    left_val = buf[i+1] + (buf[i+2] << 8)
                    right_val = buf[i+5] + (buf[i+6] << 8)
                    left_values.append(left_val)
                    right_values.append(right_val)
                
                # 计算方差（数据变化量）
                def variance(values):
                    if not values: return 0
                    mean = sum(values) // len(values)
                    return sum((v - mean) ** 2 for v in values) // len(values)
                
                left_var = variance(left_values)
                right_var = variance(right_values)
                
                # 选择方差更大的声道（有变化的数据）
                if right_var > left_var:
                    channel_offset = 4  # 右声道
                    print(f"Using RIGHT channel (variance: {right_var} vs {left_var})")
                else:
                    channel_offset = 0  # 左声道
                    print(f"Using LEFT channel (variance: {left_var} vs {right_var})")
                
                print(f"Recording ({duration_sec}s)...")
                start_time = time.ticks_ms()
                while time.ticks_diff(time.ticks_ms(), start_time) < duration_sec * 1000:
                    num_read = audio_in.readinto(buf)
                    if num_read > 0:
                        idx = 0
                        for i in range(0, num_read, 8):
                            # INMP441 输出小端序，右声道有数据
                            # 右声道格式: [byte0, byte1, byte2, byte3]
                            # 有效的16位在 byte0和byte1
                            low = buf[i + channel_offset]
                            high = buf[i + channel_offset + 1]
                            
                            # 小端序解包
                            sample = struct.unpack('<h', bytes([low, high]))[0]
                            
                            # 软件增益 (8倍，避免爆音)
                            sample = min(32767, max(-32768, sample << 3))
                            
                            # 小端序保存到 WAV
                            s_bytes = struct.pack('<h', sample)
                            out_buf[idx] = s_bytes[0]
                            out_buf[idx+1] = s_bytes[1]
                            idx += 2
                        f.write(out_buf[:idx])
            
            audio_in.deinit()
            print("Recording Saved. Re-initializing Speaker...")
            self.init_i2s_audio()
            return True
        except Exception as e:
            print(f"Recording Failed: {e}")
            try:
                audio_in.deinit()
            except: pass
            self.init_i2s_audio()
            return False

