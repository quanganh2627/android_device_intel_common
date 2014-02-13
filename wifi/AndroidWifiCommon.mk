LOCAL_PATH := $(my-dir)

ifeq ($(strip $(BOARD_HAVE_WIFI)),true)

##################################################
include $(CLEAR_VARS)
LOCAL_MODULE := wifi_common
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=          \
    libwpa_client                  \
    wpa_supplicant                 \
    hostapd                        \
    iw                             \
    init.wifi.rc                   \
    init.wifi.vendor.rc            \
    android.conf                   \
    dhcp_lease_evt.sh              \
    dhcp6c.wlan0.stateless.conf    \
    dhcp6c.wlan0.stateful.conf     \
    wpa_supplicant.conf            \
    p2p_supplicant.conf            \
    hostapd.conf

ifneq (,$(filter $(TARGET_BUILD_VARIANT),eng userdebug))
LOCAL_REQUIRED_MODULES += \
    wifi_wfa \
    wpa_cli
endif

include $(BUILD_PHONY_PACKAGE)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := init.wifi.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := init.wifi.vendor.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
LOCAL_SRC_FILES := init.wifi.$(COMBO_CHIP_VENDOR).rc
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := android.conf
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/dhcpcd
LOCAL_SRC_FILES := android.conf
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := dhcp_lease_evt.sh
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/bin
LOCAL_SRC_FILES := dhcp_lease_evt.sh
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := dhcp6c.wlan0.stateless.conf
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/dhcp6c
LOCAL_SRC_FILES := dhcp6c.wlan0.stateless.conf
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := dhcp6c.wlan0.stateful.conf
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/dhcp6c
LOCAL_SRC_FILES := dhcp6c.wlan0.stateful.conf
include $(BUILD_PREBUILT)

endif
