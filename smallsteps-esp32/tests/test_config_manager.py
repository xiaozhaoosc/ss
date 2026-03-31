"""
测试配置管理器
"""

from config_manager import ConfigManager
import json

def test_config_manager():
    """测试配置管理器"""
    print("=" * 60)
    print("测试配置管理器")
    print("=" * 60)
    
    # 创建配置管理器
    cm = ConfigManager(config_file="/test_config.json", backup_file="/test_config.bak")
    
    # 测试 1: 加载默认配置
    print("\n[Test 1] 加载默认配置")
    config = cm.load_config()
    print(f"  Configured: {config.get('configured')}")
    print(f"  WiFi SSID: {config.get('wifi', {}).get('ssid')}")
    print(f"  MQTT Broker: {config.get('mqtt', {}).get('broker')}")
    
    # 测试 2: 修改并保存配置
    print("\n[Test 2] 修改并保存配置")
    config["wifi"]["ssid"] = "TestWiFi"
    config["wifi"]["password"] = "TestPassword123"
    config["mqtt"]["device_id"] = "esp32_test_001"
    
    if cm.save_config(config):
        print("  ✅ 配置保存成功")
    else:
        print("  ❌ 配置保存失败")
    
    # 测试 3: 重新加载配置
    print("\n[Test 3] 重新加载配置")
    cm2 = ConfigManager(config_file="/test_config.json")
    config2 = cm2.load_config()
    print(f"  Configured: {config2.get('configured')}")
    print(f"  WiFi SSID: {config2.get('wifi', {}).get('ssid')}")
    print(f"  WiFi Password: {config2.get('wifi', {}).get('password')}")
    print(f"  MQTT Device ID: {config2.get('mqtt', {}).get('device_id')}")
    
    # 测试 4: 验证配置
    print("\n[Test 4] 验证配置")
    valid_config = {
        "wifi": {"ssid": "Test", "password": "123"},
        "mqtt": {"broker": "test.com", "port": 1883},
        "device": {"name": "Test"}
    }
    invalid_config = {
        "wifi": "invalid",
        "mqtt": {"port": "invalid"}
    }
    
    print(f"  Valid config: {cm.validate_config(valid_config)}")
    print(f"  Invalid config: {cm.validate_config(invalid_config)}")
    
    # 测试 5: 备份和恢复
    print("\n[Test 5] 备份和恢复")
    if cm.backup_config():
        print("  ✅ 配置备份成功")
    
    # 修改配置
    config["wifi"]["ssid"] = "ModifiedWiFi"
    cm.save_config(config)
    print(f"  修改后 SSID: {cm.get_wifi_config().get('ssid')}")
    
    # 恢复配置
    if cm.restore_config():
        print("  ✅ 配置恢复成功")
        config = cm.load_config()
        print(f"  恢复后 SSID: {config.get('wifi', {}).get('ssid')}")
    
    # 测试 6: 重置配置
    print("\n[Test 6] 重置配置")
    if cm.reset_config():
        print("  ✅ 配置重置成功")
        print(f"  Configured: {cm.is_configured()}")
    
    print("\n" + "=" * 60)
    print("✅ 测试完成")
    print("=" * 60)

if __name__ == "__main__":
    test_config_manager()
