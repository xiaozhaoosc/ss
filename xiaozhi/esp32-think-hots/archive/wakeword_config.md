# 唤醒词配置: 肉肉，肉肉 (RouRou)

## 1. 原理
在 `xiaozhi-esp32` 的 `CustomWakeWord` 机制下，我们将 “肉肉，肉肉” 作为一条 `action="wake"` 的命令词添加到 MultiNet 中。

## 2. Pinyin 配置
中文 MultiNet 识别通过拼音映射：
- **目标词**：肉肉，肉肉
- **拼音串**：`rou rou rou rou` (四个字以提高识别率和防止误触发)

## 3. 修改建议

### 方案 A: 修改 Kconfig (快速验证)
在 `demo/xiaozhi-esp32/sdkconfig` 中设置：
```conf
CONFIG_CUSTOM_WAKE_WORD="rou rou rou rou"
CONFIG_CUSTOM_WAKE_WORD_DISPLAY="肉肉，肉肉"
CONFIG_CUSTOM_WAKE_WORD_THRESHOLD=70
```

### 方案 B: 动态配置 (推荐)
修改 `assets/index.json`：
```json
{
  "multinet_model": {
    "language": "cn",
    "threshold": 0.7,
    "commands": [
      {
        "command": "rou rou rou rou",
        "text": "肉肉，肉肉",
        "action": "wake"
      }
    ]
  }
}
```

## 4. 交互反馈
唤醒成功后，`audio_service.cc` 会回调 `on_wake_word_detected`。我们在 `application.cc` 中捕获并：
1. 立即停止任何正在播放的音频。
2. 耳机内播放 `ding.ogg`。
3. 进入 `kDeviceStateListening` 状态开始缓冲。
