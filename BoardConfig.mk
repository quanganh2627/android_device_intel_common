TARGET_ARCH := x86
TARGET_ARCH_VARIANT := x86-atom
TARGET_BOOTIMAGE_USE_EXT2 := true
TARGET_CPU_ABI := x86
TARGET_CPU_SMP := true
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_NO_RECOVERY := false
TARGET_PRELINK_MODULE := false
TARGET_PROVIDES_INIT_RC := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_RIL_DISABLE_STATUS_POLLING := true
KERNEL_SRC_DIR ?= linux/kernel

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648

# By default, signing is performed using ISU (Intel Signing Utility).  Can be
# overridden on specific target BoardConfig.mk.  Currently supported values for
# the signing method are 'none' and 'isu'.
TARGET_OS_SIGNING_METHOD := isu

FLASHFILE_NO_OTA := true
INTEL_CRASHLOGD := false
INTEL_INGREDIENTS_VERSIONS := true
INTEL_CAMERA := false
INTEL_TEST_CAMERA := true

USE_PRIVATE_LIBM := true

ifneq ($(wildcard $(TOP)/vendor/intel/PRIVATE/cert/testkey*),)
PRODUCT_DEFAULT_DEV_CERTIFICATE :=  $(TOP)/vendor/intel/PRIVATE/cert/testkey
endif

#Extend the AOSP path includes
$(call add-path-map, stlport:external/stlport/stlport \
        alsa-lib:external/alsa-lib/include \
        libxml2:external/libxml2/include \
        webcore-icu:external/webkit/Source/WebCore/icu \
        tinyalsa:external/tinyalsa/include \
        core-jni:frameworks/base/core/jni \
        vss:frameworks/av/libvideoeditor/vss/inc \
        vss-common:frameworks/av/libvideoeditor/vss/common/inc \
        vss-mcs:frameworks/av/libvideoeditor/vss/mcs/inc \
        vss-stagefrightshells:frameworks/av/libvideoeditor/vss/stagefrightshells/inc \
        lvpp:frameworks/av/libvideoeditor/lvpp \
        osal:frameworks/av/libvideoeditor/osal/inc \
        frameworks-base-core:frameworks/base/core/jni \
        frameworks-av:frameworks/av/include \
        jpeg:external/jpeg \
        skia:external/skia/include \
        sqlite:external/sqlite/dist \
        opencv-cv:external/opencv/cv/include \
        opencv-cxcore:external/opencv/cxcore/include \
        opencv-ml:external/opencv/ml/include)

#Platform
#Enable display driver debug interface for eng and userdebug builds
ifneq (user,$(findstring $(TARGET_BUILD_VARIANT),user))
export DISPLAY_DRIVER_DEBUG_INTERFACE=true
endif
#Enable ODEX for userdebug and user builds
ifneq (,$(findstring $(TARGET_BUILD_VARIANT),userdebug user))
WITH_DEXPREOPT := true
# enable dex-preopt on prebuilt apks
WITH_DEXPREOPT_PREBUILT := true
endif

# Enabling logs into file system for eng and user debug builds
ifeq ($(PRODUCT_MANUFACTURER),intel)
ifneq (, $(findstring "$(TARGET_BUILD_VARIANT)", "eng" "userdebug"))
ADDITIONAL_DEFAULT_PROPERTIES += persist.service.apklogfs.enable=1 \
                                 persist.service.crashlog.enable=1
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += persist.service.profile.enable=1
endif

# This will be replaced by the OEM/carrier with a string like android-<carrier>-us
ADDITIONAL_DEFAULT_PROPERTIES += ro.com.google.clientidbase=android-google
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += persist.core.enabled=1
endif

ifeq ($(TARGET_RIL_DISABLE_STATUS_POLLING),true)
ADDITIONAL_BUILD_PROPERTIES += ro.ril.status.polling.enable=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
BUILD_INIT_EXEC := true
endif

TARGET_MAKE_NO_DEFAULT_BOOTIMAGE ?= true
TARGET_MAKE_INTEL_BOOTIMAGE ?= true

