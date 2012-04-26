#
# config.mk for mrst
#

TARGET_ARCH := x86
TARGET_ARCH_VARIANT := x86-atom
TARGET_BOARD_PLATFORM := mrst
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
TARGET_BOOTLOADER_BOARD_NAME := mrst

#Platform
DISABLE_DEXPREOPT := true

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

#Intel recovery images and boot images are different from android images.
INTEL_BOOTIMG := true

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

# Security
BUILD_WITH_CHAABI_SUPPORT := true
BUILD_WITH_WATCHDOG_DAEMON_SUPPORT := true

# Imaging by default
USE_INTEL_HDR := true

# Enabled to use Intel face detection libraries by default
USE_INTEL_FACE_DETECTION := true
