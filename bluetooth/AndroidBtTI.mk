LOCAL_PATH := $(my-dir)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := bt_ti
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := \
    wl128x_common \
    uim \
    TIInit_10.6.15.bts \
    bt_common

include $(BUILD_PHONY_PACKAGE)

##################################################

