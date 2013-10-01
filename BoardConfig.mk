# Common BoardConfig.mk for *ALL* Intel projects.
# Be very careful what you put in here; it may more
# properly belong in a platform or product-specifc
# BoardConfig.mk, or a mix-in
export PDK_FUSION_PLATFORM_ZIP=vendor/pdk/mini_x86/mini_x86-userdebug/platform/platform.zip
LOCAL_PATH := device/intel/common

TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/fstab

# Location of kernel headers for all Intel projects
TARGET_BOARD_KERNEL_HEADERS := $(LOCAL_PATH)/kernel-headers

# Sets ro.product.board
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_PRODUCT)

# set default console log level
KERNEL_LOGLEVEL ?= 5

BOARD_KERNEL_CMDLINE += \
	loglevel=$(KERNEL_LOGLEVEL) \
	androidboot.hardware=$(TARGET_PRODUCT)

TARGET_CPU_SMP := true

# If signing kernel modules, use the testing BIOS DB key
# Production builds will re-sign them via sign_target_files_apks
TARGET_MODULE_PRIVATE_KEY := device/intel/common/testkeys/bios/DB.key
TARGET_MODULE_CERTIFICATE := device/intel/common/testkeys/bios/DB.DER
TARGET_MODULE_GENKEY := device/intel/common/testkeys/kernel/x509.genkey

# customize the malloced address to be 16-byte aligned.
# Copied from the generic_x86 config.
BOARD_MALLOC_ALIGNMENT := 16

