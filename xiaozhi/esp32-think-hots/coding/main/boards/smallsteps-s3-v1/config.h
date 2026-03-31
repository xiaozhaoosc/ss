#ifndef _BOARD_CONFIG_H_
#define _BOARD_CONFIG_H_

#include <driver/gpio.h>

// 音频采样率
#define AUDIO_INPUT_SAMPLE_RATE  16000
#define AUDIO_OUTPUT_SAMPLE_RATE 16000

// I2S 配置 (Simplex 模式)
#define AUDIO_I2S_METHOD_SIMPLEX

#ifdef AUDIO_I2S_METHOD_SIMPLEX

// 麦克风 (INMP441)
#define AUDIO_I2S_MIC_GPIO_WS   GPIO_NUM_42
#define AUDIO_I2S_MIC_GPIO_SCK  GPIO_NUM_41
#define AUDIO_I2S_MIC_GPIO_DIN  GPIO_NUM_2  // SD

// 扬声器 (MAX98357A) - 避开 Octal Flash 冲突
#define AUDIO_I2S_SPK_GPIO_DOUT GPIO_NUM_16 // DIN
#define AUDIO_I2S_SPK_GPIO_BCLK GPIO_NUM_8  // BCLK
#define AUDIO_I2S_SPK_GPIO_LRCK GPIO_NUM_21 // LRC

#else
// 如果需要 Duplex 模式，请自行修改引脚定义
#endif

// 按键定义
#define BOOT_BUTTON_GPIO        GPIO_NUM_0  // 开发板自带 Boot
#define TOUCH_BUTTON_GPIO       GPIO_NUM_NC // 不使用触摸
#define BUTTON_UP_GPIO          GPIO_NUM_4
#define BUTTON_DOWN_GPIO        GPIO_NUM_5
#define BUTTON_OK_GPIO          GPIO_NUM_6
#define BUTTON_BACK_GPIO        GPIO_NUM_7

// 屏幕定义 (ST7735 / ST7789)
// 使用 SPI2 (FSPI)
#define DISPLAY_SCLK_PIN        GPIO_NUM_12 // SCK
#define DISPLAY_MOSI_PIN        GPIO_NUM_11 // MOSI
#define DISPLAY_MISO_PIN        GPIO_NUM_NC // 不用 MISO
#define DISPLAY_DC_PIN          GPIO_NUM_9  // DC
#define DISPLAY_RST_PIN         GPIO_NUM_46 // RES
#define DISPLAY_CS_PIN          GPIO_NUM_10 // CS
#define DISPLAY_BACKLIGHT_PIN   GPIO_NUM_3  // BLK
#define DISPLAY_BACKLIGHT_OUTPUT_INVERT false 

// 屏幕参数 (ST7735 128x160 常见配置)
#define DISPLAY_WIDTH   128
#define DISPLAY_HEIGHT  160
#define DISPLAY_MIRROR_X true
#define DISPLAY_MIRROR_Y true
#define DISPLAY_SWAP_XY false
#define DISPLAY_INVERT_COLOR false
#define DISPLAY_RGB_ORDER LCD_RGB_ELEMENT_ORDER_RGB
#define DISPLAY_OFFSET_X  0
#define DISPLAY_OFFSET_Y  0

// RGB 灯环 (WS2812)
#define BUILTIN_LED_GPIO        GPIO_NUM_15 

// 震动马达
#define MOTOR_GPIO              GPIO_NUM_1

#endif // _BOARD_CONFIG_H_
