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

FLASHFILE_NO_OTA := true
INTEL_CRASHLOGD := false
INTEL_INGREDIENTS_VERSIONS := true
INTEL_CAMERA := false
INTEL_TEST_CAMERA := true

USE_PRIVATE_LIBM := true

ifneq ($(wildcard $(TOP)/vendor/intel/PRIVATE/cert/testkey*),)
PRODUCT_DEFAULT_DEV_CERTIFICATE :=  $(TOP)/vendor/intel/PRIVATE/cert/testkey
endif

#Platform
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

#Intel recovery images and boot images are different from android images.
TARGET_MAKE_NO_DEFAULT_BOOTIMAGE := true
TARGET_MAKE_INTEL_BOOTIMAGE := true

# Enable to use Intel boot.bin
ifeq ($(TARGET_MAKE_INTEL_BOOTIMAGE),true)
INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.bin
MAKE_NO_DEFAULT_BOOTIMAGE_ITEMS = $(MKBOOTIMG) \
	$(INTERNAL_BOOTIMAGE_FILES)
MAKE_NO_DEFAULT_BOOTIMAGE = $(MKBOOTIMG) \
	$(INTERNAL_BOOTIMAGE_ARGS) \
	--product $(TARGET_DEVICE) \
	--type mos \
	--output $(INSTALLED_BOOTIMAGE_TARGET)
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

# Turn on GR_STATIC_RECT_VB flag in skia to boost performance
TARGET_USE_GR_STATIC_RECT_VB := true

# customize the malloced address to be 16-byte aligned
BOARD_MALLOC_ALIGNMENT := 16

# Enabled Bluetooth GAP test build in bluez
BUILD_BT_GAP_TEST := true

# force user build variant to display build number for internal dev builds. External release builds should not set this flag
DISPLAY_BUILD_NUMBER := true

# Wi-Fi
include vendor/intel/common/wifi/WifiBoardConfig.mk

# Gps
include vendor/intel/common/gps/GpsBoardConfig.mk

# external release
include vendor/intel/common/external/external.mk
