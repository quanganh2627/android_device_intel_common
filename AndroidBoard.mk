# make file for common
#

LOCAL_PATH := $(TOP)/vendor/intel/common
COMMON_PATH := $(TOP)/vendor/intel/common
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

# SOC initrc file
PRODUCT_INIT_RC_FILES += $(COMMON_PATH)/init.common.rc

# USB port turn around and initialization
PRODUCT_INIT_RC_FILES += vendor/intel/common/init.mfld.usb.rc

# OOM Killer tweaks
PRODUCT_INIT_RC_FILES += vendor/intel/common/init.mfld.oom.rc

# The kernel and kernel_modules were copied to PRODUCT_OUT by build.sh.
# The kernel needs to be renamed to 'kernel' for the build.
PRODUCT_COPY_FILES += \
        $(PRODUCT_OUT)/bzImage:kernel

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
        $(PERMISSIONS_PATH)/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
        $(PERMISSIONS_PATH)/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
        $(PERMISSIONS_PATH)/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
        $(PERMISSIONS_PATH)/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
        $(PERMISSIONS_PATH)/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
        $(PERMISSIONS_PATH)/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
        $(PERMISSIONS_PATH)/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
        $(PERMISSIONS_PATH)/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml

flashfiles: firmware otapackage
	vendor/intel/release/daily_build/sync_build/publish_build.py vendor/intel/release/daily_build/sync-build.ini `pwd` $(TARGET_PRODUCT) $(TARGET_BUILD_VARIANT) $(BUILD_NUMBER)

# sepdk and vTunes
-include $(TOP)/device/intel/PRIVATE/sepdk/src/AndroidSEP.mk
-include $(TOP)/device/intel/PRIVATE/sepdk/src/pax/AndroidPAX.mk

ifeq ($(sepdk),1)
$(PRODUCT_OUT)/ramdisk.img : sep
$(PRODUCT_OUT)/ramdisk.img : pax
# vTune binaries
PRODUCT_COPY_FILES += \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/atom_db.txt:/system/bin/sepdk/atom_db.txt \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/insmod-pax:/system/bin/sepdk/insmod-pax \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/insmod-sep3:/system/bin/sepdk/insmod-sep3 \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/rmmod-pax:/system/bin/sepdk/rmmod-pax \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/rmmod-sep3:/system/bin/sepdk/rmmod-sep3 \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/sep:/system/bin/sepdk/sep \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/setup_sep_runtime_env.sh:/system/bin/sepdk/setup_sep_runtime_env.sh \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/sfdump5:/system/bin/sepdk/sfdump5 \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libabstract.so:/system/bin/sepdk/libabstract.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libatom.so:/system/bin/sepdk/libatom.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libc_osi.so:/system/bin/sepdk/libc_osi.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/liblogit.so:/system/bin/sepdk/liblogit.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libpax.so:/system/bin/sepdk/libpax.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libpise.so:/system/bin/sepdk/libpise.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libplatform_picker.so:/system/bin/sepdk/libplatform_picker.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/librise.so:/system/bin/sepdk/librise.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libsampling_utils.so:/system/bin/sepdk/libsampling_utils.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libsera.so:/system/bin/sepdk/libsera.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libsmrk.so:/system/bin/sepdk/libsmrk.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libstrings.so:/system/bin/sepdk/libstrings.so \
        $(TOP)/device/intel/PRIVATE/sepdk/bin/libtbrw.so:/system/bin/sepdk/libtbrw.so
endif

# powerdk and wuwatch
-include $(TOP)/device/intel/PRIVATE/debug_tools/powerdk/src/AndroidPowerDK.mk

ifeq ($(powerdk),1)
$(PRODUCT_OUT)/ramdisk.img : apwr
# Wuwatch binaries
PRODUCT_COPY_FILES += \
        $(TOP)/device/intel/PRIVATE/debug_tools/powerdk/bin/wuwatch_static:/system/bin/powerdk/wuwatch_static \
        $(TOP)/device/intel/PRIVATE/debug_tools/powerdk/bin/wudump_static:/system/bin/powerdk/wudump_static \
        $(TOP)/device/intel/PRIVATE/debug_tools/powerdk/src/insmod-apwr2:/system/bin/powerdk/insmod-apwr2 \
        $(TOP)/device/intel/PRIVATE/debug_tools/powerdk/src/rmmod-apwr2:/system/bin/powerdk/rmmod-apwr2
endif
