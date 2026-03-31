"""
BLE 配置服务模块
通过蓝牙提供配置接口
"""

import bluetooth
from micropython import const
import json
import struct

# BLE 服务和特征值 UUID
_SERVICE_UUID = bluetooth.UUID("0000fff0-0000-1000-8000-00805f9b34fb")
_CHAR_WIFI_SSID_UUID = bluetooth.UUID("0000fff1-0000-1000-8000-00805f9b34fb")
_CHAR_WIFI_PASS_UUID = bluetooth.UUID("0000fff2-0000-1000-8000-00805f9b34fb")
_CHAR_MQTT_BROKER_UUID = bluetooth.UUID("0000fff3-0000-1000-8000-00805f9b34fb")
_CHAR_MQTT_PORT_UUID = bluetooth.UUID("0000fff4-0000-1000-8000-00805f9b34fb")
_CHAR_DEVICE_ID_UUID = bluetooth.UUID("0000fff5-0000-1000-8000-00805f9b34fb")
_CHAR_STATUS_UUID = bluetooth.UUID("0000fff6-0000-1000-8000-00805f9b34fb")
_CHAR_SAVE_UUID = bluetooth.UUID("0000fff7-0000-1000-8000-00805f9b34fb")
_CHAR_RESET_UUID = bluetooth.UUID("0000fff8-0000-1000-8000-00805f9b34fb")

# BLE 特征值标志
_FLAG_READ = const(0x0002)
_FLAG_WRITE = const(0x0008)
_FLAG_NOTIFY = const(0x0010)

