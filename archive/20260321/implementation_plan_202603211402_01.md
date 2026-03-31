# 实施计划: 蓝牙自动连接与应用层集成

针对 "Small Steps" 终端的蓝牙重构，本计划将重点实现从“手动触发”到“自动感知”的流转，确保设备能自动发现并连接信号最强的耳机。

## 拟议变更

### 1. 蓝牙核心模块优化 [MODIFY]
#### [bluetooth_audio.h](file:///d:/kenzhao/cust_projects/smallsteps/demo/xiaozhi-esp32/main/audio/bluetooth_audio.h)
- 增加 `GetBestDevice` 接口，按 RSSI 排序返回最推荐的设备。
- 增加 `ClearDiscoveredDevices` 接口。

#### [bluetooth_audio.cc](file:///d:/kenzhao/cust_projects/smallsteps/demo/xiaozhi-esp32/main/audio/bluetooth_audio.cc)
- 实现 `GetBestDevice`：遍历 `discovered_devices_`，寻找 RSSI 最大的设备。
- 优化 `HandleGapEvent`：在搜寻结束 (`ESP_BT_GAP_DISC_CMPL_EVT`) 时，发送一个特定的内部事件或回调，通知应用层分配结果。

### 2. 应用层状态机适配 [MODIFY]
#### [application.cc](file:///d:/kenzhao/cust_projects/smallsteps/demo/xiaozhi-esp32/main/application.cc)
- **状态处理**: 在 `HandleStateChangedEvent` 中实现 `kDeviceStateBluetoothScanning`：
    - 调用 `BluetoothAudio::StartDiscovery()`。
    - 在 UI 上显示“正在寻找耳机...”。
- **自动连接逻辑**: 
    - 设置蓝牙搜寻回调：当搜寻结束时，自动调用 `BluetoothAudio::Connect()` 连接最佳设备。
    - 连接成功后，自动切回 `kDeviceStateIdle` 或之前的状态。

### 3. UI 反馈 [MODIFY]
#### [display.cc](file:///d:/kenzhao/cust_projects/smallsteps/demo/xiaozhi-esp32/main/display.cc) (或相关 UI 类)
- 确保有对应的文字提示（如“扫描蓝牙耳机中”）。

## 验证计划

### 自动化验证
- 编译通过测试：确保 `idf.py build` 无误。

### 手动验证
1. **自动扫描测试**: 开启蓝牙耳机，切换设备至蓝牙扫描模式，观察日志是否在搜寻结束后自动尝试连接。
2. **RSSI 过滤测试**: 同时开启两个耳机，确认设备是否优先选择信号更强（距离更近）的一个。
3. **音频切换测试**: 连接成功后，通过串口确认 `audio_service_` 的 Codec 已切换为 `BluetoothAudioCodec`。
