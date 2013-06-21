LOCAL_PATH := $(ANDROID_BUILD_TOP)

BCM_FW_PATH := vendor/intel/fw/wifi_bcm
BCM4334X_FW_PATH := $(BCM_FW_PATH)/bcm4334x

FW_TARGET_PATH := $(TARGET_OUT_ETC)/firmware/
WIFI_TARGET_PATH := $(TARGET_OUT_ETC)/wifi

include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm_4334x
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    fw_bcmdhd.bin_4334x_b0 \
    bcmdhd_aob.cal_4334x_b0

LOCAL_REQUIRED_MODULES +=  \
    wifi_bcm

include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := fw_bcmdhd.bin_4334x_b0
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)

LOCAL_SRC_FILES := $(BCM4334X_FW_PATH)/$(LOCAL_MODULE)

include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := bcmdhd_aob.cal_4334x_b0
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4334X_FW_PATH)/bcm94334xwlagb.txt
include $(BUILD_PREBUILT)
