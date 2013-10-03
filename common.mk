# Product-makefile directives applicable for ALL Android
# devices that Intel may build. Be careful what you put here,
# it may be more appropriate to make your change in a board
# or product level file.

# Base AOSP configuration. Phone products will want to also
# inherit aosp_base_telephony.mk. At the moment we can't do
# this from a mix-in.
$(call inherit-product, build/target/product/aosp_base.mk)

# Base directory for mixin implementations
$(call add-mixin-basedir, device/intel/mixins)

LOCAL_PATH := device/intel/common

PRODUCT_MANUFACTURER := Intel

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip \
	$(LOCAL_PATH)/init.common.rc:root/init.common.rc \
	$(LOCAL_PATH)/init.recovery.common.rc:root/init.recovery.common.rc \
	$(LOCAL_PATH)/fstab:root/fstab.$(TARGET_PRODUCT) \

