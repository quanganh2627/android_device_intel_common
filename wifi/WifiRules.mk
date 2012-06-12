####################################
# Paths declaration
####################################

COMMON_WIFI_DIR = vendor/intel/common/wifi
LOCAL_COMMON_WIFI_DIR = $(PWD)/$(COMMON_WIFI_DIR)

####################################
# Configuration filenames
####################################

STA_CONF_FILE_NAME      = wpa_supplicant.conf
P2P_CONF_FILE_NAME      = p2p_supplicant.conf
HOSTAPD_CONF_FILE_NAME  = hostapd.conf
WIFI_INIT_RC_FILE_NAME  = init.wifi.rc
ifeq ($(strip $(INTEL_WIDI)),true)
WIDI_CONF_FILE_NAME     = widi_supplicant.conf
WIDI_INIT_RC_FILE_NAME  = init.widi.rc
endif

####################################
# Files path on target
####################################

CONF_PATH_ON_TARGET = system/etc/wifi
STA_CONF_PATH_ON_TARGET       = $(CONF_PATH_ON_TARGET)/$(STA_CONF_FILE_NAME)
P2P_CONF_PATH_ON_TARGET       = $(CONF_PATH_ON_TARGET)/$(P2P_CONF_FILE_NAME)
HOSTAPD_CONF_PATH_ON_TARGET   = $(CONF_PATH_ON_TARGET)/$(HOSTAPD_CONF_FILE_NAME)
ifeq ($(strip $(INTEL_WIDI)),true)
WIDI_CONF_PATH_ON_TARGET = $(CONF_PATH_ON_TARGET)/$(WIDI_CONF_FILE_NAME)
endif

####################################
# Configuration files
####################################

# common configuration files
STA_CONF_FILES      += $(LOCAL_COMMON_WIFI_DIR)/$(STA_CONF_FILE_NAME)
P2P_CONF_FILES      += $(LOCAL_COMMON_WIFI_DIR)/$(P2P_CONF_FILE_NAME)
HOSTAPD_CONF_FILES  += $(LOCAL_COMMON_WIFI_DIR)/$(HOSTAPD_CONF_FILE_NAME)
ifeq ($(strip $(INTEL_WIDI)),true)
WIDI_CONF_FILES     += $(LOCAL_COMMON_WIFI_DIR)/$(WIDI_CONF_FILE_NAME)
endif

####################################
# Product files to copy
####################################

# common product files to copy
PRODUCT_COPY_FILES += \
   $(PERMISSIONS_PATH)/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
   $(PERMISSIONS_PATH)/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml

# manufacturer specific files to copy
ifeq ($(BOARD_WLAN_DEVICE),wl12xx-compat)
PRODUCT_COPY_FILES += \
        $(wildcard $(VARIANT_PATH)/wifi/TQS*ini):system/etc/wifi/TQS.ini
endif

####################################
# init files
####################################

PRODUCT_WIFI_RC_FILES += \
	$(COMMON_WIFI_DIR)/$(WIFI_INIT_RC_FILE_NAME)

ifeq ($(strip $(INTEL_WIDI)),true)
PRODUCT_WIDI_RC_FILES += \
	 $(COMMON_WIFI_DIR)/$(WIDI_INIT_RC_FILE_NAME)
endif

####################################
# Includes
####################################

ifeq ($(BOARD_WLAN_DEVICE),wl12xx-compat)
-include $(TOP)/hardware/ti/wlan/wl12xx-compat/AndroidWl12xxCompat.mk
endif

####################################
# Rules and targets
####################################

# targets names
WIFI_CONF_TARGET = wifi_conf
WIFI_RC_TARGET   = wifi_rc
ifeq ($(strip $(INTEL_WIDI)),true)
WIDI_CONF_TARGET = widi_conf
WIDI_RC_TARGET   = widi_rc
endif

# common targets and rules
$(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET):
	mkdir -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	cat $(STA_CONF_FILES) > $(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET)

$(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET):
	mkdir -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	cat $(P2P_CONF_FILES) > $(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET)

$(PRODUCT_OUT)/$(HOSTAPD_CONF_PATH_ON_TARGET):
	mkdir -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	cat $(HOSTAPD_CONF_FILES) > $(PRODUCT_OUT)/$(HOSTAPD_CONF_PATH_ON_TARGET)

$(PRODUCT_OUT)/$(WIDI_CONF_PATH_ON_TARGET):
	mkdir -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	cat $(WIDI_CONF_FILES) > $(PRODUCT_OUT)/$(WIDI_CONF_PATH_ON_TARGET)

$(WIFI_RC_TARGET):
	mkdir -p $(PRODUCT_OUT)/root
	cat $(PRODUCT_WIFI_RC_FILES) > $(PRODUCT_OUT)/root/init.wifi.rc

$(WIDI_RC_TARGET):
	mkdir -p $(PRODUCT_OUT)/root
	cat $(PRODUCT_WIDI_RC_FILES) > $(PRODUCT_OUT)/root/init.widi.rc

$(WIFI_CONF_TARGET): $(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET)  \
           $(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET)  \
           $(PRODUCT_OUT)/$(HOSTAPD_CONF_PATH_ON_TARGET)

$(WIDI_CONF_TARGET): $(PRODUCT_OUT)/$(WIDI_CONF_PATH_ON_TARGET)

bootimage:    $(WIFI_RC_TARGET)
systemimg_gz: $(WIFI_CONF_TARGET)
ifeq ($(strip $(INTEL_WIDI)),true)
bootimage:    $(WIDI_RC_TARGET)
systemimg_gz: $(WIDI_CONF_TARGET)
endif

# manufacturer specific targets and rules
ifeq ($(BOARD_WLAN_DEVICE),wl12xx-compat)
$(PRODUCT_OUT)/ramdisk.img : build_wl12xx-compat
endif
