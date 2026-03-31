#ifndef BLUETOOTH_AUDIO_CODEC_H
#define BLUETOOTH_AUDIO_CODEC_H

#include "../audio_codec.h"
#include "bluetooth_audio.h"

class BluetoothAudioCodec : public AudioCodec {
public:
    BluetoothAudioCodec();
    virtual ~BluetoothAudioCodec();

    virtual void SetOutputVolume(int volume) override;
    virtual void EnableInput(bool enable) override;
    virtual void EnableOutput(bool enable) override;

    virtual void Start() override;

protected:
    virtual int Read(int16_t* dest, int samples) override;
    virtual int Write(const int16_t* data, int samples) override;
};

#endif // BLUETOOTH_AUDIO_CODEC_H
