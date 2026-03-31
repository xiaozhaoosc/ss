"""
配置管理器模块
负责配置文件的加载、保存、验证、加密等功能
"""

import json
import os
import time
import ubinascii

class ConfigManager:
    """配置管理器"""
    
    DEFAULT_CONFIG = {
        "version": "1.0.0",
        "wifi": {
            "ssid": "",
            "password": ""
        },
        "mqtt": {
            "broker": "mqtt.smallsteps.com",
            "port": 1883,
            "user": "",
            "password": "",
            "device_id": "esp32_001"
        },
        "device": {
            "name": "小步终端",
            "description": "ADHD儿童行为习惯辅助终端"
        },
        "configured": False,
        "last_update": 0
    }
    
    def __init__(self, config_file="/config.json", backup_file="/config.bak"):
        """
        初始化配置管理器
        
        Args:
            config_file: 配置文件路径
            backup_file: 备份文件路径
        """
        self.config_file = config_file
        self.backup_file = backup_file
        self.config = None
        print("[ConfigManager] Initialized")
    
    def load_config(self):
        """
        加载配置文件
        
        Returns:
            dict: 配置字典，如果加载失败则返回默认配置
        """
        try:
            # 尝试加载配置文件
            with open(self.config_file, 'r') as f:
                config = json.load(f)
            
            # 验证配置
            if self.validate_config(config):
                # 解密密码
                if config.get("wifi", {}).get("password"):
                    config["wifi"]["password"] = self._decrypt(config["wifi"]["password"])
                if config.get("mqtt", {}).get("password"):
                    config["mqtt"]["password"] = self._decrypt(config["mqtt"]["password"])
                
                self.config = config
                print(f"[ConfigManager] Config loaded from {self.config_file}")
                return config
            else:
                print("[ConfigManager] Config validation failed, using default")
                return self._load_default()
                
        except OSError:
            print(f"[ConfigManager] Config file not found: {self.config_file}")
            # 尝试从备份恢复
            if self._restore_from_backup():
                return self.load_config()
            else:
                return self._load_default()
        except Exception as e:
            print(f"[ConfigManager] Load failed: {e}")
            return self._load_default()
    
    def save_config(self, config):
        """
        保存配置文件
        
        Args:
            config: 配置字典
        
        Returns:
            bool: 保存是否成功
        """
        try:
            # 验证配置
            if not self.validate_config(config):
                print("[ConfigManager] Invalid config, cannot save")
                return False
            
            # 备份当前配置
            self.backup_config()
            
            # 加密密码
            save_config = config.copy()
            if save_config.get("wifi", {}).get("password"):
                save_config["wifi"]["password"] = self._encrypt(save_config["wifi"]["password"])
            if save_config.get("mqtt", {}).get("password"):
                save_config["mqtt"]["password"] = self._encrypt(save_config["mqtt"]["password"])
            
            # 更新时间戳
            save_config["last_update"] = int(time.time())
            save_config["configured"] = True
            
            # 保存到文件
            with open(self.config_file, 'w') as f:
                json.dump(save_config, f)
            
            self.config = config
            print(f"[ConfigManager] Config saved to {self.config_file}")
            return True
            
        except Exception as e:
            print(f"[ConfigManager] Save failed: {e}")
            return False
    
    def validate_config(self, config):
        """
        验证配置有效性
        
        Args:
            config: 配置字典
        
        Returns:
            bool: 配置是否有效
        """
        try:
            # 检查必需字段
            if not isinstance(config, dict):
                return False
            
            # 检查 WiFi 配置
            wifi = config.get("wifi", {})
            if not isinstance(wifi, dict):
                return False
            
            # 检查 MQTT 配置
            mqtt = config.get("mqtt", {})
            if not isinstance(mqtt, dict):
                return False
            
            # 检查 MQTT 端口
            if "port" in mqtt:
                port = mqtt["port"]
                if not isinstance(port, int) or port < 1 or port > 65535:
                    return False
            
            # 检查设备配置
            device = config.get("device", {})
            if not isinstance(device, dict):
                return False
            
            return True
            
        except Exception as e:
            print(f"[ConfigManager] Validation error: {e}")
            return False
    
    def reset_config(self):
        """
        重置配置为默认值
        
        Returns:
            bool: 重置是否成功
        """
        try:
            # 备份当前配置
            self.backup_config()
            
            # 删除配置文件
            try:
                os.remove(self.config_file)
            except:
                pass
            
            # 加载默认配置
            self.config = self._load_default()
            print("[ConfigManager] Config reset to default")
            return True
            
        except Exception as e:
            print(f"[ConfigManager] Reset failed: {e}")
            return False
    
    def backup_config(self):
        """
        备份当前配置
        
        Returns:
            bool: 备份是否成功
        """
        try:
            # 检查配置文件是否存在
            if not self._file_exists(self.config_file):
                return False
            
            # 复制到备份文件
            with open(self.config_file, 'r') as src:
                content = src.read()
            
            with open(self.backup_file, 'w') as dst:
                dst.write(content)
            
            print(f"[ConfigManager] Config backed up to {self.backup_file}")
            return True
            
        except Exception as e:
            print(f"[ConfigManager] Backup failed: {e}")
            return False
    
    def restore_config(self):
        """
        从备份恢复配置
        
        Returns:
            bool: 恢复是否成功
        """
        return self._restore_from_backup()
    
    def is_configured(self):
        """
        检查设备是否已配置
        
        Returns:
            bool: 是否已配置
        """
        if self.config is None:
            self.load_config()
        
        return self.config.get("configured", False)
    
    def get_wifi_config(self):
        """
        获取 WiFi 配置
        
        Returns:
            dict: WiFi 配置
        """
        if self.config is None:
            self.load_config()
        
        return self.config.get("wifi", {})
    
    def get_mqtt_config(self):
        """
        获取 MQTT 配置
        
        Returns:
            dict: MQTT 配置
        """
        if self.config is None:
            self.load_config()
        
        return self.config.get("mqtt", {})
    
    def get_device_config(self):
        """
        获取设备配置
        
        Returns:
            dict: 设备配置
        """
        if self.config is None:
            self.load_config()
        
        return self.config.get("device", {})
    
    def _load_default(self):
        """加载默认配置"""
        self.config = self.DEFAULT_CONFIG.copy()
        return self.config
    
    def _restore_from_backup(self):
        """从备份恢复"""
        try:
            if not self._file_exists(self.backup_file):
                return False
            
            # 复制备份到配置文件
            with open(self.backup_file, 'r') as src:
                content = src.read()
            
            with open(self.config_file, 'w') as dst:
                dst.write(content)
            
            print(f"[ConfigManager] Config restored from {self.backup_file}")
            return True
            
        except Exception as e:
            print(f"[ConfigManager] Restore failed: {e}")
            return False
    
    def _file_exists(self, path):
        """检查文件是否存在"""
        try:
            os.stat(path)
            return True
        except:
            return False
    
    def _encrypt(self, text):
        """
        简单加密（Base64 编码）
        
        Args:
            text: 明文
        
        Returns:
            str: 密文
        """
        try:
            return ubinascii.b2a_base64(text.encode()).decode().strip()
        except:
            return text
    
    def _decrypt(self, text):
        """
        简单解密（Base64 解码）
        
        Args:
            text: 密文
        
        Returns:
            str: 明文
        """
        try:
            return ubinascii.a2b_base64(text.encode()).decode()
        except:
            return text
