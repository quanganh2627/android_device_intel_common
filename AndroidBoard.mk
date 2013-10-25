# make file for common
#
LOCAL_PATH := $(TOP)/device/intel/common
COMMON_PATH := $(TOP)/device/intel/common
SUPPORT_PATH:= $(TOP)/vendor/intel/support
ACS_BUILDBOT_PATH := $(TOP)/vendor/intel/PRIVATE/buildbot_acs
PERMISSIONS_PATH := $(TOP)/frameworks/native/data/etc

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

# MKBOOTIMG is the tool that is used by AOSP build system to
# stitch kernel. We overide the default script to
# adapt to out own IAFW format.
ifeq ($(TARGET_PARTITIONING_SCHEME),"osip-gpt")
MKBOOTIMG := vendor/intel/support/mkbootimg
endif

# Intel Signing Utility and xfstk-stitcher, required by mkbootimg to sign images.
# Add dependancy on ISU packages only if ISU method is used as ISU might not be delivered.
ifeq ($(TARGET_OS_SIGNING_METHOD),ISU)
$(MKBOOTIMG): isu isu_stream
endif
$(MKBOOTIMG): xfstk-stitcher

# If the kernel source is present, AndroidBoard.mk will perform a kernel build.
# otherwise, AndroidBoard.mk will find the kernel binaries in a tarball.
ifneq ($(wildcard $(KERNEL_SRC_DIR)/Makefile),)
TARGET_KERNEL_SOURCE_IS_PRESENT ?= true
endif

.PHONY: build_kernel
ifeq ($(TARGET_KERNEL_SOURCE_IS_PRESENT),true)
#Kernel rules (build from source, or from tarball
include $(COMMON_PATH)/AndroidKernel.mk
build_kernel: get_kernel_from_source
else
build_kernel: get_kernel_from_tarball
endif

.PHONY: get_kernel_from_tarball
get_kernel_from_tarball:
	tar -xv -C $(PRODUCT_OUT) -f $(TARGET_KERNEL_TARBALL)

bootimage: build_kernel

$(INSTALLED_KERNEL_TARGET): build_kernel
$(INSTALLED_RAMDISK_TARGET): build_kernel

# checkapi is only called if droid is among the cmd goals, or no cmd goal is given
# We add it here to be called for other targets as well
#droid: checkapi

fastboot_flashfile: bootimage

ifeq ($(TARGET_USERIMAGES_SPARSE_EXT_DISABLED),true)
TARGET_SYSTEM := systemimg_gz
else
TARGET_SYSTEM := systemimage
endif

ifeq ($(ENABLE_FRU),yes)
bootimage: build_fru
endif
ifneq ($(FLASHFILE_BOOTONLY),true)
fastboot_flashfile: firmware recoveryimage
ifeq ($(TARGET_USE_DROIDBOOT),true)
fastboot_flashfile: droidbootimage
endif
fastboot_flashfile: $(TARGET_SYSTEM)
endif
ifeq ($(TARGET_BIOS_TYPE),"uefi")
fastboot_flashfile: espimage
endif

ifeq ($(USE_GMS_ALL),true)
PUBLISH_TARGET_BUILD_VARIANT := $(TARGET_BUILD_VARIANT)_gms
else
PUBLISH_TARGET_BUILD_VARIANT := $(TARGET_BUILD_VARIANT)
endif

TARGET_PUBLISH_PATH ?= $(shell echo $(TARGET_PRODUCT) | tr '[:lower:]' '[:upper:]')
GENERIC_TARGET_NAME ?= $(TARGET_PRODUCT)

.PHONY: flashfiles
flashfiles: fastboot_flashfile ota_flashfile

