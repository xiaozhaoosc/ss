"""
I2S 音频播放模块
功能：通过 MAX98357A 功放播放 WAV 文件
"""

import time
import struct

class I2SAudioPlayer:
    """I2S 音频播放器"""
    
    def __init__(self, i2s_device, reinit_callback=None):
        """
        初始化播放器
        
        Args:
            i2s_device: I2S 设备对象（已初始化的 machine.I2S）
            reinit_callback: 重新初始化回调函数，接收 sample_rate 参数
        """
        self.i2s = i2s_device
        self.reinit_callback = reinit_callback
        self.current_rate = 16000 # 假设初始为 16k
        self.is_playing = False
        print("[AudioPlayer] Initialized")
    
    def _parse_wav_header(self, f):
        """
        解析 WAV 文件头 (Robust version)
        
        Returns:
            tuple: (sample_rate, data_start_offset) or (None, None)
        """
        try:
            f.seek(0)
            header = f.read(12)
            if header[0:4] != b'RIFF' or header[8:12] != b'WAVE':
                return None, None
            
            # Search for 'fmt ' chunk
            # 简单起见，我们只搜索前 100 字节
            f.seek(12)
            buffer = f.read(100)
            
            idx = 0
            sample_rate = None
            data_offset = 44 # Default
            
            # Find fmt chunk
            fmt_idx = buffer.find(b'fmt ')
            if fmt_idx != -1:
                # fmt chunk size (4 bytes)
                # audio format (2 bytes)
                # num channels (2 bytes)
                # sample rate (4 bytes)
                # fmt_idx + 4 (size) + 4 (fmt) + 2 (pcm) + 2 (ch) = +12
                # sample rate is at fmt_idx + 12
                if fmt_idx + 16 <= len(buffer):
                    sr_offset = fmt_idx + 12
                    sample_rate = struct.unpack('<I', buffer[sr_offset:sr_offset+4])[0]
                    
                    channels = struct.unpack('<H', buffer[sr_offset-2:sr_offset])[0]
                    print(f"[Audio] Found fmt at {fmt_idx+12}: Rate={sample_rate}, Ch={channels}")

            # Find data chunk to determine offset
            data_idx = buffer.find(b'data')
            if data_idx != -1:
                data_offset = 12 + data_idx + 8 # +4 (data) +4 (size)
            
            return sample_rate, data_offset
            
        except Exception as e:
            print(f"[AudioPlayer] Header parse error: {e}")
            return None, None

    def play_wav(self, filename, sample_rate=None):
        """
        播放 WAV 文件
        
        Args:
            filename: WAV 文件路径
            sample_rate: 强制指定采样率 (如果为 None 则自动检测)
        
        Returns:
            bool: 播放是否成功
        """
        if self.is_playing:
            print("[AudioPlayer] Already playing, skipping")
            return False
        
        try:
            self.is_playing = True
            
            # 打开文件
            with open(filename, 'rb') as f:
                # 自动检测采样率
                detected_rate, data_offset = self._parse_wav_header(f)
                
                if detected_rate:
                    # 如果检测到采样率且与当前不同，尝试重新初始化
                    if self.reinit_callback and detected_rate != self.current_rate:
                        print(f"[AudioPlayer] Switching rate: {self.current_rate} -> {detected_rate}")
                        new_i2s = self.reinit_callback(detected_rate)
                        if new_i2s:
                            self.i2s = new_i2s
                            self.current_rate = detected_rate
                            
                    # 如果没有 callback 但提供了 sample_rate 参数，这是旧逻辑，忽略
                
                # 跳过文件头
                f.seek(data_offset if data_offset else 44)
                
                # 读取并播放音频数据
                buf = bytearray(4096)
                while True:
                    num_read = f.readinto(buf)
                    if num_read == 0:
                        break
                    
                    # 写入 I2S
                    self.i2s.write(buf[:num_read])
            
            print(f"[AudioPlayer] Played: {filename}")
            self.is_playing = False
            return True
            
        except Exception as e:
            print(f"[AudioPlayer] Play failed: {e}")
            self.is_playing = False
            return False
    
    def play_sound(self, sound_id, sound_dir="/wavs"):
        """
        播放音效（按编号）
        
        Args:
            sound_id: 音效编号（1-7）
            sound_dir: 音效文件目录
        
        Returns:
            bool: 播放是否成功
        """
        # 构建文件名（如：/wavs/001.wav）
        filename = f"{sound_dir}/{sound_id:03d}.wav"
        return self.play_wav(filename)
    
    def stop(self):
        """停止播放"""
        # I2S 没有直接的停止方法，只能等待播放完成
        # 或者通过标志位在下次循环时中断
        self.is_playing = False
        print("[AudioPlayer] Stopped")
