####################################
# Build configuration
####################################

USE_MOST_RESTRICTIVE_REGDOM=true

####################################
# Paths declaration
####################################

COMMON_WIFI_DIR = device/intel/common/wifi
COMMON = device/intel/common
LOCAL_COMMON_WIFI_DIR = $(PWD)/$(COMMON_WIFI_DIR)

####################################
# Configuration filenames
####################################

STA_CONF_FILE_NAME      = wpa_supplicant.conf
P2P_CONF_FILE_NAME      = p2p_supplicant.conf
HOSTAPD_CONF_FILE_NAME  = hostapd.conf

####################################
# Files path on target
####################################

CONF_PATH_ON_TARGET = system/etc/wifi
STA_CONF_PATH_ON_TARGET       = $(CONF_PATH_ON_TARGET)/$(STA_CONF_FILE_NAME)
P2P_CONF_PATH_ON_TARGET       = $(CONF_PATH_ON_TARGET)/$(P2P_CONF_FILE_NAME)
HOSTAPD_CONF_PATH_ON_TARGET   = $(CONF_PATH_ON_TARGET)/$(HOSTAPD_CONF_FILE_NAME)

####################################
# Manufacturer
####################################

include $(COMMON)/ComboChipVendor.mk

ifneq (,$(filter wifi_ti,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
  include $(TOP)/hardware/ti/wlan/wl12xx-compat/AndroidWl12xxCompat.mk
endif

ifneq (,$(filter wifi_lightning_peak,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
  -include $(TOP)/vendor/intel/hardware/PRIVATE/intel_cws/iwlwifi/iwl-stack-dev/Androidiwlwifi.mk
endif

####################################
# Configuration files
####################################
ifneq (,$(COMBO_CHIP_VENDOR))

# common configuration files
STA_CONF_FILES      += $(LOCAL_COMMON_WIFI_DIR)/$(STA_CONF_FILE_NAME)
P2P_CONF_FILES      += $(LOCAL_COMMON_WIFI_DIR)/$(P2P_CONF_FILE_NAME)
HOSTAPD_CONF_FILES  += $(LOCAL_COMMON_WIFI_DIR)/$(HOSTAPD_CONF_FILE_NAME)

# manufacturer specific files
STA_CONF_FILES      += $(LOCAL_COMMON_WIFI_DIR)/$(COMBO_CHIP_VENDOR)_specific/$(STA_CONF_FILE_NAME)
P2P_CONF_FILES      += $(LOCAL_COMMON_WIFI_DIR)/$(COMBO_CHIP_VENDOR)_specific/$(P2P_CONF_FILE_NAME)
HOSTAPD_CONF_FILES  += $(LOCAL_COMMON_WIFI_DIR)/$(COMBO_CHIP_VENDOR)_specific/$(HOSTAPD_CONF_FILE_NAME)

####################################
# Locale variables
####################################

ifeq ($(USE_MOST_RESTRICTIVE_REGDOM),true)
REGDOM=00
else
REGDOM=$(word 2,$(subst _, ,$(word 1,$(PRODUCT_LOCALES))))
endif
MV=mv
CAT=cat
SED=sed
MKDIR=mkdir
GREP=grep

####################################
# Functions
####################################

define set_def_regdom
	$(SED) 's/country=XY/country=$(REGDOM)/g' $1 > $1.tmp
	$(MV) $1.tmp $1
endef

define clean_conf_file
	$(CAT) $1 | $(GREP) -v "(todel)" > $1.tmp
	$(MV) $1.tmp $1
endef

endif

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := wpa_supplicant.conf
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/wifi
include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(STA_CONF_FILES)
	@echo "Building $@"
	$(hide) mkdir -p $(dir $@)
	$(hide) cat $(STA_CONF_FILES) > $@
	$(hide) $(call set_def_regdom,$@)
	$(hide) $(call clean_conf_file,$@)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := p2p_supplicant.conf
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/wifi
include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(P2P_CONF_FILES)
	@echo "Building $@"
	$(hide) mkdir -p $(dir $@)
	$(hide) cat $(P2P_CONF_FILES) > $@
	$(hide) $(call set_def_regdom,$@)
	$(hide) $(call clean_conf_file,$@)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := hostapd.conf
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/wifi
include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(HOSTAPD_CONF_FILES)
	@echo "Building $@"
	$(hide) mkdir -p $(dir $@)
	$(hide) cat $(HOSTAPD_CONF_FILES) > $@

##################################################
