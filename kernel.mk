# This is to be able to build the kernel without parsing all Android.mk
# Prerequisite : a whole repo with the target built at least once
# Use make -f device/intel/common/kernel.mk from "repo top" to rebuild kernel.

# default target, build bzImage and install modules
all: copy_modules_to_root
	@echo kernel build done

openssl:
	@echo fake openssl

# include settings from android build system
# ANDROID_PRODUCT_OUT is set with lunch command
include $(ANDROID_PRODUCT_OUT)/linux/kernel/android_config.mk

include device/intel/common/AndroidKernel.mk

