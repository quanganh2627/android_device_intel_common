LOCAL_PATH := $(call my-dir)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.common
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    parameter \
    ConfigurationSubsystem.xml
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.vibrator.common
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    vibrator
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.imc.subsystem
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    IMCSubsystem.xml
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.power.subsystem
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    PowerSubsystem.xml
include $(BUILD_PHONY_PACKAGE)

##################################################

ifeq ($(TARGET_BUILD_VARIANT),eng)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SYSTEM
LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
LOCAL_SRC_FILES := SCRIPTS/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

else

include $(CLEAR_VARS)
LOCAL_MODULE := parameter
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SYSTEM
LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
LOCAL_SRC_FILES := SCRIPTS/$(LOCAL_MODULE).user_debug
include $(BUILD_PREBUILT)

endif

include $(CLEAR_VARS)
LOCAL_MODULE := vibrator
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SYSTEM
LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
LOCAL_SRC_FILES := SCRIPTS/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := ConfigurationSubsystem.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio
LOCAL_SRC_FILES := XML/Structure/Audio/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := IMCSubsystem.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio
LOCAL_SRC_FILES := XML/Structure/Audio/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := PowerSubsystem.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio
LOCAL_SRC_FILES := XML/Structure/Audio/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

##################################################

