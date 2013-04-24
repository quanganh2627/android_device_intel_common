LOCAL_PATH := $(ANDROID_BUILD_TOP)

COMMON := device/intel/common
BT_COMMON := $(COMMON)/bluetooth
LIBBT_CONF_PATH := device/common/libbt/conf/intel

include $(COMMON)/ComboChipVendor.mk

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := bt_common
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := \
	bd_prov \
	init.bt.rc \
	init.bt.vendor.rc \
	libbt-vendor \
	bt_vendor.conf

include $(BUILD_PHONY_PACKAGE)

#################################################

include $(CLEAR_VARS)
LOCAL_MODULE := init.bt.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
LOCAL_SRC_FILES := $(BT_COMMON)/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := init.bt.vendor.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
LOCAL_SRC_FILES := $(BT_COMMON)/init.bt.$(COMBO_CHIP_VENDOR).rc
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := bt_vendor.conf
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/bluetooth
LOCAL_SRC_FILES := $(LIBBT_CONF_PATH)/$(REF_PRODUCT_NAME)/bt_vendor.conf
include $(BUILD_PREBUILT)

##################################################
