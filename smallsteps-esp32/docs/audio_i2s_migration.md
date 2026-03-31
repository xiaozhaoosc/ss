# 音频播放切换到 I2S 的说明

## 修改原因

将音频播放从 DFPlayer Mini 切换到 I2S（MAX98357A），原因如下：
1. **简化硬件**：无需额外的 DFPlayer 模块，减少硬件成本和接线复杂度
2. **更好的控制**：I2S 播放可以直接控制音频数据，更灵活
3. **统一音频输出**：所有音频（音效、TTS）都通过同一个 I2S 输出

## 修改内容

### 1. 新增文件
- `audio_player.py` - I2S 音频播放器模块

### 2. 修改文件
- `config.py` - 增加音频目录和采样率配置
- `device.py` - 移除 DFPlayer，集成 I2S 播放器

### 3. 音频文件要求
- 格式：WAV（PCM）
- 采样率：16000Hz
- 位深：16-bit
- 声道：Mono
- 文件命名：`001.wav`, `002.wav`, ..., `007.wav`
- 存储位置：SD 卡 `/sounds/` 目录

## 使用方法

```python
# 播放音效
device.play_sound(config.SOUND_NEW_TASK)  # 播放 002.wav

# 直接播放 WAV 文件
device.audio_player.play_wav("/sounds/custom.wav")
```

## 注意事项

1. **音频文件准备**：需要将 7 个音效文件转换为 16kHz Mono WAV 格式
2. **SD 卡目录**：确保 SD 卡上有 `/sounds/` 目录
3. **采样率匹配**：音频文件的采样率必须与配置一致（16000Hz）
4. **播放阻塞**：当前实现是阻塞式播放，播放完成前无法播放其他音效
