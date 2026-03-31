#ifndef BLUETOOTH_AUDIO_H
#define BLUETOOTH_AUDIO_H

#include <string>
#include <functional>
#include <vector>
#include <map>
#include <esp_gap_bt_api.h>

struct BluetoothDevice {
    std::string name;
    esp_bd_addr_t address;
    int rssi;
};

typedef std::function<void(bool connected)> BluetoothConnectionCallback;
typedef std::function<void(const std::vector<BluetoothDevice>& devices)> BluetoothDiscoveryCallback;
typedef std::function<void()> BluetoothDiscoveryCompletedCallback;

class BluetoothAudio {
public:
    static BluetoothAudio& GetInstance();

    void Initialize(const std::string& device_name);
    void SetConnectionCallback(BluetoothConnectionCallback callback);
    void SetDiscoveryCallback(BluetoothDiscoveryCallback callback);
    void SetDiscoveryCompletedCallback(BluetoothDiscoveryCompletedCallback callback);
    
    void StartDiscovery();
    void StopDiscovery();
    void Connect(esp_bd_addr_t address);
    
    void ClearDiscoveredDevices();
    bool GetBestDevice(BluetoothDevice& device);
    const std::map<std::string, BluetoothDevice>& GetDiscoveredDevices() const { return discovered_devices_; }
    
    bool IsConnected() const { return connected_; }

    // 向 A2DP Source 写入音频数据 (播放至耳机)
    int WriteAudioData(const uint8_t* data, int len);

private:
    BluetoothAudio();
    ~BluetoothAudio();
    
    std::string device_name_;
    bool connected_ = false;
    BluetoothConnectionCallback connection_callback_;
    BluetoothDiscoveryCallback discovery_callback_;
    BluetoothDiscoveryCompletedCallback discovery_completed_callback_;
    std::map<std::string, BluetoothDevice> discovered_devices_;

    void StartStack();
    void HandleGapEvent(esp_bt_gap_cb_event_t event, esp_bt_gap_cb_param_t *param);
    void HandleA2dEvent(esp_a2d_cb_event_t event, esp_a2d_cb_param_t *param);
};

#endif // BLUETOOTH_AUDIO_H
