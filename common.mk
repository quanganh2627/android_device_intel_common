PRODUCT_MANUFACTURER := intel
override PRODUCT_BRAND := intel

#Add Fromat Misk
PRODUCT_PACKAGES += \
    format_misc

#Add SensorCal App
PRODUCT_PACKAGES += \
    SensorCal

#Add update_recovery binary for OTA
PRODUCT_PACKAGES += \
    update_recovery

#Add make_ext4fs tool for JB's encryption app feature
PRODUCT_PACKAGES += \
    make_ext4fs

#for burst capture
PRODUCT_PACKAGES += \
	fast_click.pcm

#Add kernel watchdog daemon
PRODUCT_PACKAGES += \
    ia_watchdogd \
    libwatchdogd_devel

# SpeechRecorder for eng build variant
ifneq ($(filter $(TARGET_BUILD_VARIANT),eng),)
PRODUCT_PACKAGES += \
    SpeechRecorder
endif

# copy boot animation resources
BOOTANIMATION_RESOURCE_PATH := vendor/intel/common/
PRODUCT_COPY_FILES += \
    $(BOOTANIMATION_RESOURCE_PATH)/bootanimation.zip:system/media/bootanimation.zip

# Target image build tools.
# These are defined in libintelprov/Android.mk
# Note: some of these have ".py" (python) suffixes. The suffix must
#       not be specified in PRODUCT_PACKAGES... it gets stripped by the
#       core/multi_prebuilt.mk auto-prebuilt-boilerplate rule.
PRODUCT_PACKAGES += \
    releasetools \
    ota_from_target_files \
    check_target_files_signatures \
    common \
    edify_generator \
    lfstk_wrapper \
    mfld_osimage \
    sign_target_files_apks

#Houdini prebuilt
HOUDINI_ARM_PREBUILTS_DIR := device/intel/PRIVATE/houdini-armlibs
houdini_prebuilt_stamp := $(HOUDINI_ARM_PREBUILTS_DIR)/stamp-prebuilt-done
houdini_prebuilt_done := $(wildcard $(houdini_prebuilt_stamp))
ifneq ($(houdini_prebuilt_done),)
INTEL_HOUDINI := true
#Houdini
PRODUCT_PACKAGES += \
    libhoudini \
    houdini \
    enable_houdini \
    disable_houdini \
    check.xml \
    cpuinfo \
    cpuinfo.neon
endif

#GMS package
-include vendor/google/PRIVATE/gms/products/gms.mk

COMMON_PATH := vendor/intel/common
ifneq ($(strip $(TARGET_BUILD_VARIANT)),user)
PRODUCT_COPY_FILES += \
        $(COMMON_PATH)/atproxy_usbreset:system/bin/atproxy_usbreset
endif
PRODUCT_COPY_FILES += \
        $(COMMON_PATH)/init.rc:root/init.rc \
        $(COMMON_PATH)/init.common.rc:root/init.common.rc \
        $(COMMON_PATH)/props.rc:root/props.rc \
        $(COMMON_PATH)/props.default.rc:root/props.default.rc \
        $(COMMON_PATH)/ueventd.modules.blacklist:system/etc/ueventd.modules.blacklist

PERMISSIONS_PATH := frameworks/native/data/etc
PRODUCT_COPY_FILES += \
        $(PERMISSIONS_PATH)/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
        $(PERMISSIONS_PATH)/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
        $(PERMISSIONS_PATH)/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
        $(PERMISSIONS_PATH)/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
        $(PERMISSIONS_PATH)/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml


# Power Debug Tools
-include hardware/intel/PRIVATE/platform_test/power-debug/power-debug.mk

# Kratos (not for user builds)
ifneq (, $(findstring "$(TARGET_BUILD_VARIANT)", "eng" "userdebug"))
-include vendor/intel/PRIVATE/apps/Kratos/products/Kratos.mk
endif

# vTunes binaires (not for user builds)
ifneq (, $(findstring "$(TARGET_BUILD_VARIANT)", "eng" "userdebug"))
-include device/intel/PRIVATE/debug_internal_tools/sepdk/bin/sepbin.mk
endif


# Crashinfo
-include device/intel/PRIVATE/log_infra/crashinfo/crashinfo.mk

#crash report
PRODUCT_COPY_FILES += \
        device/intel/log_capture/crashlog/monitor_crashenv:system/bin/monitor_crashenv \
        device/intel/log_capture/crashlog/del_hist.sh:system/bin/del_hist.sh \
        device/intel/log_capture/crashlog/del_log.sh:system/bin/del_log.sh \
        device/intel/log_capture/crashlog/dumpstate_dropbox.sh:system/bin/dumpstate_dropbox.sh

#Bring in camera media effects
$(call inherit-product-if-exists, frameworks/base/data/videos/VideoPackage2.mk)
