COMMON := vendor/intel/common

include $(COMMON)/ComboChipVendor.mk

BOARD_WPA_SUPPLICANT_DRIVER    := NL80211

ifeq (ti,$(findstring ti,$(COMBO_CHIP_VENDOR)))
BOARD_WLAN_DEVICE := wl12xx-compat
endif

ifeq (bcm,$(findstring bcm,$(COMBO_CHIP_VENDOR)))
BOARD_WLAN_DEVICE := bcmdhd

BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
ifeq (bcm4334,$(COMBO_CHIP))
WIFI_DRIVER_MODULE_ARG      := "firmware_path=/system/etc/firmware/fw_bcmdhd_4334.bin nvram_path=/system/etc/wifi/bcmdhd_4334.cal"
WIFI_DRIVER_FW_PATH_STA     := "/system/etc/firmware/fw_bcmdhd_4334.bin"
WIFI_DRIVER_FW_PATH_P2P     := "/system/etc/firmware/fw_bcmdhd_4334.bin"
WIFI_DRIVER_FW_PATH_AP      := "/system/etc/firmware/fw_bcmdhd_4334_apsta.bin"
endif
ifeq (bcm4335,$(COMBO_CHIP))
WIFI_DRIVER_MODULE_ARG      := "firmware_path=/system/etc/firmware/fw_bcmdhd_4335.bin nvram_path=/system/etc/wifi/bcmdhd_4335.cal"
WIFI_DRIVER_FW_PATH_STA     := "/system/etc/firmware/fw_bcmdhd_4335.bin"
WIFI_DRIVER_FW_PATH_P2P     := "/system/etc/firmware/fw_bcmdhd_4335.bin"
WIFI_DRIVER_FW_PATH_AP      := "/system/etc/firmware/fw_bcmdhd_4335_apsta.bin"
endif

endif

