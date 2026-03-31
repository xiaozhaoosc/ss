#include "bluetooth_audio.h"
#include <esp_log.h>
#include <esp_bt.h>
#include <esp_bt_main.h>
#include <esp_bt_device.h>
#include <esp_gap_bt_api.h>
#include <esp_a2dp_api.h>
#include <esp_hf_client_api.h>
#include <nvs_flash.h>
#include <cstring>

#define TAG "BluetoothAudio"

static void bt_gap_cb(esp_bt_gap_cb_event_t event, esp_bt_gap_cb_param_t *param) {
    BluetoothAudio::GetInstance().HandleGapEvent(event, param);
}

static void bt_a2d_cb(esp_a2d_cb_event_t event, esp_a2d_cb_param_t *param) {
    BluetoothAudio::GetInstance().HandleA2dEvent(event, param);
}

static int32_t bt_a2d_data_cb(uint8_t *data, int32_t len) {
    // A2DP Source data callback is usually handled by raw_write or a buffer
    return 0; 
}

BluetoothAudio::BluetoothAudio() {}
BluetoothAudio::~BluetoothAudio() {}

BluetoothAudio& BluetoothAudio::GetInstance() {
    static BluetoothAudio instance;
    return instance;
}

void BluetoothAudio::HandleGapEvent(esp_bt_gap_cb_event_t event, esp_bt_gap_cb_param_t *param) {
    switch (event) {
        case ESP_BT_GAP_DISC_RES_EVT: {
            BluetoothDevice dev;
            char name[ESP_BT_GAP_MAX_BDNAME_LEN + 1];
            
            // 简单解析设备名
            for (int i = 0; i < param->disc_res.num_prop; i++) {
                if (param->disc_res.prop[i].type == ESP_BT_GAP_DEV_PROP_BDNAME) {
                    int len = param->disc_res.prop[i].len;
                    if (len > ESP_BT_GAP_MAX_BDNAME_LEN) len = ESP_BT_GAP_MAX_BDNAME_LEN;
                    memcpy(name, param->disc_res.prop[i].val, len);
                    name[len] = '\0';
                    dev.name = name;
                } else if (param->disc_res.prop[i].type == ESP_BT_GAP_DEV_PROP_RSSI) {
                    dev.rssi = *(int8_t *)(param->disc_res.prop[i].val);
                }
            }
            
            if (!dev.name.empty()) {
                memcpy(dev.address, param->disc_res.bda, ESP_BD_ADDR_LEN);
                discovered_devices_[dev.name] = dev;
                ESP_LOGI(TAG, "Discovered: %s (RSSI: %d)", dev.name.c_str(), dev.rssi);
                
                if (discovery_callback_) {
                    std::vector<BluetoothDevice> devices;
                    for (auto const& [name, d] : discovered_devices_) devices.push_back(d);
                    discovery_callback_(devices);
                }
            }
            break;
        }
        case ESP_BT_GAP_DISC_CMPL_EVT:
            ESP_LOGI(TAG, "Discovery completed");
            if (discovery_completed_callback_) {
                discovery_completed_callback_();
            }
            break;
        default:
            break;
    }
}

void BluetoothAudio::HandleA2dEvent(esp_a2d_cb_event_t event, esp_a2d_cb_param_t *param) {
    switch (event) {
        case ESP_A2D_CONNECTION_STATE_EVT:
            if (param->conn_stat.state == ESP_A2D_CONNECTION_STATE_CONNECTED) {
                ESP_LOGI(TAG, "A2DP Source connected");
                connected_ = true;
                if (connection_callback_) connection_callback_(true);
            } else if (param->conn_stat.state == ESP_A2D_CONNECTION_STATE_DISCONNECTED) {
                ESP_LOGI(TAG, "A2DP Source disconnected");
                connected_ = false;
                if (connection_callback_) connection_callback_(false);
            }
            break;
        case ESP_A2D_AUDIO_STATE_EVT:
            if (param->audio_stat.state == ESP_A2D_AUDIO_STATE_STARTED) {
                ESP_LOGI(TAG, "A2DP Audio started");
            }
            break;
        default:
            break;
    }
}

void BluetoothAudio::Initialize(const std::string& device_name) {
    device_name_ = device_name;
    StartStack();
}

void BluetoothAudio::SetConnectionCallback(BluetoothConnectionCallback callback) {
    connection_callback_ = callback;
}

void BluetoothAudio::StartStack() {
    esp_bt_controller_config_t bt_cfg = BT_CONTROLLER_INIT_CONFIG_DEFAULT();
    esp_bt_controller_init(&bt_cfg);
    esp_bt_controller_enable(ESP_BT_MODE_CLASSIC_BT);
    esp_bluedroid_init();
    esp_bluedroid_enable();

    esp_bt_dev_set_device_name(device_name_.c_str());

    esp_a2d_source_init();
    esp_a2d_register_callback(bt_a2d_cb);
    esp_a2d_source_register_data_callback(bt_a2d_data_cb);

    esp_bt_gap_register_callback(bt_gap_cb);
    
    // 设置扫描参数
    esp_bt_gap_set_scan_mode(ESP_BT_NON_CONNECTABLE, ESP_BT_NON_DISCOVERABLE);
    ESP_LOGI(TAG, "Bluetooth stack started as A2DP Source (%s)", device_name_.c_str());
}

void BluetoothAudio::SetDiscoveryCompletedCallback(BluetoothDiscoveryCompletedCallback callback) {
    discovery_completed_callback_ = callback;
}

void BluetoothAudio::StartDiscovery() {
    discovered_devices_.clear();
    esp_bt_gap_start_discovery(ESP_BT_INQ_MODE_GENERAL_INQUIRY, 10, 0);
    ESP_LOGI(TAG, "Started discovery...");
}

void BluetoothAudio::StopDiscovery() {
    esp_bt_gap_cancel_discovery();
}

void BluetoothAudio::Connect(esp_bd_addr_t address) {
    esp_a2d_source_connect(address);
    ESP_LOGI(TAG, "Connecting to device...");
}

void BluetoothAudio::ClearDiscoveredDevices() {
    discovered_devices_.clear();
}

bool BluetoothAudio::GetBestDevice(BluetoothDevice& device) {
    if (discovered_devices_.empty()) {
        return false;
    }

    int max_rssi = -127;
    const BluetoothDevice* best = nullptr;

    for (auto const& [name, dev] : discovered_devices_) {
        if (dev.rssi > max_rssi) {
            max_rssi = dev.rssi;
            best = &dev;
        }
    }

    if (best) {
        device = *best;
        return true;
    }
    return false;
}

int BluetoothAudio::WriteAudioData(const uint8_t* data, int len) {
    if (!connected_) return 0;
    // A2DP Source 原始数据写入
    esp_a2d_source_data_raw_write((uint8_t*)data, len);
    return len;
}

// Removed HFP related functions ReadVoiceData, SetDiscoverable, WriteVoiceData
