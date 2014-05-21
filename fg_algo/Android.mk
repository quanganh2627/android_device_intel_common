#Android Make file to build fg_algo_iface Executable
LOCAL_PATH := $(call my-dir)
MY_LOCAL_PATH := $(LOCAL_PATH)
include $(CLEAR_VARS)
ifeq ($(USE_FG_ALGO), true)

LOCAL_PREBUILT_LIBS := libfg/libfg.so
include $(BUILD_MULTI_PREBUILT)

include $(CLEAR_VARS)
LOCAL_PATH = $(MY_LOCAL_PATH)

LOCAL_SRC_FILES := fg_algo_iface.c
LOCAL_MODULE := fg_algo_iface
LOCAL_MODULE_TAGS := optional
LOCAL_SHARED_LIBRARIES := libc libcutils libfg
LOCAL_LDLIBS := -llog
include $(BUILD_EXECUTABLE)
endif

