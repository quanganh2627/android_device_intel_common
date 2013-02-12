LOCAL_DIR := $(call my-dir)
include  $(LOCAL_DIR)/AndroidWifiCommon.mk
include  $(LOCAL_DIR)/AndroidWifiTI.mk
include  $(LOCAL_DIR)/AndroidWifiBCM.mk

ifeq (bcm4334,$(COMBO_CHIP))
  include  $(LOCAL_DIR)/AndroidWifiBCM4334.mk
endif

ifeq (bcm4335,$(COMBO_CHIP))
  include  $(LOCAL_DIR)/AndroidWifiBCM4335.mk
endif
