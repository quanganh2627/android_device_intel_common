LOCAL_PATH := $(ANDROID_BUILD_TOP)

BCM_PRIVATE_BT_PATH := device/intel/PRIVATE/fw/bt
BCM4334_BT_FW_PATH := $(BCM_PRIVATE_BT_PATH)/bin
BT_FW_TARGET_PATH := $(TARGET_OUT_ETC)/firmware

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := bt_bcm
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    BCM4334B0_002.001.013.0636.0641_RC.hcd \
    BCM4335A0_001.001.038.0035.0000_TestCfg_Intel_Merrifield.hcd \
    BCM4335B0_002.001.006.0031.0034_RC.hcd \
    bt_common

include $(BUILD_PHONY_PACKAGE)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := BCM4334B0_002.001.013.0636.0641_RC.hcd
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(BT_FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4334_BT_FW_PATH)/BCM4334B0_002.001.013.0636.0641_RC.hcd
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := BCM4335A0_001.001.038.0035.0000_TestCfg_Intel_Merrifield.hcd
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(BT_FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4334_BT_FW_PATH)/BCM4335A0_001.001.038.0035.0000_TestCfg_Intel_Merrifield.hcd
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := BCM4335B0_002.001.006.0031.0034_RC.hcd
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(BT_FW_TARGET_PATH)
LOCAL_SRC_FILES := $(BCM4334_BT_FW_PATH)/BCM4335B0_002.001.006.0031.0034_RC.hcd
include $(BUILD_PREBUILT)

##################################################
