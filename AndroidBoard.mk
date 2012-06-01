# make file for common
#

LOCAL_PATH := $(TOP)/vendor/intel/common
COMMON_PATH := $(TOP)/vendor/intel/common
SUPPORT_PATH:= $(TOP)/vendor/intel/support
PUBLISH_PATH:= $(TOP)/pub
PERMISSIONS_PATH := $(TOP)/frameworks/base/data/etc

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

# MKBOOTIMG is the tool that is used by AOSP build system to
# stitch kernel. We overide the default script to
# adapt to out own IAFW format.
MKBOOTIMG := vendor/intel/support/mkbootimg

$(INSTALLED_KERNEL_TARGET): build_kernel
$(INSTALLED_RAMDISK_TARGET): build_kernel

# SOC initrc file
PRODUCT_INIT_RC_FILES += $(COMMON_PATH)/init.common.rc

# OOM Killer tweaks
PRODUCT_INIT_RC_FILES += vendor/intel/common/init.mfld.oom.rc

# board specific files
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/android.conf:system/etc/dhcpcd/android.conf \
        $(LOCAL_PATH)/activate_trace_modem:system/bin/activate_trace_modem \
        $(LOCAL_PATH)/configure_trace_modem:system/bin/configure_trace_modem \
        $(LOCAL_PATH)/usbswitch_modem:system/bin/usbswitch_modem \
        $(LOCAL_PATH)/usbswitch_ape:system/bin/usbswitch_ape \
        $(LOCAL_PATH)/usbswitch_status:system/bin/usbswitch_status \
        $(LOCAL_PATH)/toggle_pin_on1:system/bin/toggle_pin_on1

# platform common files
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/init.rc:init.rc \
        $(LOCAL_PATH)/init.nfs.rc:root/init.nfs.rc \
        $(LOCAL_PATH)/init.sdcard1.rc:root/init.sdcard1.rc \
        $(LOCAL_PATH)/init.sdcard2.rc:root/init.sdcard2.rc \
        $(PERMISSIONS_PATH)/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
        $(PERMISSIONS_PATH)/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
        $(PERMISSIONS_PATH)/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
        $(PERMISSIONS_PATH)/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml


ifeq ($(FLASHFILE_BOOTONLY),true)
flashfiles: bootimage
else
flashfiles: firmware otapackage recoveryimage
ifeq ($(TARGET_USE_DROIDBOOT),true)
flashfiles: droidbootimage systemimg_gz
else
flashfiles: systemtarball
endif
endif

ifeq ($(USE_GMS_ALL),false)
PUBLISH_TARGET_BUILD_VARIANT := $(TARGET_BUILD_VARIANT)
else
PUBLISH_TARGET_BUILD_VARIANT := $(TARGET_BUILD_VARIANT)_gms
endif

flashfiles:
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	GENERIC_TARGET_NAME=$(GENERIC_TARGET_NAME) \
	TARGET_USE_DROIDBOOT=$(TARGET_USE_DROIDBOOT) \
	FLASHFILE_BOOTONLY=$(FLASHFILE_BOOTONLY) \
	FLASH_MODEM=$(BOARD_HAVE_MODEM) \
	$(SUPPORT_PATH)/publish_build.py `pwd` $(TARGET_PRODUCT) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG)

blank_flashfiles: firmware
ifeq ($(TARGET_USE_DROIDBOOT),true)
blank_flashfiles: droidbootimage
else
blank_flashfiles: recoveryimage
endif
blank_flashfiles:
	$(if $(IFWI_PREBUILT_PATHS), \
		PUBLISH_PATH=$(PUBLISH_PATH) \
		TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
		GENERIC_TARGET_NAME=$(GENERIC_TARGET_NAME) \
		TARGET_USE_DROIDBOOT=$(TARGET_USE_DROIDBOOT) \
		$(SUPPORT_PATH)/publish_build.py `pwd` $(TARGET_PRODUCT) 'blankphone' $(FILE_NAME_TAG), \
		@echo "No IFWI found for this target. No blank flashfile to generate")

publish_modem:
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	BOARD_HAVE_MODEM=$(BOARD_HAVE_MODEM) \
	RADIO_FIRMWARE_DIR=$(RADIO_FIRMWARE_DIR) \
	$(SUPPORT_PATH)/publish_build.py `pwd` $(TARGET_PRODUCT) 'modem' $(FILE_NAME_TAG)

# sepdk and vTunes
-include $(TOP)/device/intel/debug_tools/sepdk/src/AndroidSEP.mk
-include $(TOP)/device/intel/debug_tools/sepdk/src/pax/AndroidPAX.mk

ifeq ($(sepdk),1)
$(PRODUCT_OUT)/ramdisk.img : sep
$(PRODUCT_OUT)/ramdisk.img : pax
# vTune binaries
PRODUCT_COPY_FILES += \
        $(TOP)/device/intel/debug_tools/sepdk/bin/atom_db.txt:/system/bin/sepdk/atom_db.txt \
        $(TOP)/device/intel/debug_tools/sepdk/bin/insmod-pax:/system/bin/sepdk/insmod-pax \
        $(TOP)/device/intel/debug_tools/sepdk/bin/insmod-sep3:/system/bin/sepdk/insmod-sep3 \
        $(TOP)/device/intel/debug_tools/sepdk/bin/rmmod-pax:/system/bin/sepdk/rmmod-pax \
        $(TOP)/device/intel/debug_tools/sepdk/bin/rmmod-sep3:/system/bin/sepdk/rmmod-sep3 \
        $(TOP)/device/intel/debug_tools/sepdk/bin/sep:/system/bin/sepdk/sep \
        $(TOP)/device/intel/debug_tools/sepdk/bin/setup_sep_runtime_env.sh:/system/bin/sepdk/setup_sep_runtime_env.sh \
        $(TOP)/device/intel/debug_tools/sepdk/bin/sfdump5:/system/bin/sepdk/sfdump5 \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libabstract.so:/system/bin/sepdk/libabstract.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libatom.so:/system/bin/sepdk/libatom.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libc_osi.so:/system/bin/sepdk/libc_osi.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/liblogit.so:/system/bin/sepdk/liblogit.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libpax.so:/system/bin/sepdk/libpax.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libpise.so:/system/bin/sepdk/libpise.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libplatform_picker.so:/system/bin/sepdk/libplatform_picker.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/librise.so:/system/bin/sepdk/librise.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libsampling_utils.so:/system/bin/sepdk/libsampling_utils.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libsera.so:/system/bin/sepdk/libsera.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libsmrk.so:/system/bin/sepdk/libsmrk.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libstrings.so:/system/bin/sepdk/libstrings.so \
        $(TOP)/device/intel/debug_tools/sepdk/bin/libtbrw.so:/system/bin/sepdk/libtbrw.so
endif

# powerdk and wuwatch
-include $(TOP)/device/intel/debug_tools/powerdk/src/AndroidPowerDK.mk

ifeq ($(powerdk),1)
$(PRODUCT_OUT)/ramdisk.img : apwr
# Wuwatch binaries
PRODUCT_COPY_FILES += \
        $(TOP)/device/intel/debug_tools/powerdk/bin/wuwatch:/system/bin/powerdk/wuwatch
endif
