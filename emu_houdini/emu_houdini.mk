$(call add-mixin-basedir, device/intel/mixins)

# Superclass
$(call inherit-product, build/target/product/aosp_x86.mk)

LOCAL_PATH := device/intel/common/emu_houdini

PRODUCT_NAME := emu_houdini

$(call inherit-mixin, gms, true)
$(call inherit-mixin, houdini, true)
$(call inherit-mixin, cpu-arch, x86)
$(call inherit-mixin, boot-arch, none)
$(call inherit-mixin, graphics, software)

