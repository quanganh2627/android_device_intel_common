VENDOR_PATH := bcm

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := init.gps.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
LOCAL_SRC_FILES := $(VENDOR_PATH)/init.gps.rc
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := init.gps.io.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
LOCAL_SRC_FILES := $(PLATFORM_PATH)/gps/$(GPS_CHIP_VENDOR)/init.gps.io.rc
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := gps_bcm_4752
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    gps_common \
    init.gps.io.rc \
    gpsd \
    gpslogd \
    gps.conf \
    gps.xml

include $(BUILD_PHONY_PACKAGE)

##################################################
