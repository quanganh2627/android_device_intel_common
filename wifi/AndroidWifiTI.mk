LOCAL_PATH := $(ANDROID_BUILD_TOP)

FW_PATH := device/intel/fw/wifi
TIWLAN_PATH := $(FW_PATH)/tiwl128x/wlan
FW_TARGET_PATH := $(TARGET_OUT_ETC)/firmware/ti-connectivity

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := wifi_ti
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := \
    netd.ti               \
    wpa_supplicant.ti     \
    hostapd_bin.ti        \
    wlan_prov             \
    calibrator            \
    wl128x-fw-4-sr.bin    \
    wl128x-fw-4-mr.bin    \
    wl128x-fw-4-plt.bin   \
    crda                  \
    regulatory.bin        \
    linville.key.pub.pem  \
    intel.key.pub.pem

# TO DO: To be removed from user builds
LOCAL_REQUIRED_MODULES += \
    wpa_cli.ti            \
    hostapd_cli.ti

# WARNING: To be kept as the last required module.
LOCAL_REQUIRED_MODULES += \
    wifi_common

include $(BUILD_PHONY_PACKAGE)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := wl128x-fw-4-sr.bin
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(TIWLAN_PATH)/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := wl128x-fw-4-mr.bin
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(TIWLAN_PATH)/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := wl128x-fw-4-plt.bin
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(TIWLAN_PATH)/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)
