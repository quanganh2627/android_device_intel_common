# make file for common
#

LOCAL_PATH := $(TOP)/vendor/intel/common
COMMON_PATH := $(TOP)/vendor/intel/common
SUPPORT_PATH:= $(TOP)/vendor/intel/support
ACS_BUILDBOT_PATH := $(TOP)/vendor/intel/PRIVATE/buildbot_acs
ACS_CAMPAIGN_ST_PATH := $(TOP)/vendor/intel/PRIVATE/ST_acs_campaigns
ACS_CAMPAIGN_FT_PATH := $(TOP)/vendor/intel/PRIVATE/FT_acs_campaigns
PERMISSIONS_PATH := $(TOP)/frameworks/native/data/etc

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
MKBOOTIMG := vendor/intel/support/mkbootimg

$(INSTALLED_KERNEL_TARGET): build_kernel
$(INSTALLED_RAMDISK_TARGET): build_kernel

# checkapi is only called if droid is among the cmd goals, or no cmd goal is given
# We add it here to be called for other targets as well
droid: checkapi

flashfiles: bootimage
ifneq ($(FLASHFILE_BOOTONLY),true)
ifeq ($(FLASHFILE_NO_OTA),true)
flashfiles: firmware recoveryimage
else
flashfiles: firmware otapackage recoveryimage
endif
ifeq ($(TARGET_USE_DROIDBOOT),true)
flashfiles: droidbootimage
endif
flashfiles: systemimg_gz
endif

ifeq ($(USE_GMS_ALL),true)
PUBLISH_TARGET_BUILD_VARIANT := $(TARGET_BUILD_VARIANT)_gms
else
PUBLISH_TARGET_BUILD_VARIANT := $(TARGET_BUILD_VARIANT)
endif

TARGET_PUBLISH_PATH ?= $(shell echo $(TARGET_PRODUCT) | tr '[:lower:]' '[:upper:]')
GENERIC_TARGET_NAME ?= $(TARGET_PRODUCT)

flashfiles:
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	GENERIC_TARGET_NAME=$(GENERIC_TARGET_NAME) \
	TARGET_USE_DROIDBOOT=$(TARGET_USE_DROIDBOOT) \
	FLASHFILE_BOOTONLY=$(FLASHFILE_BOOTONLY) \
	FLASHFILE_NO_OTA=$(FLASHFILE_NO_OTA) \
	FLASH_MODEM=$(BOARD_HAVE_MODEM) \
	FLASH_MODEM_DICO=$(BOARD_MODEM_DICO) \
	$(SUPPORT_PATH)/publish_build.py `pwd` $(REF_PRODUCT_NAME) $(TARGET_DEVICE) $(PUBLISH_TARGET_BUILD_VARIANT) $(FILE_NAME_TAG)

ifneq ($(FLASHFILE_BOOTONLY),true)
blank_flashfiles: firmware
ifeq ($(TARGET_USE_DROIDBOOT),true)
blank_flashfiles: droidbootimage
else
blank_flashfiles: recoveryimage
endif
blank_flashfiles:
	$(if $(IFWI_PREBUILT_PATHS), \
		PUBLISH_PATH=$(PUBLISH_PATH) \
		TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
		GENERIC_TARGET_NAME=$(GENERIC_TARGET_NAME) \
		TARGET_USE_DROIDBOOT=$(TARGET_USE_DROIDBOOT) \
		$(SUPPORT_PATH)/publish_build.py `pwd` $(REF_PRODUCT_NAME) $(TARGET_DEVICE) 'blankphone' $(FILE_NAME_TAG), \
		@echo "No IFWI found for this target. No blank flashfile to generate")
else
blank_flashfiles:
	@echo "No blank_flashfiles for this target - FLASHFILE_BOOTONLY set to TRUE"
endif

