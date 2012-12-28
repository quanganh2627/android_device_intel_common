LOCAL_PATH := $(ANDROID_BUILD_TOP)

TI_PRIVATE_BT_PATH := device/intel/PRIVATE/fw/bt
TIWL128_BT_FW_PATH := $(TI_PRIVATE_BT_PATH)/bin
BT_FW_TARGET_PATH := $(TARGET_OUT_ETC)/firmware

BT_COMMON_ABS := $(TOP)/vendor/intel/common/bluetooth

-include $(BT_COMMON)/../ComboChipVendor.mk

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := bt_ti
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := \
    uim \
    libbluetooth_vs \
    TIInit_10.6.15.bts \
    bt_common

include $(BUILD_PHONY_PACKAGE)

##################################################

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	$(BT_COMMON)/hci_vs.c \

LOCAL_C_INCLUDES:= \
	$(BT_COMMON_ABS)/include \
	$(TOP)/external/bluetooth/bluez/lib
LOCAL_SHARED_LIBRARIES := \
	libbluetooth
LOCAL_MODULE:= libbluetooth_vs
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := TIInit_10.6.15.bts
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(BT_FW_TARGET_PATH)
LOCAL_SRC_FILES := $(TIWL128_BT_FW_PATH)/TIInit_10.6.15.bts
include $(BUILD_PREBUILT)

##################################################
