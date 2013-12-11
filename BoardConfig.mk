COMMON_PATH := device/intel/common
SUPPORT_PATH := vendor/intel/support

TARGET_ARCH := x86
TARGET_ARCH_VARIANT := x86-atom
TARGET_CPU_VARIANT := x86
TARGET_CPU_ABI := x86
TARGET_CPU_SMP := true
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_NO_RECOVERY := false
TARGET_PRELINK_MODULE := false
TARGET_PROVIDES_INIT_RC := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_RIL_DISABLE_STATUS_POLLING := true
TARGET_BOARD_KERNEL_HEADERS := $(COMMON_PATH)/kernel-headers
KERNEL_SRC_DIR ?= linux/kernel

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648

# Customization of BOOTCLASSPATH and init.environ.rc
PRODUCT_BOOT_JARS := $(PRODUCT_BOOT_JARS):com.intel.multidisplay:com.intel.config
ifeq ($(strip $(INTEL_FEATURE_AWARESERVICE)),true)
PRODUCT_BOOT_JARS := $(PRODUCT_BOOT_JARS):com.intel.aware.awareservice
endif
ifeq ($(strip $(INTEL_FEATURE_LPAL)),true)
PRODUCT_BOOT_JARS := $(PRODUCT_BOOT_JARS):com.intel.vtsv.service
endif
ifeq ($(strip $(INTEL_FEATURE_ASF)),true)
PRODUCT_BOOT_JARS := $(PRODUCT_BOOT_JARS):com.intel.asf
endif
ifeq ($(strip $(INTEL_FEATURE_ARKHAM)),true)
PRODUCT_BOOT_JARS := $(PRODUCT_BOOT_JARS):com.intel.arkham.services
endif
ifeq ($(strip $(DOLBY_DAP)),true)
PRODUCT_BOOT_JARS := $(PRODUCT_BOOT_JARS):dolby_ds
endif

# Appends path to ARM libs for Houdini
PRODUCT_LIBRARY_PATH := $(PRODUCT_LIBRARY_PATH):/system/lib/arm

# By default, signing is performed using ISU (Intel Signing Utility).  Can be
# overridden on specific target BoardConfig.mk.  Currently supported values for
# the signing method are 'xfstk', 'xfstk_no_xml', 'isu', 'isu_plat2'.
TARGET_OS_SIGNING_METHOD ?= isu

FLASHFILE_NO_OTA := true
INTEL_CRASHLOGD := false
INTEL_INGREDIENTS_VERSIONS := true
INTEL_CAMERA := false
INTEL_TEST_CAMERA := true

BOARD_GPFLAG := 0x80000045

TARGET_USE_PRIVATE_LIBM := true

ifneq ($(wildcard vendor/intel/PRIVATE/cert/testkey*),)
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/intel/PRIVATE/cert/testkey
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
        frameworks-openmax:frameworks/native/include/media/openmax \
        jpeg:external/jpeg \
        skia:external/skia/include \
        sqlite:external/sqlite/dist \
        opencv-cv:external/opencv/cv/include \
        opencv-cxcore:external/opencv/cxcore/include \
        opencv-ml:external/opencv/ml/include \
        libstagefright:frameworks/av/media/libstagefright/include \
        libstagefright-rtsp:frameworks/av/media/libstagefright/rtsp \
        libmediaplayerservice:frameworks/av/media/libmediaplayerservice \
        gtest:external/gtest/include \
        frameworks-base-libs:frameworks/base/libs \
        frameworks-av-services:frameworks/av/services \
        tinycompress:external/tinycompress/include \
        libnfc-nci:external/libnfc-nci/src/include \
        libnfc-nci_hal:external/libnfc-nci/src/hal/include \
        libnfc-nci_nfc:external/libnfc-nci/src/nfc/include \
        libnfc-nci_nfa:external/libnfc-nci/src/nfa/include \
        libnfc-nci_gki:external/libnfc-nci/src/gki \
        libc-private:bionic/libc/private \
        icu4c-common:external/icu4c/common \
        expat-lib:external/expat/lib \
        libvpx:external/libvpx \
        protobuf:external/protobuf/src \
        zlib:external/zlib \
        openssl:external/openssl/include \
        libnl-headers:external/libnl-headers \
        system-security:system/security/keystore/include/keystore \
        libpcap:external/libpcap \
        libsensorhub:vendor/intel/hardware/libsensorhub/src/include \
        libsensorhub_ish:vendor/intel/hardware/libsensorhub/src_ish/include \
        icu4c-i18n:external/icu4c/i18n \
        bt-bluez:system/bluetooth/bluez-clean-headers \
        astl:external/astl/include \
        libusb:external/libusb/libusb \
        libc-kernel:bionic/libc/kernel \
        libc-x86:bionic/libc/arch-x86/include \
        strace:external/strace \
        bionic:bionic \
        opengl:frameworks/native/opengl/include \
        libstagefright-wifi-display:frameworks/av/media/libstagefright/wifi-display \
        libffi:external/libffi/include \
        libffi-x86:external/libffi/linux-x86)

