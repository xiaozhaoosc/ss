#include "wifi_board.h"
#include "codecs/no_audio_codec.h"
#include "display/lcd_display.h"
#include "application.h"
#include "button.h"
#include "config.h"
#include "led/single_led.h"
#include "adhd/adhd_manager.h"

#include <esp_log.h>
#include <driver/spi_master.h>
#include <esp_lcd_panel_io.h>
#include <esp_lcd_panel_vendor.h>
#include <esp_lcd_panel_ops.h>

#define TAG "SmallStepsS3V1Board"

class SmallStepsS3V1Board : public WifiBoard {
private:
    esp_lcd_panel_io_handle_t panel_io_ = nullptr;
    esp_lcd_panel_handle_t panel_ = nullptr;
    Display* display_ = nullptr;
    
    Button boot_button_;
    Button button_up_;
    Button button_down_;
    Button button_ok_;
    Button button_back_;

    void InitializeSpi() {
        spi_bus_config_t buscfg = {};
        buscfg.sclk_io_num = DISPLAY_SCLK_PIN;
        buscfg.mosi_io_num = DISPLAY_MOSI_PIN;
        buscfg.miso_io_num = DISPLAY_MISO_PIN;
        buscfg.quadwp_io_num = -1;
        buscfg.quadhd_io_num = -1;
        buscfg.max_transfer_sz = DISPLAY_WIDTH * DISPLAY_HEIGHT * sizeof(uint16_t);

        // 使用 SPI2 (FSPI)
        ESP_ERROR_CHECK(spi_bus_initialize(SPI2_HOST, &buscfg, SPI_DMA_CH_AUTO));
    }

    void InitializeSt7735Display() {
        esp_lcd_panel_io_spi_config_t io_config = {};
        io_config.dc_gpio_num = DISPLAY_DC_PIN;
        io_config.cs_gpio_num = DISPLAY_CS_PIN;
        io_config.pclk_hz = 20 * 1000 * 1000; // 20MHz
        io_config.lcd_cmd_bits = 8;
        io_config.lcd_param_bits = 8;
        io_config.spi_mode = 0;
        io_config.trans_queue_depth = 10;
        
        ESP_ERROR_CHECK(esp_lcd_new_panel_io_spi((esp_lcd_spi_bus_handle_t)SPI2_HOST, &io_config, &panel_io_));

        esp_lcd_panel_dev_config_t panel_config = {};
        panel_config.reset_gpio_num = DISPLAY_RST_PIN;
        panel_config.rgb_ele_order = DISPLAY_RGB_ORDER;
        panel_config.bits_per_pixel = 16;

        // 使用 ST7789 驱动 (1.8寸屏幕，ST7735 通常兼容此驱动)
        ESP_ERROR_CHECK(esp_lcd_new_panel_st7789(panel_io_, &panel_config, &panel_));
        
        ESP_ERROR_CHECK(esp_lcd_panel_reset(panel_));
        ESP_ERROR_CHECK(esp_lcd_panel_init(panel_));
        ESP_ERROR_CHECK(esp_lcd_panel_invert_color(panel_, DISPLAY_INVERT_COLOR));
        ESP_ERROR_CHECK(esp_lcd_panel_swap_xy(panel_, DISPLAY_SWAP_XY));
        ESP_ERROR_CHECK(esp_lcd_panel_mirror(panel_, DISPLAY_MIRROR_X, DISPLAY_MIRROR_Y));

#if defined(DISPLAY_OFFSET_X) && defined(DISPLAY_OFFSET_Y)
        ESP_ERROR_CHECK(esp_lcd_panel_set_gap(panel_, DISPLAY_OFFSET_X, DISPLAY_OFFSET_Y));
#endif

        ESP_ERROR_CHECK(esp_lcd_panel_disp_on_off(panel_, true));

        // 初始化背光
        if (DISPLAY_BACKLIGHT_PIN != GPIO_NUM_NC) {
            gpio_config_t bk_gpio_config = {
                .pin_bit_mask = 1ULL << DISPLAY_BACKLIGHT_PIN,
                .mode = GPIO_MODE_OUTPUT
            };
            ESP_ERROR_CHECK(gpio_config(&bk_gpio_config));
            gpio_set_level((gpio_num_t)DISPLAY_BACKLIGHT_PIN, !DISPLAY_BACKLIGHT_OUTPUT_INVERT);
        }

        display_ = new SpiLcdDisplay(panel_io_, panel_, 
                                     DISPLAY_WIDTH, DISPLAY_HEIGHT, 
                                     DISPLAY_OFFSET_X, DISPLAY_OFFSET_Y,
                                     DISPLAY_MIRROR_X, DISPLAY_MIRROR_Y, DISPLAY_SWAP_XY);
    }

