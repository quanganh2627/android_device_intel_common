# ----------------- BEGIN MIX-IN DEFINITIONS -----------------
# Mix-In definitions are auto-generated by mixin-update
##############################################################
# Source: device/intel/mixins/groups/boot-arch/syslinux32/AndroidBoard.mk
##############################################################
SYSLINUX_BIN := $(HOST_OUT_EXECUTABLES)/syslinux
SYSLINUX_BASE := $(HOST_OUT)/usr/lib/syslinux

SYSLINUX_MK_IMG := external/syslinux/utils/android-image.sh

# TARGET_SYSLINUX_FILES - any splash screens, com32 modules
# TARGET_SYSLINUX_CONFIG - file to use as syslinux.cfg
# These should be defined in BoardConfig.mk per-product

ifdef TARGET_SYSLINUX_IMAGE_EXTRA_SPACE
        SYSLINUX_EXTRA_SPACE_PARAM := --extra-size $(TARGET_SYSLINUX_IMAGE_EXTRA_SPACE)
endif

# (pulled from build/core/Makefile as this gets defined much later)
# Pick a reasonable string to use to identify files.
ifneq "" "$(filter eng.%,$(BUILD_NUMBER))"
# BUILD_NUMBER has a timestamp in it, which means that
# it will change every time.  Pick a stable value.
FILE_NAME_TAG := eng.$(USER)
else
FILE_NAME_TAG := $(BUILD_NUMBER)
endif

intermediates := $(call intermediates-dir-for,PACKAGING,bootloader_zip)
bootloader_zip := $(intermediates)/bootloader.zip
$(bootloader_zip): intermediates := $(intermediates)
$(bootloader_zip): syslinux_root := $(intermediates)/root
$(bootloader_zip): \
		$(TARGET_DEVICE_DIR)/AndroidBoard.mk \
		$(TARGET_SYSLINUX_FILES) \
		$(TARGET_SYSLINUX_CONFIG) \
		| $(ACP) \

	$(hide) rm -rf $(syslinux_root)
	$(hide) rm -f $@
	$(hide) mkdir -p $(syslinux_root)
	$(hide) $(ACP) $(TARGET_SYSLINUX_FILES) $(syslinux_root)/
	$(hide) $(ACP) $(TARGET_SYSLINUX_CONFIG) $(syslinux_root)/syslinux.cfg
	$(hide) (cd $(syslinux_root) && zip -qry ../$(notdir $@) .)

bootloader_metadata := $(intermediates)/bootloader-size.txt
$(bootloader_metadata):
	$(hide) mkdir -p $(dir $@)
	$(hide) echo $(BOARD_BOOTLOADER_PARTITION_SIZE) > $@

INSTALLED_RADIOIMAGE_TARGET += $(BOARD_GPT_INI) $(BOARD_MBR_BLOCK_BIN) $(bootloader_zip) $(bootloader_metadata)

bootloader_bin := $(PRODUCT_OUT)/bootloader
$(bootloader_bin): \
		$(TARGET_SYSLINUX_FILES) \
		$(TARGET_SYSLINUX_CONFIG) \
		$(SYSLINUX_BIN) \
		$(SYSLINUX_MK_IMG) \

	$(call pretty, "Target SYSLINUX image: $@")
	$(SYSLINUX_MK_IMG) $(SYSLINUX_EXTRA_SPACE_PARAM) \
		--syslinux $(SYSLINUX_BIN) \
	        --tmpdir $(call intermediates-dir-for,EXECUTABLES,syslinux-img)/syslinux-img \
		--config $(TARGET_SYSLINUX_CONFIG) \
		--output $@ \
		$(TARGET_SYSLINUX_FILES)

droidcore: $(bootloader_bin)

.PHONY: bootloader
bootloader: $(bootloader_bin)

$(call dist-for-goals,droidcore,$(bootloader_bin):$(TARGET_PRODUCT)-bootloader-$(FILE_NAME_TAG))


