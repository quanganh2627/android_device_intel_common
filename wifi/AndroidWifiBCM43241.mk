LOCAL_PATH := $(ANDROID_BUILD_TOP)

BCM_FW_PATH := vendor/intel/fw/wifi_bcm
BCM43241_FW_PATH := $(BCM_FW_PATH)/bcm43241

FW_TARGET_PATH := $(TARGET_OUT_ETC)/firmware/
WIFI_TARGET_PATH := $(TARGET_OUT_ETC)/wifi

include $(CLEAR_VARS)
LOCAL_MODULE := wifi_bcm_43241
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    fw_bcmdhd.bin_43241_b0 \
    fw_bcmdhd.bin_43241_b4          \
    bcmdhd_aob.cal_43241_b0 \
    bcmdhd_aob.cal_43241_b4

LOCAL_REQUIRED_MODULES +=  \
    wifi_bcm

include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := fw_bcmdhd.bin_43241_b0
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)

ifneq (,$(filter fw_bcmdhd_4324_B4.bin,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
LOCAL_SRC_FILES := $(BCM43241_FW_PATH)/fw_bcmdhd_43241_B4.bin
else
LOCAL_SRC_FILES := $(BCM43241_FW_PATH)/fw_bcmdhd_43241.bin
endif

include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := fw_bcmdhd.bin_43241_b4
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM43241_FW_PATH)/fw_bcmdhd_43241_B4.bin
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := bcmdhd_aob.cal_43241_b0
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM43241_FW_PATH)/bcm943241wlagb.txt
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := bcmdhd_aob.cal_43241_b4
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM43241_FW_PATH)/bcm943241wlagb_B4.txt
include $(BUILD_PREBUILT)
