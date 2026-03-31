# 配置模式集成到 main.py 的修改说明

## 需要修改的部分

### 1. 导入配置管理器和 BLE 服务

在文件开头添加导入：

```python
from config_manager import ConfigManager
from ble_config_service import BLEConfigService
```

### 2. 在 `SmallStepsApp.__init__()` 中添加配置管理器

```python
def __init__(self):
    # ... 现有代码 ...
    
    # 添加配置管理器
    self.config_mgr = ConfigManager()
    
    # 检查是否需要进入配置模式
    self.config_mode_active = False
    self.config_mode_start_time = 0
    
    # ... 现有代码 ...
```

### 3. 在 `connect_network()` 前添加配置检查

在 `run()` 方法开始时添加：

```python
def run(self):
    """运行主程序"""
    # 1. 检查是否需要进入配置模式
    if not self.config_mgr.is_configured():
        print("\n[Main] 首次启动，进入配置模式")
        self.enter_config_mode()
        return  # 配置完成后会重启
    
    # 2. 正常启动流程
    self.connect_network()
    # ... 现有代码 ...
```

### 4. 添加配置模式方法

在 `SmallStepsApp` 类中添加以下方法：

```python
def enter_config_mode(self):
    """进入配置模式"""
    print("\n" + "=" * 60)
    print("进入配置模式")
    print("=" * 60)
    
    self.config_mode_active = True
    self.config_mode_start_time = time.time()
    
    # 1. 显示配置模式界面
    device_config = self.config_mgr.get_device_config()
    device_name = device_config.get("name", "SmallSteps")
    self.device.show_config_screen(device_name)
    
    # 2. 播放提示音
    self.device.play_sound(config.SOUND_NEW_TASK)
    
    # 3. 启动 BLE 配置服务
    self.ble_service = BLEConfigService(self.config_mgr, device_name)
    self.ble_service.start()
    
    print(f"[ConfigMode] BLE 服务已启动: {device_name}")
    print("[ConfigMode] 请使用手机连接蓝牙进行配置")
    
    # 4. 配置模式主循环
    self.config_mode_loop()

def config_mode_loop(self):
    """配置模式主循环"""
    CONFIG_TIMEOUT = 600  # 10 分钟超时
    led_breath_start = 0
    
    while self.config_mode_active:
        current_time = time.time()
        
        # 1. 检查超时
        if (current_time - self.config_mode_start_time) > CONFIG_TIMEOUT:
            print("\n[ConfigMode] 超时，退出配置模式")
            self.exit_config_mode()
            break
        
        # 2. 紫色呼吸灯效果（非阻塞）
        if (time.ticks_ms() - led_breath_start) > 100:
            # 这里需要改为非阻塞的呼吸灯实现
            # 或者在单独的线程中运行
            led_breath_start = time.ticks_ms()
        
        # 3. 检查配置是否保存成功
        if self.ble_service:
            status = self.ble_service.get_status()
            if status.get("status") == "success":
                print("\n[ConfigMode] 配置保存成功")
                self.device.play_sound(config.SOUND_TASK_COMPLETE)
                time.sleep(2)
                self.exit_config_mode()
                # 重启设备
                print("\n[Main] 重启设备...")
                import machine
                machine.reset()
        
        # 4. 检查按键（长按 Back 10 秒重置配置）
        self.check_config_mode_buttons()
        
        time.sleep(0.1)
        gc.collect()

def check_config_mode_buttons(self):
    """检查配置模式下的按键"""
    # 检测长按 Back 键 10 秒重置配置
    if self.device.btn_back.value() == 0:
        press_start = time.time()
        while self.device.btn_back.value() == 0:
            if (time.time() - press_start) > 10:
                print("\n[ConfigMode] 长按 Back 10 秒，重置配置")
                self.config_mgr.reset_config()
                self.device.play_sound(config.SOUND_ERROR)
                # 重新加载配置
                if self.ble_service:
                    self.ble_service.stop()
                    self.ble_service = BLEConfigService(self.config_mgr, "SmallSteps")
                    self.ble_service.start()
                break
            time.sleep(0.1)

def exit_config_mode(self):
    """退出配置模式"""
    print("\n[ConfigMode] 退出配置模式")
    
    self.config_mode_active = False
    
    # 停止 BLE 服务
    if hasattr(self, 'ble_service') and self.ble_service:
        self.ble_service.stop()
        self.ble_service = None
    
    # 恢复正常显示
    self.device.show_idle_screen()
    self.device.set_led_status("idle")
```

### 5. 在按键处理中添加进入配置模式的触发

在 `check_buttons()` 方法中添加：

```python
def check_buttons(self):
    """检查按键状态"""
    # ... 现有代码 ...
    
    # 检测长按 Back 键 5 秒进入配置模式
    if self.device.btn_back.value() == 0:
        press_start = time.time()
        while self.device.btn_back.value() == 0:
            if (time.time() - press_start) > 5:
                print("\n[Main] 长按 Back 5 秒，进入配置模式")
                self.enter_config_mode()
                break
            time.sleep(0.1)
```

## 完整的修改流程

1. ✅ 在文件开头添加导入
2. ✅ 在 `__init__()` 中初始化配置管理器
3. ✅ 在 `run()` 开始时检查配置状态
4. ✅ 添加 `enter_config_mode()` 方法
5. ✅ 添加 `config_mode_loop()` 方法
6. ✅ 添加 `check_config_mode_buttons()` 方法
7. ✅ 添加 `exit_config_mode()` 方法
8. ✅ 在 `check_buttons()` 中添加长按触发

## 注意事项

1. **呼吸灯效果**: 当前的 `led_breathing()` 是阻塞的，在配置模式循环中需要改为非阻塞实现
2. **按键检测**: 长按检测需要在主循环中实现，避免阻塞
3. **重启**: 配置保存成功后需要重启设备以应用新配置
4. **错误处理**: 需要处理 BLE 服务启动失败的情况

## 测试步骤

1. 首次启动设备（无配置文件）
2. 自动进入配置模式
3. 使用手机连接 BLE
4. 配置 WiFi 和 MQTT
5. 保存配置
6. 设备自动重启
7. 正常启动并连接网络
