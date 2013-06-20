LOCAL_PATH := $(ANDROID_BUILD_TOP)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    wlan_prov.bcm          \
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

##################################################
################## WiFi BCM 4334 #################
include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm_4334
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=               \
    fw_bcmdhd.bin_4334_b2               \
    bcmdhd_aob.cal_4334_b2              \
    bcmdhd_victoriabay_prx.cal_4334_b2  \
    bcmdhd_bodegabay_pr1.cal_4334_b2

LOCAL_REQUIRED_MODULES +=  \
    wifi_bcm
include $(BUILD_PHONY_PACKAGE)

##################################################
############ WiFi BCM 43340 or 43341 #############
include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm_4334x
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    fw_bcmdhd.bin_4334x_b0 \
    bcmdhd_aob.cal_4334x_b0

LOCAL_REQUIRED_MODULES +=  \
    wifi_bcm
include $(BUILD_PHONY_PACKAGE)

##################################################
################# WiFi BCM 43241 #################
include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm_43241
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=   \
    fw_bcmdhd.bin_43241_b0  \
    fw_bcmdhd.bin_43241_b4  \
    bcmdhd_aob.cal_43241_b0 \
    bcmdhd_aob.cal_43241_b4

LOCAL_REQUIRED_MODULES +=   \
    wifi_bcm
include $(BUILD_PHONY_PACKAGE)

##################################################
################## WiFi BCM 4335 #################
include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm_4335
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    fw_bcmdhd.bin_4335_b0  \
    bcmdhd_aob.cal_4335_b0

LOCAL_REQUIRED_MODULES +=  \
    wifi_bcm
include $(BUILD_PHONY_PACKAGE)

##################################################
################## WiFi BCM 4339 #################
include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm_4339
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    fw_bcmdhd.bin_4339_a0  \
    bcmdhd_aob.cal_4339_a0

LOCAL_REQUIRED_MODULES +=  \
    wifi_bcm
include $(BUILD_PHONY_PACKAGE)

##################################################
