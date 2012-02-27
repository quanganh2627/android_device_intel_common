ifneq (,$(filter $(CUSTOM_BOARD),ivydale crossroads mrst_ref))

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:=        \
    mmc_storage_startup.c

LOCAL_MODULE:= mmc_storage_startup
LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)

LOCAL_RC_FILE := $(LOCAL_PATH)/mmc_storage_startup.rc
#PRODUCT_INIT_RC_FILES += $(LOCAL_RC_FILE)

endif
