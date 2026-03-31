"""
配置模式示例代码
演示如何集成配置管理器和 BLE 配置服务到 main.py
"""

from config_manager import ConfigManager
from ble_config_service import BLEConfigService
from device import DeviceManager
import time

class ConfigMode:
    """配置模式管理"""
    
    def __init__(self, device, config_manager):
        """
        初始化配置模式
        
        Args:
            device: 设备管理器实例
            config_manager: 配置管理器实例
        """
        self.device = device
        self.config_manager = config_manager
        self.ble_service = None
        self.active = False
    
    def enter(self):
        """进入配置模式"""
        print("\n" + "=" * 60)
        print("进入配置模式")
        print("=" * 60)
        
        self.active = True
        
        # 1. 显示配置模式界面
        self._show_config_screen()
        
        # 2. 设置灯环为紫色呼吸灯
        self.device.set_led_status("config")
        
        # 3. 播放提示音
        self.device.play_sound(2)  # 新任务提示音
        
        # 4. 启动 BLE 配置服务
        device_config = self.config_manager.get_device_config()
        device_name = device_config.get("name", "SmallSteps")
        
        self.ble_service = BLEConfigService(self.config_manager, device_name)
        self.ble_service.start()
        
        print(f"[ConfigMode] BLE 服务已启动: {device_name}")
        print("[ConfigMode] 请使用手机连接蓝牙进行配置")
    
    def exit(self):
        """退出配置模式"""
        print("\n[ConfigMode] 退出配置模式")
        
        self.active = False
        
        # 停止 BLE 服务
        if self.ble_service:
            self.ble_service.stop()
            self.ble_service = None
        
        # 恢复正常显示
        self.device.show_idle_screen()
        self.device.set_led_status("idle")
    
    def check_timeout(self, start_time, timeout=600):
        """
        检查配置模式超时
        
        Args:
            start_time: 开始时间
            timeout: 超时时间（秒），默认 10 分钟
        
        Returns:
            bool: 是否超时
        """
        return (time.time() - start_time) > timeout
    
    def check_save_success(self):
        """
        检查配置是否保存成功
        
        Returns:
            bool: 是否保存成功
        """
        if self.ble_service:
            status = self.ble_service.get_status()
            return status.get("status") == "success"
        return False
    
    def _show_config_screen(self):
        """显示配置模式界面"""
        device_config = self.config_manager.get_device_config()
        device_name = device_config.get("name", "SmallSteps")
        
        # 在屏幕上显示配置信息
        # 这里使用简单的文本显示，实际应该使用图形界面
        print("\n┌──────────────┐")
        print("│ 配置模式     │")
        print("│              │")
        print(f"│ {device_name:12s} │")
        print("│              │")
        print("│ 请使用手机   │")
        print("│ 连接蓝牙配置 │")
        print("└──────────────┘\n")


def main_with_config_mode():
    """
    集成配置模式的主程序示例
    """
    print("=" * 60)
    print("Small Steps v1.1.0 - 配置模式集成")
    print("=" * 60)
    
    # 1. 初始化设备
    device = DeviceManager()
    
    # 2. 初始化配置管理器
    config_manager = ConfigManager()
    
    # 3. 检查是否需要进入配置模式
    need_config = False
    
    # 3.1 检查配置文件是否存在
    if not config_manager.is_configured():
        print("\n[Main] 首次启动，进入配置模式")
        need_config = True
    
    # 3.2 检查是否长按 Back 键（这里用简单的输入模拟）
    # 实际应该在按键处理中检测
    
    # 4. 进入配置模式或正常启动
    if need_config:
        config_mode = ConfigMode(device, config_manager)
        config_mode.enter()
        
        # 配置模式主循环
        start_time = time.time()
        while config_mode.active:
            # 检查超时
            if config_mode.check_timeout(start_time):
                print("\n[Main] 配置模式超时，退出")
                break
            
            # 检查配置是否保存成功
            if config_mode.check_save_success():
                print("\n[Main] 配置保存成功，3秒后重启")
                device.play_sound(4)  # 任务完成音效
                time.sleep(3)
                break
            
            # 等待一段时间
            time.sleep(1)
        
        # 退出配置模式
        config_mode.exit()
        
        # 重启设备
        print("\n[Main] 重启设备...")
        import machine
        machine.reset()
    
    else:
        # 正常启动
        print("\n[Main] 配置已存在，正常启动")
        
        # 加载配置
        config = config_manager.load_config()
        wifi_config = config.get("wifi", {})
        mqtt_config = config.get("mqtt", {})
        
        print(f"  WiFi SSID: {wifi_config.get('ssid')}")
        print(f"  MQTT Broker: {mqtt_config.get('broker')}")
        print(f"  Device ID: {mqtt_config.get('device_id')}")
        
        # 继续正常的启动流程...
        print("\n[Main] 启动完成")


if __name__ == "__main__":
    main_with_config_mode()
