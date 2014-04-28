PRODUCT_MANUFACTURER := intel
override PRODUCT_BRAND := intel

# These goals don't need to collect and include Android.mks/CleanSpec.mks
# in the source tree.
intel_dont_bother_goals := build_kernel-nodeps \
    menuconfig xconfig gconfig \
    TAGS tags gtags cscope

ifneq ($(filter $(intel_dont_bother_goals), $(MAKECMDGOALS)),)
dont_bother := true
endif

#Add Power HAL Package
PRODUCT_PACKAGES += \
    power.$(PRODUCT_DEVICE)

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

#Use partlink block devices
PRODUCT_PACKAGES += \
    partlink

# SpeechRecorder for eng build variant
PRODUCT_PACKAGES_ENG += \
    SpeechRecorder

#AESNI for bouncycastle
PRODUCT_PACKAGES += \
        libaesni

# copy boot animation resources
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/bootanimation.zip:system/media/bootanimation.zip

# Copy sar manager resources
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/sarconfig.xml:system/etc/sarconfig.xml

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
    product_name_mapping \
    sign_target_files_apks

#Houdini prebuilt
HOUDINI_ARM_PREBUILTS_DIR := vendor/intel/houdini/arm
houdini_prebuilt_stamp := $(HOUDINI_ARM_PREBUILTS_DIR)/stamp-prebuilt-done
houdini_prebuilt_done := $(wildcard $(houdini_prebuilt_stamp))
ifneq ($(houdini_prebuilt_done),)
INTEL_HOUDINI := true
#Houdini
PRODUCT_PACKAGES += libhoudini \
    houdini \
    enable_houdini \
    disable_houdini \
    check.xml \
    cpuinfo \
    cpuinfo.neon

#houdini arm libraries
-include vendor/intel/houdini/houdini.mk
endif

#GMS package
-include vendor/google/PRIVATE/gms/products/gms.mk

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += \
        $(COMMON_PATH)/atproxy_usbreset:system/bin/atproxy_usbreset
endif
PRODUCT_COPY_FILES += \
        $(COMMON_PATH)/init.rc:root/init.rc \
        $(COMMON_PATH)/props.rc:root/props.rc \
        $(COMMON_PATH)/ueventd.modules.blacklist:root/ueventd.modules.blacklist \
        $(COMMON_PATH)/init.partlink.rc:root/init.partlink.rc

PERMISSIONS_PATH := frameworks/native/data/etc
PRODUCT_COPY_FILES += \
        $(PERMISSIONS_PATH)/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
        $(PERMISSIONS_PATH)/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
        $(PERMISSIONS_PATH)/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
        $(PERMISSIONS_PATH)/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml

# Valgrind for eng build variant
PRODUCT_PACKAGES_ENG += \
    valgrind_pack

# Power Debug Tools
-include vendor/intel/hardware/PRIVATE/platform_test/power-debug/power-debug.mk

ifneq (,$(filter $(TARGET_BUILD_VARIANT),eng userdebug))
# memmonitor (not for user builds)
-include vendor/intel/tools/PRIVATE/log_infra/monitor/memmonitor/memmonitor.mk

# thermal debug tools/scripts (not for user builds)
-include vendor/intel/tools/PRIVATE/debug_internal_tools/thermal/thermal.mk

# MPM (formely Kratos) (not for user builds)
-include vendor/intel/apps/PRIVATE/Kratos/products/MPM.mk

# vTunes binaires (not for user builds)
-include vendor/intel/tools/PRIVATE/debug_internal_tools/sepdk/bin/sepbin.mk

# VISA binaires (not for user builds)
-include vendor/intel/tools/PRIVATE/debug_internal_tools/visadk/bin/visabin.mk
endif

# Crashinfo
-include vendor/intel/tools/PRIVATE/log_infra/crashinfo/crashinfo.mk

#crash report
PRODUCT_COPY_FILES += \
vendor/intel/tools/log_capture/crashlog/monitor_crashenv:system/bin/monitor_crashenv \
vendor/intel/tools/log_capture/crashlog/del_hist.sh:system/bin/del_hist.sh \
vendor/intel/tools/log_capture/crashlog/del_log.sh:system/bin/del_log.sh \
vendor/intel/tools/log_capture/crashlog/dumpstate_dropbox.sh:system/bin/dumpstate_dropbox.sh

#Bring in camera media effects
$(call inherit-product-if-exists, frameworks/base/data/videos/VideoPackage2.mk)

# PSI Recorder (not for user builds)
PRODUCT_PACKAGES_DEBUG += \
    PSI_Recorder

# AudioToolBox (for eng builds)
PRODUCT_PACKAGES_ENG += \
    AudioToolBox

# network (wifi, bt) data dump (tcpdump is present only in eng. builds)
ifneq (,$(filter $(TARGET_BUILD_VARIANT),eng userdebug))
 PRODUCT_COPY_FILES += \
     $(COMMON_PATH)/init.dump.rc:root/init.dump.rc
endif

ifneq ($(BOARD_HAVE_MODEM), false)
# AMTL unified configuration
-include vendor/intel/tools/log_capture/amtl/src/com/intel/amtl/config_catalog/amtl.mk
endif

PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/init.common.rc:root/init.common.rc

# Arkham
PRODUCT_PACKAGES += \
    init.intel.features.rc \
    com.intel.config \
    com.intel.config.xml \
    com.intel.arkham.services \
    com.intel.arkham.services.xml \
    ContainerDeviceAdmin \
    ContainerLauncher
PRODUCT_PACKAGES_ENG += \
    cm

# Android Security Framework
PRODUCT_PACKAGES += \
        init.intel.feature.asf.rc \
        com.intel.asf \
        com.intel.asf.xml \
        securityfileservice \
        securitydeviceservice \
        SecurityManagerService

# This library is required for Intel's implementation of Dalvik
# libpcgdvmjit is a part of Dalvik JIT compiler
PRODUCT_PACKAGES += libpcgdvmjit

# This library is required for Intel's implementation of Dalvik
# libcrash is a library which provides recorded state of an applications
# which crashed while running on Dalvik VM
PRODUCT_PACKAGES += libcrash

# include test suite for eng and userdebug builds
include $(COMMON_PATH)/test_suites.mk

# CAM
PRODUCT_PACKAGES += \
    cam_mandatory