# Enable to use Intel boot.bin
ifeq ($(TARGET_MAKE_INTEL_BOOTIMAGE),true)
INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.bin

MAKE_NO_DEFAULT_BOOTIMAGE_ITEMS = $(MKBOOTIMG) \
	$(INTERNAL_BOOTIMAGE_FILES)
# CAUTION: DO NOT CHANGE the flavor of COMMON_BOOTIMAGE_ARGS.  It must remain
# a recursively-expanded variable, i.e., it must be defined using the '=' sign.
COMMON_BOOTIMAGE_ARGS = --sign-with $(TARGET_OS_SIGNING_METHOD)
MAKE_NO_DEFAULT_BOOTIMAGE = $(MKBOOTIMG) \
	$(COMMON_BOOTIMAGE_ARGS) \
	$(INTERNAL_BOOTIMAGE_ARGS) \
	--product $(REF_DEVICE_NAME) \
	--type mos \
	--output $(INSTALLED_BOOTIMAGE_TARGET) \
	$(ADDITIONAL_BOOTIMAGE_ARGS)

endif # TARGET_MAKE_INTEL_BOOTIMAGE

ifeq ($(BOARD_BOOTMEDIA),)
BOARD_BOOTMEDIA := sdcard
endif

BOOT_TARBALL_FORMAT := gz
SYSTEM_TARBALL_FORMAT := gz

# Required for the size calculations in definitions.mk. Since
# definitions.mk assume a nand... a bit of space will be wasted
BOARD_FLASH_BLOCK_SIZE := 2048
BUILD_WITH_FULL_STAGEFRIGHT := true


# Set property of maximal runtime heap size to 64MB for intel's mfld board.
# If not set, one app can only use at most 16MB for runtime heap, which is
# too small and sometimes would cause out-of-memory error.
ADDITIONAL_BUILD_PROPERTIES += dalvik.vm.heapsize=64m

# Enabling Houdini by default
ADDITIONAL_BUILD_PROPERTIES += ro.product.cpu.abi2=armeabi-v7a

# kernel Mmap memory bottom-up
ADDITIONAL_BUILD_PROPERTIES += ro.config.personality=compat_layout

# Security
BUILD_WITH_CHAABI_SUPPORT := true
BUILD_WITH_WATCHDOG_DAEMON_SUPPORT := true

# Use Intel camera extras (HDR, face detection, panorama, etc.) by default
USE_INTEL_CAMERA_EXTRAS := true

# select libcamera2 as the camera HAL
USE_CAMERA_HAL2 := true

# Set USE_VIDEO_EFFECT to 'false' to unsupport live face effect. And Set OMX Component Input Buffer Count to 2.
USE_VIDEO_EFFECT := true

# Turn on GR_STATIC_RECT_VB flag in skia to boost performance
TARGET_USE_GR_STATIC_RECT_VB := true

# customize the malloced address to be 16-byte aligned
BOARD_MALLOC_ALIGNMENT := 16

# Enabled Bluetooth GAP test build in bluez
BUILD_BT_GAP_TEST := true

# force user build variant to display build number for internal dev builds. External release builds should not set this flag
DISPLAY_BUILD_NUMBER := true

# Wi-Fi
include device/intel/common/wifi/WifiBoardConfig.mk

# Gps
include device/intel/common/gps/GpsBoardConfig.mk

# SPID
#
# Can be customized for each board simply defining "SPID=" in local BoardConfig.mk
# Without customization, will be auto-set by kernel
#
# SPID format :
#        vend:cust:manu:plat:prod:hard
SPID ?= "xxxx:xxxx:xxxx:xxxx:xxxx:xxxx"

cmdline_extra += androidboot.spid=$(SPID)

cmdline_extra += androidboot.serialno=01234567890123456789012345678901

STORAGE_CFLAGS ?= -DSTORAGE_BASE_PATH=\"/dev/block/mmcblk0\" -DSTORAGE_PARTITION_FORMAT=\"%sp%d\"
COMMON_GLOBAL_CFLAGS += $(STORAGE_CFLAGS)

# external release
include device/intel/common/external/external.mk
