# make file for common
#

LOCAL_PATH := $(call my-dir)
ACS_BUILDBOT_PATH := vendor/intel/PRIVATE/buildbot_acs
PERMISSIONS_PATH := frameworks/native/data/etc

include $(LOCAL_PATH)/util.mk
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

# checkapi is only called if droid is among the cmd goals, or no cmd goal is given
# We add it here to be called for other targets as well
#droid: checkapi

FASTBOOT_FLASHFILE_DEPS := bootimage

ifeq ($(TARGET_USERIMAGES_SPARSE_EXT_DISABLED),true)
TARGET_SYSTEM := systemimg_gz
else
TARGET_SYSTEM := systemimage
endif

ifeq ($(ENABLE_FRU),yes)
bootimage: build_fru
endif
ifneq ($(FLASHFILE_BOOTONLY),true)
FASTBOOT_FLASHFILE_DEPS += firmware recoveryimage
ifeq ($(TARGET_USE_DROIDBOOT),true)
FASTBOOT_FLASHFILE_DEPS += droidbootimage
endif
FASTBOOT_FLASHFILE_DEPS += $(TARGET_SYSTEM)
endif
ifeq ($(TARGET_BIOS_TYPE),"uefi")
FASTBOOT_FLASHFILE_DEPS += espimage
endif

#ifeq ($(USE_GMS_ALL),true)
#PUBLISH_TARGET_BUILD_VARIANT := $(TARGET_BUILD_VARIANT)_gms
#else
PUBLISH_TARGET_BUILD_VARIANT := $(TARGET_BUILD_VARIANT)
#endif

TARGET_PUBLISH_PATH ?= $(shell echo $(TARGET_PRODUCT) | tr '[:lower:]' '[:upper:]')
GENERIC_TARGET_NAME ?= $(TARGET_PRODUCT)

.PHONY: flashfiles
flashfiles: fastboot_flashfile ota_flashfile

.PHONY: fastboot_flashfile
fastboot_flashfile: $(FASTBOOT_FLASHFILE_DEPS)
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	GENERIC_TARGET_NAME=$(GENERIC_TARGET_NAME) \
	TARGET_USE_DROIDBOOT=$(TARGET_USE_DROIDBOOT) \
	FLASHFILE_BOOTONLY=$(FLASHFILE_BOOTONLY) \
	FLASHFILE_NO_OTA=$(FLASHFILE_NO_OTA) \
	FLASH_MODEM=$(BOARD_HAVE_MODEM) \
	ULPMC_BINARY=$(ULPMC_BINARY) \
	TARGET_BIOS_TYPE=$(TARGET_BIOS_TYPE) \
	SPARSE_DISABLED=$(TARGET_USERIMAGES_SPARSE_EXT_DISABLED) \
	$(SUPPORT_PATH)/publish_build.py '$@' $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG) $(TARGET_BOARD_SOC) $(TARGET_USE_XEN)

.PHONY: flashfiles_nozip
flashfiles_nozip: $(FASTBOOT_FLASHFILE_DEPS)
	FLASHFILE_ZIP=0 \
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	GENERIC_TARGET_NAME=$(GENERIC_TARGET_NAME) \
	TARGET_USE_DROIDBOOT=$(TARGET_USE_DROIDBOOT) \
	FLASHFILE_BOOTONLY=$(FLASHFILE_BOOTONLY) \
	FLASHFILE_NO_OTA=$(FLASHFILE_NO_OTA) \
	FLASH_MODEM=$(BOARD_HAVE_MODEM) \
	ULPMC_BINARY=$(ULPMC_BINARY) \
	TARGET_BIOS_TYPE=$(TARGET_BIOS_TYPE) \
	SPARSE_DISABLED=$(TARGET_USERIMAGES_SPARSE_EXT_DISABLED) \
	$(SUPPORT_PATH)/publish_build.py 'fastboot_flashfile' $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG) $(TARGET_BOARD_SOC) $(TARGET_USE_XEN)

# Buildbot override to force OTA on UI demand (maintainers/engineering builds)
ifeq ($(FORCE_OTA),true)
override FLASHFILE_NO_OTA:=false
endif

.PHONY: ota_flashfile
ifneq (,$(filter true,$(FLASHFILE_NO_OTA) $(FLASHFILE_BOOTONLY)))
ota_flashfile:
	@echo "Do not generate ota_flashfile"
