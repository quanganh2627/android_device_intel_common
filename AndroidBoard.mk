# make file for common
#

LOCAL_PATH := $(call my-dir)
ACS_BUILDBOT_PATH := vendor/intel/PRIVATE/buildbot_acs
PERMISSIONS_PATH := frameworks/native/data/etc

EFILINUX_FAKEBATT_CFG := $(LOCAL_PATH)/config/efilinux_fakebatt.cfg
$(EFILINUX_FAKEBATT_CFG):

include $(LOCAL_PATH)/util.mk
include $(CLEAR_VARS)
LOCAL_SRC_FILES := mrst_keypad.kcm
LOCAL_MODULE_TAGS := optional
include $(BUILD_KEY_CHAR_MAP)

include $(CLEAR_VARS)
LOCAL_MODULE := mrst_keypad.kl
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := mrst_keypad.kl
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_KEYLAYOUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := KEYPAD.kl
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := KEYPAD.kl
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_KEYLAYOUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := gpio-keys.kl
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := gpio-keys.kl
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_KEYLAYOUT)
include $(BUILD_PREBUILT)

#Publish parameter
LEGACY_PUBLISH ?= true

# Add sepdk driver
-include vendor/intel/tools/PRIVATE/debug_internal_tools/sepdk/src/AndroidSEP.mk
-include linux/modules/debug_tools/vtunedk/src/pax/AndroidPAX.mk

# Add vtunedk: sep3_xx, vtsspp drivers. PAX driver will be used from sepdk.
-include linux/modules/debug_tools/vtunedk/src/AndroidSEP.mk
-include linux/modules/debug_tools/vtunedk/src/vtsspp/AndroidVTSSPP.mk

# Testbox - Only for engineering and userdebug
ifneq (,$(filter $(TARGET_BUILD_VARIANT),eng userdebug))
-include linux/modules/PRIVATE/testbox/AndroidTB.mk
endif
