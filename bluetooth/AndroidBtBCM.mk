LOCAL_PATH := $(ANDROID_BUILD_TOP)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := bt_bcm
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    BCM4334B0_002.001.013.0636.0641_RC.hcd \
    BCM4335A0_001.001.038.0035.0000_TestCfg_Intel_Merrifield.hcd \
    BCM4335B0_002.001.006.0031.0034_RC.hcd \
    BCM43241B0_0082_Intel_BayTrail_TEST.hcd \
    bt_common

include $(BUILD_PHONY_PACKAGE)

##################################################
