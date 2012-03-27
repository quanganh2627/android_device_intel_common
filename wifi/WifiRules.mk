
COMMON_WIFI_DIR = vendor/intel/common/wifi
LOCAL_COMMON_WIFI_DIR = $(PWD)/$(COMMON_WIFI_DIR)

# wifi configuration file names
STA_CONF_FILE_NAME      = wpa_supplicant.conf
P2P_CONF_FILE_NAME      = p2p_supplicant.conf
HOSTAPD_CONF_FILE_NAME  = hostapd.conf
WIFI_INIT_RC_FILE_NAME  = init.wifi.rc
ifeq ($(strip $(INTEL_WIDI)),true)
WIDI_CONF_FILE_NAME     = widi_supplicant.conf
WIDI_INIT_RC_FILE_NAME  = init.widi.rc
endif

# target paths and names
CONF_PATH_ON_TARGET = system/etc/wifi
STA_CONF_PATH_ON_TARGET       = $(CONF_PATH_ON_TARGET)/$(STA_CONF_FILE_NAME)
P2P_CONF_PATH_ON_TARGET       = $(CONF_PATH_ON_TARGET)/$(P2P_CONF_FILE_NAME)
HOSTAPD_CONF_PATH_ON_TARGET   = $(CONF_PATH_ON_TARGET)/$(HOSTAPD_CONF_FILE_NAME)
ifeq ($(strip $(INTEL_WIDI)),true)
WIDI_CONF_PATH_ON_TARGET = $(CONF_PATH_ON_TARGET)/$(WIDI_CONF_FILE_NAME)
endif

# wifi common configuration files
STA_CONF_FILES      += $(LOCAL_COMMON_WIFI_DIR)/$(STA_CONF_FILE_NAME)
P2P_CONF_FILES      += $(LOCAL_COMMON_WIFI_DIR)/$(P2P_CONF_FILE_NAME)
HOSTAPD_CONF_FILES  += $(LOCAL_COMMON_WIFI_DIR)/$(HOSTAPD_CONF_FILE_NAME)
ifeq ($(strip $(INTEL_WIDI)),true)
WIDI_CONF_FILES     += $(LOCAL_COMMON_WIFI_DIR)/$(WIDI_CONF_FILE_NAME)
endif

# targets names
WIFI_CONF_TARGET = wifi_conf
ifeq ($(strip $(INTEL_WIDI)),true)
WIDI_CONF_TARGET = widi_conf
endif

$(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET):
	mkdir -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	cat $(STA_CONF_FILES) > $(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET)

$(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET):
	mkdir -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	cat $(P2P_CONF_FILES) > $(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET)

$(PRODUCT_OUT)/$(HOSTAPD_CONF_PATH_ON_TARGET):
	mkdir -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	cat $(HOSTAPD_CONF_FILES) > $(PRODUCT_OUT)/$(HOSTAPD_CONF_PATH_ON_TARGET)

ifeq ($(strip $(INTEL_WIDI)),true)
$(PRODUCT_OUT)/$(WIDI_CONF_PATH_ON_TARGET):
	mkdir -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	cat $(WIDI_CONF_FILES) > $(PRODUCT_OUT)/$(WIDI_CONF_PATH_ON_TARGET)
endif

wifi_rc:
	mkdir -p $(PRODUCT_OUT)/root
	cat $(PRODUCT_WIFI_RC_FILES) > $(PRODUCT_OUT)/root/init.wifi.rc

widi_rc:
	mkdir -p $(PRODUCT_OUT)/root
	cat $(PRODUCT_WIDI_RC_FILES) > $(PRODUCT_OUT)/root/init.widi.rc

wifi_conf: $(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET)  \
           $(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET)  \
           $(PRODUCT_OUT)/$(HOSTAPD_CONF_PATH_ON_TARGET) \
           wifi_rc

ifeq ($(strip $(INTEL_WIDI)),true)
widi_conf: $(PRODUCT_OUT)/$(WIDI_CONF_PATH_ON_TARGET) \
           widi_rc
endif

# default wifi
BOARD_WLAN_DEVICE              := wl12xx-compat
BOARD_WPA_SUPPLICANT_DRIVER    := NL80211
WPA_SUPPLICANT_VERSION         := VER_0_8_X
ADDITIONAL_DEFAULT_PROPERTIES  += wifi.interface=wlan0:0

-include $(TOP)/hardware/ti/wlan/wl12xx-compat/AndroidWl12xxCompat.mk
$(PRODUCT_OUT)/ramdisk.img : build_wl12xx-compat

# product copy files
PRODUCT_COPY_FILES += \
   $(PERMISSIONS_PATH)/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
   $(PERMISSIONS_PATH)/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml

# init.xxx.rc
PRODUCT_WIFI_RC_FILES += $(COMMON_WIFI_DIR)/$(WIFI_INIT_RC_FILE_NAME)
ifeq ($(strip $(INTEL_WIDI)),true)
PRODUCT_WIDI_RC_FILES += $(COMMON_WIFI_DIR)/$(WIDI_INIT_RC_FILE_NAME)
endif
