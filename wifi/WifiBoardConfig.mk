COMMON := device/intel/common

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

# These hardcoded path are also defined in
# device/intel/common/wifi/bcm_specific/load_bcmdriver so make sure to change
# at both places with one patch (libhardware_legacy makes use of these
# defines).
WIFI_DRIVER_43241_FW_PATH_STA     := "/system/etc/firmware/fw_bcmdhd_43241.bin"
WIFI_DRIVER_43241_FW_PATH_P2P     := "/system/etc/firmware/fw_bcmdhd_43241.bin"
WIFI_DRIVER_43241_FW_PATH_AP      := "/system/etc/firmware/fw_bcmdhd_43241_apsta.bin"

WIFI_DRIVER_4334_FW_PATH_STA     := "/system/etc/firmware/fw_bcmdhd_4334.bin"
WIFI_DRIVER_4334_FW_PATH_P2P     := "/system/etc/firmware/fw_bcmdhd_4334.bin"
WIFI_DRIVER_4334_FW_PATH_AP      := "/system/etc/firmware/fw_bcmdhd_4334_apsta.bin"

WIFI_DRIVER_4335_FW_PATH_STA     := "/system/etc/firmware/fw_bcmdhd_4335.bin"
WIFI_DRIVER_4335_FW_PATH_P2P     := "/system/etc/firmware/fw_bcmdhd_4335.bin"
WIFI_DRIVER_4335_FW_PATH_AP      := "/system/etc/firmware/fw_bcmdhd_4335_apsta.bin"

endif

