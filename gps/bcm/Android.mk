VENDOR_PATH := bcm

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := gps_bcm_4752
LOCAL_MODULE_TAGS := optional
#LOCAL_REQUIRED_MODULES :=  \

# WARNING: To be kept as the last required module.
LOCAL_REQUIRED_MODULES +=  \
    gps_common
include $(BUILD_PHONY_PACKAGE)

##################################################
