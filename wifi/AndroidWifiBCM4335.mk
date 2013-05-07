LOCAL_PATH := $(ANDROID_BUILD_TOP)

BCM_FW_PATH := device/intel/fw/wifi_bcm
BCM4335_FW_PATH := $(BCM_FW_PATH)/bcm4335
BCM4339_FW_PATH := $(BCM_FW_PATH)/bcm4339
FW_TARGET_PATH := $(TARGET_OUT_ETC)/firmware/
WIFI_TARGET_PATH := $(TARGET_OUT_ETC)/wifi

include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm_4335
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    fw_bcmdhd.bin_4335_b0          \
    fw_bcmdhd.bin_4339_a0          \
    bcmdhd_aob.cal_4335_b0 \
    bcmdhd_aob.cal_4339_a0

LOCAL_REQUIRED_MODULES +=  \
    wifi_bcm

include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := fw_bcmdhd.bin_4335_b0
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4335_FW_PATH)/fw_bcmdhd_4335.bin
include $(BUILD_PREBUILT)

##################################################

# nvram for Merrifield phone (4) / PHONE_SB_PRO (0) / SilverRidge VV FAB A (0)
include $(CLEAR_VARS)
LOCAL_MODULE := bcmdhd_aob.cal_4335_b0
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4335_FW_PATH)/bcm94335wlagb.txt
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := fw_bcmdhd.bin_4339_a0
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4339_FW_PATH)/fw_bcmdhd_4339.bin
include $(BUILD_PREBUILT)

##################################################

# nvram for Merrifield phone (4) / PHONE_SB_PRO (0) / SilverRidge VV FAB A (0)
include $(CLEAR_VARS)
LOCAL_MODULE := bcmdhd_aob.cal_4339_a0
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4339_FW_PATH)/bcm94339wlagb.txt
include $(BUILD_PREBUILT)