fastboot_usb_root := $(PRODUCT_OUT)/fastboot-usb
fastboot_usb_bin := $(PRODUCT_OUT)/fastboot-usb.img
fastboot_bin := $(PRODUCT_OUT)/fastboot.img
$(fastboot_usb_bin): \
		$(INSTALLED_KERNEL_TARGET) \
		$(PRODUCT_OUT)/userfastboot/ramdisk-fastboot.img.gz \
		$(TARGET_SYSLINUX_FILES) \
		$(TARGET_SYSLINUX_USB_CONFIG) \
		$(HOST_OUT_EXECUTABLES)/isohybrid \
		| $(ACP) \

	$(hide) rm -rf $(fastboot_usb_root)
	$(hide) mkdir -p $(fastboot_usb_root)
	$(hide) $(ACP) -f $(PRODUCT_OUT)/userfastboot/ramdisk-fastboot.img.gz $(fastboot_usb_root)/ramdisk.img
	$(hide) $(ACP) -f $(INSTALLED_KERNEL_TARGET) $(fastboot_usb_root)/kernel
	$(hide) mkdir -p $(fastboot_usb_root)/isolinux
	$(hide) $(ACP) -f $(TARGET_SYSLINUX_FILES) $(fastboot_usb_root)/isolinux
	$(hide) $(ACP) -f $(TARGET_SYSLINUX_USB_CONFIG) $(fastboot_usb_root)/isolinux/isolinux.cfg
	$(hide) genisoimage -vJURT -b isolinux/isolinux.bin -c isolinux/boot.cat \
		-no-emul-boot -boot-load-size 4 -boot-info-table \
		-input-charset utf-8 -V "Fastboot USB" \
		-o $@ $(fastboot_usb_root)
	$(hide) $(HOST_OUT_EXECUTABLES)/isohybrid $@

droidcore: $(fastboot_bin) $(fastboot_usb_bin)

.PHONY: userfastboot-usb
userfastboot-usb: $(fastboot_usb_bin)

$(call dist-for-goals,droidcore,$(fastboot_usb_bin):$(TARGET_PRODUCT)-fastboot-usb-$(FILE_NAME_TAG).img)

INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/fastboot.img

##############################################################
# Source: device/intel/mixins/groups/kernel/gmin64/AndroidBoard.mk
##############################################################

ifeq ($(BUILD_KERNEL_FROM_SOURCES),1)
# Build kernel from sources

# Force using bash as a shell, otherwise, on Ubuntu, dash will break some
# dependency due to its bad handling of echo \1
MAKE += SHELL=/bin/bash

#default source and .config set to gmin kernel
KERNEL_SRC_DIR ?= kernel/gmin
KERNEL_DEFCONFIG ?= kernel/gmin-quilt-representation/uefi/gmin/$(TARGET_KERNEL_ARCH).config

ifeq ($(TARGET_KERNEL_ARCH),x86_64)
KERNEL_TOOLCHAIN_ARCH := $(TARGET_KERNEL_ARCH)
else
KERNEL_TOOLCHAIN_ARCH := i686
endif
KERNEL_EXTRA_FLAGS := ANDROID_TOOLCHAIN_FLAGS=-mno-android
KERNEL_CROSS_COMP := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/host/$(KERNEL_TOOLCHAIN_ARCH)-linux-glibc2.11-4.8/bin/$(KERNEL_TOOLCHAIN_ARCH)-linux-

KERNEL_CCACHE :=$(firstword $(TARGET_CC))

ifeq ($(notdir $(KERNEL_CCACHE)),ccache)
KERNEL_CROSS_COMP := "ccache $(KERNEL_CROSS_COMP)"
KERNEL_PATH := $(ANDROID_BUILD_TOP)/$(dir $(KERNEL_CCACHE))
endif

#remove time_macros from ccache options, it breaks signing process
KERNEL_CCSLOP := $(filter-out time_macros,$(subst $(comma), ,$(CCACHE_SLOPPINESS)))
KERNEL_CCSLOP := $(subst $(space),$(comma),$(KERNEL_CCSLOP))

KERNEL_OUT_DIR := $(PRODUCT_OUT)/linux/kernel/gmin

KERNEL_MODINSTALL := modules_install
KERNEL_OUT_MODINSTALL := $(PRODUCT_OUT)/linux/kernel/$(KERNEL_MODINSTALL)
KERNEL_MODULES_ROOT := $(PRODUCT_OUT)/system/lib/modules
KERNEL_CONFIG := $(KERNEL_OUT_DIR)/.config

KERNEL_BLD_FLAGS := \
    ARCH=$(TARGET_KERNEL_ARCH) \
    INSTALL_MOD_PATH=../$(KERNEL_MODINSTALL) \
    INSTALL_MOD_STRIP=1 \
    DEPMOD=_fake_does_not_exist_ \
    $(KERNEL_EXTRA_FLAGS)

KERNEL_BLD_FLAGS :=$(KERNEL_BLD_FLAGS) \
     O=../../$(KERNEL_OUT_DIR) \

KERNEL_BLD_ENV := CROSS_COMPILE=$(KERNEL_CROSS_COMP) \
    PATH=$(KERNEL_PATH):$(PATH) \
    CCACHE_SLOPPINESS=$(KERNEL_CCSLOP)

KERNEL_VERSION_FILE := $(KERNEL_OUT_DIR)/include/config/kernel.release
KERNEL_BZIMAGE := $(PRODUCT_OUT)/kernel

HOST_OPENSSL := $(HOST_OUT_EXECUTABLES)/openssl

$(KERNEL_CONFIG): $(KERNEL_DEFCONFIG)
	@echo Regenerating kernel config $(KERNEL_OUT_DIR)
	@mkdir -p $(KERNEL_OUT_DIR)
	@cat $^ > $@
	@$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS) olddefconfig