class BLEConfigService:
    """BLE 配置服务"""
    
    def __init__(self, config_manager, device_name="SmallSteps"):
        """
        初始化 BLE 配置服务
        
        Args:
            config_manager: 配置管理器实例
            device_name: 设备名称
        """
        self.config_manager = config_manager
        self.device_name = device_name
        self.ble = bluetooth.BLE()
        self.ble.active(True)
        
        # 临时配置缓存
        self.temp_config = {
            "wifi": {"ssid": "", "password": ""},
            "mqtt": {"broker": "", "port": 1883, "device_id": ""},
            "device": {"name": "", "description": ""}
        }
        
        # 状态
        self.status = {
            "status": "idle",
            "message": "等待配置",
            "progress": 0
        }
        
        # 连接状态
        self.connected = False
        self.conn_handle = None
        
        # 注册服务
        self._register_services()
        
        # 设置回调
        self.ble.irq(self._irq_handler)
        
        print("[BLEConfigService] Initialized")
    
    def start(self):
        """
        启动 BLE 配置服务
        
        Returns:
            bool: 启动是否成功
        """
        try:
            # 加载当前配置到临时缓存
            config = self.config_manager.load_config()
            self.temp_config["wifi"] = config.get("wifi", {}).copy()
            self.temp_config["mqtt"] = config.get("mqtt", {}).copy()
            self.temp_config["device"] = config.get("device", {}).copy()
            
            # 开始广播
            self._advertise()
            
            print(f"[BLEConfigService] Started, device name: {self.device_name}")
            return True
            
        except Exception as e:
            print(f"[BLEConfigService] Start failed: {e}")
            return False
    
    def stop(self):
        """
        停止 BLE 配置服务
        
        Returns:
            bool: 停止是否成功
        """
        try:
            self.ble.gap_advertise(None)
            self.ble.active(False)
            print("[BLEConfigService] Stopped")
            return True
            
        except Exception as e:
            print(f"[BLEConfigService] Stop failed: {e}")
            return False
    
    def _register_services(self):
        """注册 BLE 服务和特征值"""
        # 定义特征值
        self.char_wifi_ssid = (
            _CHAR_WIFI_SSID_UUID,
            _FLAG_READ | _FLAG_WRITE,
        )
        self.char_wifi_pass = (
            _CHAR_WIFI_PASS_UUID,
            _FLAG_WRITE,
        )
        self.char_mqtt_broker = (
            _CHAR_MQTT_BROKER_UUID,
            _FLAG_READ | _FLAG_WRITE,
        )
        self.char_mqtt_port = (
            _CHAR_MQTT_PORT_UUID,
            _FLAG_READ | _FLAG_WRITE,
        )
        self.char_device_id = (
            _CHAR_DEVICE_ID_UUID,
            _FLAG_READ | _FLAG_WRITE,
        )
        self.char_status = (
            _CHAR_STATUS_UUID,
            _FLAG_READ | _FLAG_NOTIFY,
        )
        self.char_save = (
            _CHAR_SAVE_UUID,
            _FLAG_WRITE,
        )
        self.char_reset = (
            _CHAR_RESET_UUID,
            _FLAG_WRITE,
        )
        
        # 注册服务
        services = (
            (
                _SERVICE_UUID,
                (
                    self.char_wifi_ssid,
                    self.char_wifi_pass,
                    self.char_mqtt_broker,
                    self.char_mqtt_port,
                    self.char_device_id,
                    self.char_status,
                    self.char_save,
                    self.char_reset,
                ),
            ),
        )
        
        ((
            self.handle_wifi_ssid,
            self.handle_wifi_pass,
            self.handle_mqtt_broker,
            self.handle_mqtt_port,
            self.handle_device_id,
            self.handle_status,
            self.handle_save,
            self.handle_reset,
        ),) = self.ble.gatts_register_services(services)
    
    def _advertise(self):
        """开始 BLE 广播"""
        name = bytes(self.device_name, 'utf-8')
        adv_data = bytearray(b'\x02\x01\x06') + bytearray((len(name) + 1, 0x09)) + name
        self.ble.gap_advertise(100000, adv_data)
    
    def _irq_handler(self, event, data):
        """BLE 事件处理"""
        # 连接事件
        if event == 1:  # _IRQ_CENTRAL_CONNECT
            conn_handle, _, _ = data
            self.connected = True
            self.conn_handle = conn_handle
            print(f"[BLEConfigService] Client connected: {conn_handle}")
        
        # 断开事件
        elif event == 2:  # _IRQ_CENTRAL_DISCONNECT
            conn_handle, _, _ = data
            self.connected = False
            self.conn_handle = None
            print(f"[BLEConfigService] Client disconnected: {conn_handle}")
            # 重新开始广播
            self._advertise()
        
        # 写入事件
        elif event == 3:  # _IRQ_GATTS_WRITE
            conn_handle, attr_handle = data
            value = self.ble.gatts_read(attr_handle)
            self._handle_write(attr_handle, value)
    
    def _handle_write(self, attr_handle, value):
        """处理写入请求"""
        try:
            # WiFi SSID
            if attr_handle == self.handle_wifi_ssid:
                ssid = value.decode('utf-8')
                self.temp_config["wifi"]["ssid"] = ssid
                print(f"[BLEConfigService] WiFi SSID set: {ssid}")
            
            # WiFi Password
            elif attr_handle == self.handle_wifi_pass:
                password = value.decode('utf-8')
                self.temp_config["wifi"]["password"] = password
                print(f"[BLEConfigService] WiFi Password set")
            
            # MQTT Broker
            elif attr_handle == self.handle_mqtt_broker:
                broker = value.decode('utf-8')
                self.temp_config["mqtt"]["broker"] = broker
                print(f"[BLEConfigService] MQTT Broker set: {broker}")
            
            # MQTT Port
            elif attr_handle == self.handle_mqtt_port:
                port = struct.unpack('<H', value)[0]
                self.temp_config["mqtt"]["port"] = port
                print(f"[BLEConfigService] MQTT Port set: {port}")
            
            # Device ID
            elif attr_handle == self.handle_device_id:
                device_id = value.decode('utf-8')
                self.temp_config["mqtt"]["device_id"] = device_id
                print(f"[BLEConfigService] Device ID set: {device_id}")
            
            # Save Command
            elif attr_handle == self.handle_save:
                self._save_config()
            
            # Reset Command
            elif attr_handle == self.handle_reset:
                self._reset_config()
        
        except Exception as e:
            print(f"[BLEConfigService] Handle write error: {e}")
            self._update_status("error", f"处理失败: {e}", 0)
    
    def _save_config(self):
        """保存配置"""
        try:
            print("[BLEConfigService] Saving config...")
            self._update_status("saving", "正在保存配置", 50)
            
            # 合并配置
            config = self.config_manager.load_config()
            config["wifi"] = self.temp_config["wifi"]
            config["mqtt"] = self.temp_config["mqtt"]
            config["device"] = self.temp_config["device"]
            
            # 保存
            if self.config_manager.save_config(config):
                self._update_status("success", "配置保存成功", 100)
                print("[BLEConfigService] Config saved successfully")
            else:
                self._update_status("error", "配置保存失败", 0)
                print("[BLEConfigService] Config save failed")
        
        except Exception as e:
            print(f"[BLEConfigService] Save error: {e}")
            self._update_status("error", f"保存失败: {e}", 0)
    
    def _reset_config(self):
        """重置配置"""
        try:
            print("[BLEConfigService] Resetting config...")
            self._update_status("resetting", "正在重置配置", 50)
            
            if self.config_manager.reset_config():
                # 重新加载默认配置
                config = self.config_manager.load_config()
                self.temp_config["wifi"] = config.get("wifi", {}).copy()
                self.temp_config["mqtt"] = config.get("mqtt", {}).copy()
                self.temp_config["device"] = config.get("device", {}).copy()
                
                self._update_status("success", "配置重置成功", 100)
                print("[BLEConfigService] Config reset successfully")
            else:
                self._update_status("error", "配置重置失败", 0)
                print("[BLEConfigService] Config reset failed")
        
        except Exception as e:
            print(f"[BLEConfigService] Reset error: {e}")
            self._update_status("error", f"重置失败: {e}", 0)
    
    def _update_status(self, status, message, progress):
        """更新状态并通知客户端"""
        self.status = {
            "status": status,
            "message": message,
            "progress": progress
        }
        
        # 通知客户端
        if self.connected and self.conn_handle is not None:
            status_json = json.dumps(self.status)
            self.ble.gatts_notify(self.conn_handle, self.handle_status, status_json.encode('utf-8'))
    
    def get_status(self):
        """获取当前状态"""
        return self.status
