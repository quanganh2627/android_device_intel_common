# make file for common
#

LOCAL_PATH := $(TOP)/vendor/intel/common
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
        $(LOCAL_PATH)/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
        $(LOCAL_PATH)/init.nfs.rc:root/init.nfs.rc \
        $(LOCAL_PATH)/init.sdcard1.rc:root/init.sdcard1.rc \
        $(LOCAL_PATH)/init.sdcard2.rc:root/init.sdcard2.rc \
        frameworks/base/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
        $(PERMISSIONS_PATH)/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
        $(PERMISSIONS_PATH)/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
        $(PERMISSIONS_PATH)/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
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
