
# TI12xx serie wifi specific
ifeq ($(strip $(BOARD_HAVE_TI12XX)),true)
BOARD_WLAN_DEVICE              := wl12xx-compat
BOARD_WPA_SUPPLICANT_DRIVER    := NL80211
WPA_SUPPLICANT_VERSION         := VER_0_8_X
ADDITIONAL_DEFAULT_PROPERTIES  += wifi.interface=wlan0:0

ifeq ($(strip $(INTEL_WIDI)),true)
ADDITIONAL_DEFAULT_PROPERTIES  += widi.interface=wlan0

ifeq ($(strip $(INTEL_WIFI_WIDI_MR)),true)
ADDITIONAL_DEFAULT_PROPERTIES  += ro.wifi.widi.mr=true
else
ADDITIONAL_DEFAULT_PROPERTIES  += ro.wifi.widi.mr=false
endif # INTEL_WIFI_WIDI_MR

endif # INTEL_WIDI

endif # BOARD_HAVE_TI12XX

# BCM43xx serie wifi specific
ifeq ($(strip $(BOARD_HAVE_BCM43XX)),true)
BOARD_WLAN_DEVICE              := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER    := NL80211
WPA_SUPPLICANT_VERSION         := VER_0_8_X
ADDITIONAL_DEFAULT_PROPERTIES  += wifi.interface=wlan0

BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
WIFI_DRIVER_MODULE_ARG      := "firmware_path=/system/etc/firmware/fw_bcmdhd.bin nvram_path=/system/etc/wifi/bcmdhd.cal"
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_MODULE_PATH     := "/lib/modules/bcmdhd.ko"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_MODULE_NAME     := bcmdhd
endif
