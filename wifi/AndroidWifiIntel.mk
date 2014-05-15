LOCAL_PATH := $(call my-dir)

##################################################
include $(CLEAR_VARS)
LOCAL_MODULE :=  wifi_intel
LOCAL_MODULE_TAGS := optional

# Wifi user space components
LOCAL_REQUIRED_MODULES +=  \
    wifi_intel_usc

# WARNING: To be kept as the last required module.
LOCAL_REQUIRED_MODULES +=  \
    wifi_common

include $(BUILD_PHONY_PACKAGE)
