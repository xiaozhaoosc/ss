#include "bluetooth_audio_codec.h"

#ifdef CONFIG_BT_ENABLED

#include <esp_log.h>

#define TAG "BluetoothAudioCodec"

BluetoothAudioCodec::BluetoothAudioCodec() {
    input_sample_rate_ = 16000;
    output_sample_rate_ = 16000;
    input_channels_ = 1;
    output_channels_ = 1;
}

BluetoothAudioCodec::~BluetoothAudioCodec() {}

void BluetoothAudioCodec::Start() {
    ESP_LOGI(TAG, "Bluetooth audio codec started");
    input_enabled_ = true;
    output_enabled_ = true;
}

void BluetoothAudioCodec::SetOutputVolume(int volume) {
    output_volume_ = volume;
}

void BluetoothAudioCodec::EnableInput(bool enable) {
    input_enabled_ = enable;
}

void BluetoothAudioCodec::EnableOutput(bool enable) {
    output_enabled_ = enable;
}

int BluetoothAudioCodec::Read(int16_t* dest, int samples) {
    if (!input_enabled_) return 0;
    // A2DP Source 模式下,设备不从蓝牙读取音频
    return 0;
}

int BluetoothAudioCodec::Write(const int16_t* data, int samples) {
    if (!output_enabled_) return 0;
    // 通过 A2DP Source 向耳机输出音频
    return BluetoothAudio::GetInstance().WriteAudioData(
        (const uint8_t*)data, samples * sizeof(int16_t)) / sizeof(int16_t);
}

#endif // CONFIG_BT_ENABLED