.PHONY: fastboot_flashfile
fastboot_flashfile:
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	GENERIC_TARGET_NAME=$(GENERIC_TARGET_NAME) \
	TARGET_USE_DROIDBOOT=$(TARGET_USE_DROIDBOOT) \
	FLASHFILE_BOOTONLY=$(FLASHFILE_BOOTONLY) \
	FLASHFILE_NO_OTA=$(FLASHFILE_NO_OTA) \
	FLASH_MODEM=$(BOARD_HAVE_MODEM) \
	SKIP_NVM=$(BOARD_SKIP_NVM) \
	ULPMC_BINARY=$(ULPMC_BINARY) \
	TARGET_BIOS_TYPE=$(TARGET_BIOS_TYPE) \
	SPARSE_DISABLED=$(TARGET_USERIMAGES_SPARSE_EXT_DISABLED) \
	$(SUPPORT_PATH)/publish_build.py '$@' `pwd` $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG) $(TARGET_BOARD_SOC)

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
	SKIP_NVM=$(BOARD_SKIP_NVM) \
	FLASH_MODEM_DICO=$(BOARD_MODEM_DICO) \
	TARGET_BIOS_TYPE=$(TARGET_BIOS_TYPE) \
	ULPMC_BINARY=$(ULPMC_BINARY) \
	SPARSE_DISABLED=$(TARGET_USERIMAGES_SPARSE_EXT_DISABLED) \
	$(SUPPORT_PATH)/publish_build.py '$@' `pwd` $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG) $(TARGET_BOARD_SOC)
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
	TARGET_BIOS_TYPE=$(TARGET_BIOS_TYPE) \
	ULPMC_BINARY=$(ULPMC_BINARY) \
	BOARD_GPFLAG=$(BOARD_GPFLAG) \
	$(SUPPORT_PATH)/publish_build.py 'blankphone' `pwd` $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG) $(TARGET_BOARD_SOC)
else
blank_flashfiles:
	@echo "No blank_flashfiles for this target - FLASHFILE_BOOTONLY set to TRUE"
endif

ifeq ($(BOARD_HAVE_MODEM),true)
publish_modem: modem
ifneq (,$(filter modem_nvm, $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
publish_modem: modem_nvm
endif
endif
publish_modem:
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	BOARD_HAVE_MODEM=$(BOARD_HAVE_MODEM) \
	SKIP_NVM=$(BOARD_SKIP_NVM) \
	$(SUPPORT_PATH)/publish_build.py 'modem' `pwd` $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG) $(TARGET_BOARD_SOC)

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

publish_acs:
ifneq ($(wildcard $(ACS_BUILDBOT_PATH)),)
publish_acs:
	$(eval ACS_ZIP := $(abspath $(PUBLISH_PATH)/buildbot/acs.zip))
	$(eval RUN_ACS_ZIP := $(abspath $(PUBLISH_PATH)/buildbot/run_acs.zip))
	$(eval ACS_CAMPAIGNS_ZIP := $(abspath $(PUBLISH_PATH)/buildbot/campaigns.zip))
	@ echo "Publish acs tool and buildbot campaigns"
	@ mkdir -p $(PUBLISH_PATH)/buildbot
	(cd $(ACS_BUILDBOT_PATH) && zip -qr $(ACS_ZIP) executable/*)
	(cd $(ACS_BUILDBOT_PATH) && zip -qr $(RUN_ACS_ZIP) run_acs/*)
	(cd $(ACS_BUILDBOT_PATH)/campaigns && zip -qr $(ACS_CAMPAIGNS_ZIP) ./*)
endif

# Add sepdk driver
ifneq ($(BOARD_USE_64BIT_KERNEL),true)
# sepdk and vTunes
-include $(TOP)/vendor/intel/tools/PRIVATE/debug_internal_tools/sepdk/src/AndroidSEP.mk
-include $(TOP)/linux/modules/debug_tools/vtunedk/src/pax/AndroidPAX.mk

# Add vtunedk: sep3_xx, vtsspp drivers. PAX driver will be used from sepdk.
-include $(TOP)/linux/modules/debug_tools/vtunedk/src/AndroidSEP.mk
-include $(TOP)/linux/modules/debug_tools/vtunedk/src/vtsspp/AndroidVTSSPP.mk

# KCT Crashtool kernel module
ifneq (, $(findstring "$(TARGET_BUILD_VARIANT)", "eng" "userdebug"))
-include $(TOP)/vendor/intel/hardware/PRIVATE/monitor/ksrc/AndroidKCT.mk
endif

endif
