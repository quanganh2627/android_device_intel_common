LOCAL_PATH := $(ANDROID_BUILD_TOP)

BCM_FW_PATH := device/intel/fw/wifi_bcm
BCM4334_FW_PATH := $(BCM_FW_PATH)/bcm4334
FW_TARGET_PATH := $(TARGET_OUT_ETC)/firmware/
WIFI_TARGET_PATH := $(TARGET_OUT_ETC)/wifi

include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm_4334
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=            \
    fw_bcmdhd.bin_4334_b2               \
    bcmdhd_aob.cal_4334_b2              \
    bcmdhd_victoriabay_pr1.cal_4334_b2  \
    bcmdhd_bodegabay_pr1.cal_4334_b2

LOCAL_REQUIRED_MODULES +=  \
    wifi_bcm

include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := fw_bcmdhd.bin_4334_b2
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4334_FW_PATH)/fw_bcmdhd_4334.bin
include $(BUILD_PREBUILT)

# VV AOB
include $(CLEAR_VARS)
LOCAL_MODULE := bcmdhd_aob.cal_4334_b2
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4334_FW_PATH)/bcm94334wlagb.txt
include $(BUILD_PREBUILT)

# VictoriaBay PR1
include $(CLEAR_VARS)
LOCAL_MODULE := bcmdhd_victoriabay_pr1.cal_4334_b2
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4334_FW_PATH)/bcm94334wlagb-VB-PRx.txt
include $(BUILD_PREBUILT)

# BodegaBay PR1
include $(CLEAR_VARS)
LOCAL_MODULE := bcmdhd_bodegabay_pr1.cal_4334_b2
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4334_FW_PATH)/bcm94334wlagb-BodegaBay-PRx.txt
include $(BUILD_PREBUILT)