    void InitializeButtons() {
        // Boot 键保持原样
        boot_button_.OnClick([this]() {
            auto& app = Application::GetInstance();
            if (app.GetDeviceState() == kDeviceStateStarting) {
                EnterWifiConfigMode();
                return;
            }
        });

        // OK 键
        button_ok_.OnClick([this]() {
            auto& app = Application::GetInstance();
            auto& adhd = AdhdManager::GetInstance();
            
            // 手动选择蓝牙耳机
            if (app.GetDeviceState() == kDeviceStateBluetoothManualSelect) {
                app.ConnectSelectedBluetoothDevice();
                return;
            }

            // 如果正在专注于 ADHD 任务
            if (adhd.GetFocusState() == FocusState::kFocusing) {
                adhd.StopFocus();
                return;
            } 
            
            // 如果在任务列表界面（Idle 状态下我们可以默认认为可能在看任务）
            if (app.GetDeviceState() == kDeviceStateIdle) {
                adhd.StartFocus();
                return;
            }

            // 否则执行原有的语音交互
            if (app.GetDeviceState() == kDeviceStateIdle || app.GetDeviceState() == kDeviceStateSpeaking) {
                app.StartListening();
            } else if (app.GetDeviceState() == kDeviceStateListening) {
                app.StopListening();
            }
        });

        button_ok_.OnLongPress([this]() {
            auto& app = Application::GetInstance();
            if (app.GetDeviceState() == kDeviceStateIdle) {
                app.StartBluetoothScanning();
            }
        });

        // UP 键
        button_up_.OnClick([this]() {
            auto& app = Application::GetInstance();
            if (app.GetDeviceState() == kDeviceStateBluetoothManualSelect) {
                app.SelectPreviousBluetoothDevice();
                return;
            }

            auto& adhd = AdhdManager::GetInstance();
            if (adhd.GetFocusState() == FocusState::kIdle) {
                int idx = adhd.GetCurrentTaskIndex();
                if (idx > 0) adhd.SetCurrentTaskIndex(idx - 1);
                // 刷新 UI
                GetDisplay()->SetAdhdUiVisible(true);
                return;
            }

            auto codec = GetAudioCodec();
            auto volume = codec->output_volume() + 10;
            if (volume > 100) volume = 100;
            codec->SetOutputVolume(volume);
            GetDisplay()->ShowNotification("Volume: " + std::to_string(volume));
        });

        // DOWN 键
        button_down_.OnClick([this]() {
            auto& app = Application::GetInstance();
            if (app.GetDeviceState() == kDeviceStateBluetoothManualSelect) {
                app.SelectNextBluetoothDevice();
                return;
            }

            auto& adhd = AdhdManager::GetInstance();
            if (adhd.GetFocusState() == FocusState::kIdle) {
                int idx = adhd.GetCurrentTaskIndex();
                if (idx < (int)adhd.GetTasks().size() - 1) adhd.SetCurrentTaskIndex(idx + 1);
                // 刷新 UI
                GetDisplay()->SetAdhdUiVisible(true);
                return;
            }

            auto codec = GetAudioCodec();
            auto volume = codec->output_volume() - 10;
            if (volume < 0) volume = 0;
            codec->SetOutputVolume(volume);
            GetDisplay()->ShowNotification("Volume: " + std::to_string(volume));
        });

        // BACK 键
        button_back_.OnClick([this]() {
             auto& app = Application::GetInstance();
             if (app.GetDeviceState() == kDeviceStateBluetoothManualSelect) {
                 app.SetDeviceState(kDeviceStateIdle);
                 return;
             }

             auto& adhd = AdhdManager::GetInstance();
             if (adhd.GetFocusState() == FocusState::kFocusing) {
                 adhd.StopFocus();
                 return;
             }
             
             app.StopListening();
        });
    }

public:
    SmallStepsS3V1Board() :
        boot_button_(BOOT_BUTTON_GPIO),
        button_up_(BUTTON_UP_GPIO),
        button_down_(BUTTON_DOWN_GPIO),
        button_ok_(BUTTON_OK_GPIO, false, 3000), // 3秒长按引发事件
        button_back_(BUTTON_BACK_GPIO) {
        
        InitializeSpi();
        InitializeSt7735Display();
        InitializeButtons();
    }

    virtual Led* GetLed() override {
        static SingleLed led(BUILTIN_LED_GPIO);
        return &led;
    }

    virtual AudioCodec* GetAudioCodec() override {
#ifdef AUDIO_I2S_METHOD_SIMPLEX
        // 使用重载构造函数，为麦克风和扬声器分别指定 I2S 槽位
        // INMP441 的 L/R 引脚接地时使用 RIGHT 声道
        static NoAudioCodecSimplex audio_codec(
            AUDIO_INPUT_SAMPLE_RATE, AUDIO_OUTPUT_SAMPLE_RATE,
            AUDIO_I2S_SPK_GPIO_BCLK, AUDIO_I2S_SPK_GPIO_LRCK, AUDIO_I2S_SPK_GPIO_DOUT, 
            I2S_STD_SLOT_LEFT,  // 扬声器使用 LEFT 声道
            AUDIO_I2S_MIC_GPIO_SCK, AUDIO_I2S_MIC_GPIO_WS, AUDIO_I2S_MIC_GPIO_DIN,
            I2S_STD_SLOT_LEFT   // ✅ 硬件 L/R 已接 VDD,使用 LEFT 声道
        );
#else
        static NoAudioCodecDuplex audio_codec(AUDIO_INPUT_SAMPLE_RATE, AUDIO_OUTPUT_SAMPLE_RATE,
            AUDIO_I2S_GPIO_BCLK, AUDIO_I2S_GPIO_WS, AUDIO_I2S_GPIO_DOUT, AUDIO_I2S_GPIO_DIN);
#endif
        return &audio_codec;
    }

    virtual Display* GetDisplay() override {
        return display_;
    }
};

DECLARE_BOARD(SmallStepsS3V1Board);