#Platform
#Enable display driver debug interface for eng and userdebug builds
ifneq (,$(filter $(TARGET_BUILD_VARIANT),eng userdebug))
export DISPLAY_DRIVER_DEBUG_INTERFACE=true
endif
#Enable ODEX for userdebug and user builds
ifneq (,$(filter $(TARGET_BUILD_VARIANT),userdebug user))
WITH_DEXPREOPT := true
# enable dex-preopt on prebuilt apks
WITH_DEXPREOPT_PREBUILT := true
endif

# Enabling logs into file system for eng and user debug builds
ifeq ($(PRODUCT_MANUFACTURER),intel)
ifneq (,$(filter $(TARGET_BUILD_VARIANT),eng userdebug))
ADDITIONAL_DEFAULT_PROPERTIES += persist.service.apklogfs.enable=1
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += persist.service.profile.enable=1
ADDITIONAL_DEFAULT_PROPERTIES += persist.service.kdumpd.enable=0
endif

ifeq ($(BOARD_HAVE_SMALL_RAM),true)
ADDITIONAL_DEFAULT_PROPERTIES += ro.config.low_ram=true
endif

# This will be replaced by the OEM/carrier with a string like android-<carrier>-us
ADDITIONAL_DEFAULT_PROPERTIES += ro.com.google.clientidbase=android-google
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += persist.core.enabled=1
endif

# Enabling collecting of additional information into tombstone file for eng and user debug builds
ifneq ($(TARGET_BUILD_VARIANT),user)
ADDITIONAL_BUILD_PROPERTIES += system.debug.plugins=libcrash.so
endif

ifeq ($(TARGET_RIL_DISABLE_STATUS_POLLING),true)
ADDITIONAL_BUILD_PROPERTIES += ro.ril.status.polling.enable=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
BUILD_INIT_EXEC := true
endif

ifeq ($(TARGET_BUILD_VARIANT),user)
cmdline_extra += watchdog.watchdog_thresh=60
endif

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

# disable the new V3 HAL by default so it can be added to the tree without conflicts
# it will be enabled in selected platforms
USE_CAMERA_HAL_3 := false

# Set USE_VIDEO_EFFECT to 'false' to unsupport live face effect. And Set OMX Component Input Buffer Count to 2.
USE_VIDEO_EFFECT := true

# Do not use shared object of ia_face by default
USE_SHARED_IA_FACE := false

# Use multi-thread for acceleration
USE_INTEL_MULT_THREAD := true

# Use Async OMX for http streaming
USE_ASYNC_OMX_CLIENT := true

# Use panorama v1.0 by default
IA_PANORAMA_VERSION := 1.0

# Turn on GR_STATIC_RECT_VB flag in skia to boost performance
TARGET_USE_GR_STATIC_RECT_VB := true

# customize the malloced address to be 16-byte aligned
BOARD_MALLOC_ALIGNMENT := 16

# Enabled Bluetooth GAP test build in bluez
BUILD_BT_GAP_TEST := true

# force user build variant to display build number for internal dev builds. External release builds should not set this flag
DISPLAY_BUILD_NUMBER := true

# Wi-Fi
include $(COMMON_PATH)/wifi/WifiBoardConfig.mk

# Gps
include $(COMMON_PATH)/gps/GpsBoardConfig.mk

# Bluetooth
include $(COMMON_PATH)/bluetooth/BtBoardConfig.mk

# SPID
#
# Can be customized for each board simply defining "SPID=" in local BoardConfig.mk
# Without customization, will be auto-set by kernel
#
# SPID format :
#        vend:cust:manu:plat:prod:hard
USE_SPID ?= true
ifeq ($(USE_SPID), true)
	SPID ?= "xxxx:xxxx:xxxx:xxxx:xxxx:xxxx"
	cmdline_extra += androidboot.spid=$(SPID)
endif

USE_BL_SERIALNO ?= false
ifeq ($(USE_BL_SERIALNO), false)
	cmdline_extra += androidboot.serialno=01234567890123456789
endif

STORAGE_CFLAGS ?= -DSTORAGE_BASE_PATH=\"/dev/block/mmcblk0\" -DSTORAGE_PARTITION_FORMAT=\"%sp%d\"
COMMON_GLOBAL_CFLAGS += $(STORAGE_CFLAGS)

# OS images signing
TARGET_BOOT_IMAGE_KEYS_PATH ?=  vendor/intel/PRIVATE/cert
TARGET_BOOT_IMAGE_PRIV_KEY ?= $(TARGET_BOOT_IMAGE_KEYS_PATH)/OS_priv.pem
TARGET_BOOT_IMAGE_PUB_KEY ?= $(TARGET_BOOT_IMAGE_KEYS_PATH)/OS_pub.pub
TARGET_BOOT_LOADER_PRIV_KEY ?= $(TARGET_BOOT_IMAGE_KEYS_PATH)/OSBL_priv.pem
TARGET_BOOT_LOADER_PUB_KEY ?= $(TARGET_BOOT_IMAGE_KEYS_PATH)/OSBL_pub.pub