ifeq ($(BOARD_HAVE_MODEM),true)
publish_modem: modem_nvm modem
endif
publish_modem:
	PUBLISH_PATH=$(PUBLISH_PATH) \
	TARGET_PUBLISH_PATH=$(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH) \
	BOARD_HAVE_MODEM=$(BOARD_HAVE_MODEM) \
	FLASH_MODEM_DICO=$(BOARD_MODEM_DICO) \
	$(SUPPORT_PATH)/publish_build.py `pwd` $(REF_PRODUCT_NAME) $(TARGET_DEVICE) 'modem' $(FILE_NAME_TAG)

publish_system_symbols: systemtarball
	@ echo "Publish system symbols"
	@ mkdir -p $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/fastboot-images/$(TARGET_BUILD_VARIANT)
	tar czf $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/fastboot-images/$(TARGET_BUILD_VARIANT)/symbols.tar.gz $(PRODUCT_OUT)/symbols

publish_kernel_debug: bootimage
	@ echo "Publish kernel config and symbols"
	@ mkdir -p $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/kernel
	cp $(PRODUCT_OUT)/kernel_build/.config $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/kernel/kernel.config
	bzip2 -k $(PRODUCT_OUT)/kernel_build/vmlinux
	mv $(PRODUCT_OUT)/kernel_build/vmlinux.bz2 $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/kernel/

PUBLISH_LINUX_TOOLS_deps := \
	$(HOST_OUT_EXECUTABLES)/adb \
	$(HOST_OUT_EXECUTABLES)/fastboot
publish_linux_tools: $(PUBLISH_LINUX_TOOLS_deps)
	@ echo "Publish linux tools"
	@ mkdir -p $(PUBLISH_TOOLS_PATH)
	(cd out/host/ && cp --parents linux-x86/bin/adb $(PUBLISH_TOOLS_PATH))
	(cd out/host/ && cp --parents linux-x86/bin/fastboot $(PUBLISH_TOOLS_PATH))

publish_acs:
	$(eval ACS_ZIP := $(abspath $(PUBLISH_PATH)/buildbot/acs.zip))
	$(eval RUN_ACS_ZIP := $(abspath $(PUBLISH_PATH)/buildbot/run_acs.zip))
	$(eval ACS_CAMPAIGNS_ZIP := $(abspath $(PUBLISH_PATH)/buildbot/campaigns.zip))
	@ echo "Publish acs tool and buildbot campaigns"
	@ mkdir -p $(PUBLISH_PATH)/buildbot
	(cd $(ACS_BUILDBOT_PATH) && zip -qr $(ACS_ZIP) executable/*)
	(cd $(ACS_BUILDBOT_PATH) && zip -qr $(RUN_ACS_ZIP) run_acs/*)
	(cd $(ACS_BUILDBOT_PATH)/campaigns && zip -qr $(ACS_CAMPAIGNS_ZIP) ./*)
	(cd $(ACS_CAMPAIGN_ST_PATH) && zip -qr $(ACS_CAMPAIGNS_ZIP) ./*)
	(cd $(ACS_CAMPAIGN_FT_PATH) && zip -qr $(ACS_CAMPAIGNS_ZIP) ./*)

# Add sepdk driver
ifneq ($(BOARD_USE_64BIT_KERNEL),true)
# sepdk and vTunes
-include $(TOP)/device/intel/debug_tools/sepdk/src/AndroidSEP.mk
-include $(TOP)/device/intel/debug_tools/sepdk/src/pax/AndroidPAX.mk

ifeq ($(sepdk),1)
$(PRODUCT_OUT)/ramdisk.img : sep
$(PRODUCT_OUT)/ramdisk.img : pax
endif

# Add powerdk driver
-include $(TOP)/device/intel/debug_tools/powerdk/src/AndroidPowerDK.mk

ifeq ($(powerdk),1)
$(PRODUCT_OUT)/ramdisk.img : apwr
endif
endif

$(PRODUCT_OUT)/ramdisk.img: partition_files