$(KERNEL_BZIMAGE): $(KERNEL_CONFIG) $(HOST_OPENSSL) $(MINIGZIP)
	@$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS)
	@cp -f $(KERNEL_OUT_DIR)/arch/x86/boot/bzImage $@

kernel: $(KERNEL_BZIMAGE)
	@mkdir -p $(KERNEL_OUT_MODINSTALL)
	@$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS) modules_install
	@$(RM) -rf $(KERNEL_MODULES_ROOT)
	@mkdir -p $(KERNEL_MODULES_ROOT)
	@find $(KERNEL_OUT_MODINSTALL)/lib/modules/`cat $(KERNEL_VERSION_FILE)` -name "*.ko" -exec cp -f {} $(KERNEL_MODULES_ROOT)/ \;

clean_kernel:
	@$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS) clean

menuconfig xconfig gconfig: $(KERNEL_CONFIG)
	@$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS) $@
	@cp -f $(KERNEL_CONFIG) $(KERNEL_DEFCONFIG)
	@echo ===========
	@echo $(KERNEL_DEFCONFIG) has been modified !
	@echo ===========

TAGS_files := TAGS
tags_files := tags
gtags_files := GTAGS GPATH GRTAGS GSYMS
cscope_files := $(addprefix cscope.,files out out.in out.po)

TAGS tags gtags cscope: $(KERNEL_CONFIG)
	@$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS) $@
	@rm -f $(KERNEL_SRC_DIR)/$($@_files)
	@cp -fs $(addprefix `pwd`/$(KERNEL_OUT_DIR)/,$($@_files)) $(KERNEL_SRC_DIR)/

#used to build out-of-tree kernel modules
#$(1) is source path relative Android top, $(2) is module name
#$(3) is extra flags

define build_kernel_module
.PHONY: $(2)

$(2): $(KERNEL_BZIMAGE)
	@echo Building kernel module $(2) in $(1)
	@mkdir -p $(KERNEL_OUT_DIR)/../../$(1)
	@+$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS) M=../../$(1) $(3)

$(2)_install: $(2)
	@+$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS) M=../../$(1) $(3) modules_install

$(2)_clean:
	@echo Cleaning kernel module $(2) in $(1)
	@$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS) M=../../$(1) clean

$(addprefix $(2)_,TAGS tags gtags cscope): $(KERNEL_CONFIG)
	@$(KERNEL_BLD_ENV) $(MAKE) -C $(KERNEL_SRC_DIR) $(KERNEL_BLD_FLAGS) M=../../$(1) $$(subst $(2)_,,$$@)
	@rm -f $(1)/$$($$(subst $(2)_,,$$@)_files)
	@cp -fs $$(addprefix `pwd`/$(KERNEL_OUT_DIR)/,$$($$(subst $(2)_,,$$@)_files)) $(1)/

kernel: $(2)_install
clean_kernel: $(2)_clean
endef

.PHONY: menuconfig xconfig gconfig
.PHONY: kernel $(KERNEL_BZIMAGE)

$(PRODUCT_OUT)/boot.img: $(KERNEL_BZIMAGE)
#kernel modules are installed in system
$(PRODUCT_OUT)/system.img: kernel


# export kernel binaries the way gmin does
KERNEL_PREBUILTS_DIR := device/intel/gmin-kernel/$(TARGET_KERNEL_ARCH)
kernel_prebuilts: kernel
	@rm -rf $(KERNEL_PREBUILTS_DIR)
	@mkdir -p $(KERNEL_PREBUILTS_DIR)
	@cp $(KERNEL_CONFIG) $(KERNEL_PREBUILTS_DIR)/config
	@cp $(KERNEL_BZIMAGE) $(KERNEL_PREBUILTS_DIR)/bzImage
	@cp $(KERNEL_OUT_DIR)/System.map $(KERNEL_PREBUILTS_DIR)/
	@cp $(KERNEL_OUT_DIR)/vmlinux $(KERNEL_PREBUILTS_DIR)/
	@git --git-dir=$(KERNEL_SRC_DIR)/.git log -n 1 > $(KERNEL_PREBUILTS_DIR)/source.sha1
	@mkdir -p $(KERNEL_PREBUILTS_DIR)/modules
	@MODULES_OUT=$(KERNEL_PREBUILTS_DIR)/lib/modules/`cat $(KERNEL_VERSION_FILE)`; \
	mkdir -p $${MODULES_OUT} && \
	cp $(KERNEL_MODULES_ROOT)/*.ko $${MODULES_OUT}/ && \
	cd $(KERNEL_PREBUILTS_DIR)/modules && \
	cp -s ../lib/modules/*/*.ko .
endif
# ------------------ END MIX-IN DEFINITIONS ------------------
