include device/intel/common/common.mk

PRODUCT_NAME := pc_generic
PRODUCT_DEVICE := pc_generic
PRODUCT_MODEL := Generic Intel PC

LOCAL_PATH := device/intel/common/pc_generic

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/init.rc:root/init.$(TARGET_PRODUCT).rc \
        $(LOCAL_PATH)/init.recovery.rc:root/init.recovery.$(TARGET_PRODUCT).rc

$(call inherit-mixin, cpu-arch, x86)
$(call inherit-mixin, gms, false)
$(call inherit-mixin, houdini, true)
$(call inherit-mixin, boot-arch, efi)
$(call inherit-mixin, graphics, software)
$(call inherit-mixin, ethernet, static)
$(call inherit-mixin, storage, no_sdcard)
$(call inherit-mixin, fastboot, userfastboot)