else
ifeq ($(TARGET_BIOS_TYPE),"uefi")
ota_flashfile: espimage
endif
ota_flashfile: otapackage
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	GENERIC_TARGET_NAME=$(GENERIC_TARGET_NAME) \
	TARGET_USE_DROIDBOOT=$(TARGET_USE_DROIDBOOT) \
	FLASHFILE_BOOTONLY=$(FLASHFILE_BOOTONLY) \
	FLASHFILE_NO_OTA=$(FLASHFILE_NO_OTA) \
	FLASH_MODEM=$(BOARD_HAVE_MODEM) \
	BOARD_MODEM_FLASHLESS=$(BOARD_MODEM_FLASHLESS) \
	FLASH_MODEM_DICO=$(BOARD_MODEM_DICO) \
	TARGET_BIOS_TYPE=$(TARGET_BIOS_TYPE) \
	ULPMC_BINARY=$(ULPMC_BINARY) \
	SPARSE_DISABLED=$(TARGET_USERIMAGES_SPARSE_EXT_DISABLED) \
	$(SUPPORT_PATH)/publish_build.py '$@' $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG) $(TARGET_BOARD_SOC) $(TARGET_USE_XEN)
endif #$(FLASHFILE_NO_OTA) || $(FLASHFILE_BOOTONLY)

ifneq ($(FLASHFILE_BOOTONLY),true)
blank_flashfiles: firmware
ifeq ($(TARGET_USE_DROIDBOOT),true)
blank_flashfiles: droidbootimage
else
blank_flashfiles: recoveryimage
endif
ifeq ($(TARGET_BIOS_TYPE),"uefi")
blank_flashfiles: espimage
endif
.PHONY: blank_flashfiles
blank_flashfiles:
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	GENERIC_TARGET_NAME=$(GENERIC_TARGET_NAME) \
	TARGET_USE_DROIDBOOT=$(TARGET_USE_DROIDBOOT) \
	FRU_CONFIGS=$(FRU_CONFIGS) \
	FRU_TOKEN_DIR=$(FRU_TOKEN_DIR) \
	TARGET_BIOS_TYPE=$(TARGET_BIOS_TYPE) \
	ULPMC_BINARY=$(ULPMC_BINARY) \
	CONFIG_LIST="$(CONFIG_LIST)" \
	BOARD_GPFLAG=$(BOARD_GPFLAG) \
	$(SUPPORT_PATH)/publish_build.py 'blankphone' $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG) $(TARGET_BOARD_SOC) $(TARGET_USE_XEN)
else
blank_flashfiles:
	@echo "No blank_flashfiles for this target - FLASHFILE_BOOTONLY set to TRUE"
endif

ifeq ($(BOARD_HAVE_MODEM),true)
publish_modem: modem
endif
publish_modem:
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	BOARD_HAVE_MODEM=$(BOARD_HAVE_MODEM) \
	$(SUPPORT_PATH)/publish_build.py 'modem' $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG) $(TARGET_BOARD_SOC) $(TARGET_USE_XEN)

publish_system_symbols: systemtarball
	@ echo "Publish system symbols"
	@ mkdir -p $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/fastboot-images/$(TARGET_BUILD_VARIANT)
	tar czf $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/fastboot-images/$(TARGET_BUILD_VARIANT)/symbols.tar.gz $(PRODUCT_OUT)/symbols

publish_kernel_debug: bootimage
	@ echo "Publish kernel config and symbols"
	@ mkdir -p $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/kernel
	cp $(PRODUCT_OUT)/linux/kernel/.config $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/kernel/kernel.config
	bzip2 -k $(PRODUCT_OUT)/linux/kernel/vmlinux
	mv $(PRODUCT_OUT)/linux/kernel/vmlinux.bz2 $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/kernel/

PUBLISH_LINUX_TOOLS_deps := \
	$(HOST_OUT_EXECUTABLES)/adb \
	$(HOST_OUT_EXECUTABLES)/fastboot
publish_linux_tools: $(PUBLISH_LINUX_TOOLS_deps)
	@ echo "Publish linux tools"
	@ mkdir -p $(PUBLISH_TOOLS_PATH)
	(cd out/host/ && cp --parents linux-x86/bin/adb $(PUBLISH_TOOLS_PATH))
	(cd out/host/ && cp --parents linux-x86/bin/fastboot $(PUBLISH_TOOLS_PATH))

# Add sepdk driver
-include vendor/intel/tools/PRIVATE/debug_internal_tools/sepdk/src/AndroidSEP.mk
-include linux/modules/debug_tools/vtunedk/src/pax/AndroidPAX.mk

# Add vtunedk: sep3_xx, vtsspp drivers. PAX driver will be used from sepdk.
-include linux/modules/debug_tools/vtunedk/src/AndroidSEP.mk
-include linux/modules/debug_tools/vtunedk/src/vtsspp/AndroidVTSSPP.mk
