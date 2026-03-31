#include "bluetooth_audio_codec.h"
#include <esp_log.h>

#define TAG "BluetoothAudioCodec"

BluetoothAudioCodec::BluetoothAudioCodec() {
    input_sample_rate_ = 16000;
    output_sample_rate_ = 16000; // HFP 通常是 8k 或 16k (mSBC)
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
    // TODO: 调用 HFP/A2DP 的音量设置 API
}

void BluetoothAudioCodec::EnableInput(bool enable) {
    input_enabled_ = enable;
}

void BluetoothAudioCodec::EnableOutput(bool enable) {
    output_enabled_ = enable;
}

int BluetoothAudioCodec::Read(int16_t* dest, int samples) {
    if (!input_enabled_) return 0;
    return BluetoothAudio::GetInstance().ReadVoiceData((uint8_t*)dest, samples * sizeof(int16_t)) / sizeof(int16_t);
}

int BluetoothAudioCodec::Write(const int16_t* data, int samples) {
    if (!output_enabled_) return 0;
    // 注意：A2DP Sink 模式下，设备是被动接收手机音频
    // 如果是想把设备的语音助手的声音传给手机播放，目前通用的做法是 HFP
    return BluetoothAudio::GetInstance().WriteVoiceData((const uint8_t*)data, samples * sizeof(int16_t)) / sizeof(int16_t);
}