# partitioning scheme
# osip-gpt:
# 	- osip used by iafw
# 	- gpt used by kernel
# full-gpt:
# 	- gpt used by iafw
# 	- gpt used by kernel
TARGET_PARTITIONING_SCHEME ?= "osip-gpt"

ifeq ($(TARGET_PARTITIONING_SCHEME),"full-gpt")
	TARGET_MAKE_NO_DEFAULT_BOOTIMAGE := false
	TARGET_MAKE_INTEL_BOOTIMAGE := true
	TARGET_BOOTIMAGE_USE_EXT2 ?= false
	BOARD_KERNEL_PAGESIZE ?= 2048
	BOARD_KERNEL_BASE ?= 0x80000000

	ifneq (, $(findstring isu,$(TARGET_OS_SIGNING_METHOD)))
		BOARD_MKBOOTIMG_ARGS += --signsize 1024 --signexec "isu_wrapper.sh isu $(TARGET_BOOT_IMAGE_PRIV_KEY) $(TARGET_BOOT_IMAGE_PUB_KEY)"
	endif

	ifeq ($(TARGET_OS_SIGNING_METHOD),uefi)
		BOARD_MKBOOTIMG_ARGS += --signsize 256 --signexec "openssl dgst -sha256 -sign $(TARGET_BOOT_IMAGE_PRIV_KEY)"
	endif
endif

ifeq ($(TARGET_PARTITIONING_SCHEME), "osip-gpt")
	TARGET_MAKE_NO_DEFAULT_BOOTIMAGE := true
	TARGET_MAKE_INTEL_BOOTIMAGE := true
	TARGET_BOOTIMAGE_USE_EXT2 ?= true


	INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img

	MAKE_NO_DEFAULT_BOOTIMAGE_ITEMS = $(MKBOOTIMG) \
		$(INTERNAL_BOOTIMAGE_FILES) \
		$(PRODUCT_OUT)/bootstub

	# CAUTION: DO NOT CHANGE the flavor of COMMON_BOOTIMAGE_ARGS.  It must remain
	# a recursively-expanded variable, i.e., it must be defined using the '=' sign.
	COMMON_BOOTIMAGE_ARGS = --sign-with $(TARGET_OS_SIGNING_METHOD) \
	--bootstub $(PRODUCT_OUT)/bootstub
	MAKE_NO_DEFAULT_BOOTIMAGE = \
		LOCAL_SIGN=$(LOCAL_SIGN) \
		$(MKBOOTIMG) \
		$(COMMON_BOOTIMAGE_ARGS) \
		$(INTERNAL_BOOTIMAGE_ARGS) \
		--type mos \
		--output $(INSTALLED_BOOTIMAGE_TARGET) \
		$(ADDITIONAL_BOOTIMAGE_ARGS)
endif

# If LOCAL_SIGN is not set, sign the OS locally (don't use signing server)
# this can be overriden with an environment variable
LOCAL_SIGN ?= true

# BIOS TYPE
# - iafw
# - uefi
TARGET_BIOS_TYPE ?= "iafw"

ifeq ($(TARGET_BIOS_TYPE),"uefi")
INSTALLED_ESPIMAGE_TARGET := $(PRODUCT_OUT)/esp.img
ESPUPDATE_ZIP_TARGET := $(PRODUCT_OUT)/esp.zip
endif

# MKBOOTIMG is the tool that is used by AOSP build system to
# stitch kernel. We overide the default script to
# adapt to out own IAFW format.
ifeq ($(TARGET_PARTITIONING_SCHEME),"osip-gpt")
MKBOOTIMG := $(SUPPORT_PATH)/mkbootimg
endif

# Intel Signing Utility and xfstk-stitcher, required by mkbootimg to sign images.
# Add dependancy on ISU packages only if ISU method is used as ISU might not be delivered.
ifneq ($(findstring isu,$(TARGET_OS_SIGNING_METHOD)),)
$(MKBOOTIMG): isu isu_stream isu_wrapper
endif
$(MKBOOTIMG): xfstk-stitcher

# If the kernel source is present, AndroidBoard.mk will perform a kernel build.
# otherwise, AndroidBoard.mk will find the kernel binaries in a tarball.
ifneq ($(wildcard $(KERNEL_SRC_DIR)/Makefile),)
TARGET_KERNEL_SOURCE_IS_PRESENT ?= true
endif

.PHONY: build_kernel build_kernel-nodeps
ifeq ($(TARGET_KERNEL_SOURCE_IS_PRESENT),true)
build_kernel: get_kernel_from_source
build_kernel-nodeps: get_kernel_from_source
else
build_kernel: get_kernel_from_tarball
build_kernel-nodeps: get_kernel_from_tarball
endif

.PHONY: get_kernel_from_tarball
get_kernel_from_tarball:
	tar -xv -C $(PRODUCT_OUT) -f $(TARGET_KERNEL_TARBALL)

bootimage: build_kernel

$(INSTALLED_KERNEL_TARGET): build_kernel
$(INSTALLED_RAMDISK_TARGET): build_kernel

# external release
include $(COMMON_PATH)/external/external.mk
