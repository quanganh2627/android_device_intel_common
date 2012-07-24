LOCAL_PATH := $(ANDROID_BUILD_TOP)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    netd.bcm               \
    wpa_supplicant.bcm     \
    hostapd.bcm            \
    lib_driver_cmd_bcmdhd

#We don't want following packages to be automatically compiled
LOCAL_REQUIRED_MODULES +=   \
     wpa_cli.bcm            \
     hostapd_cli.bcm        \
#    wlx                    \
#    dhdutil

# WARNING: To be kept as the last required module.
LOCAL_REQUIRED_MODULES +=  \
    wifi_common

include $(BUILD_PHONY_PACKAGE)
