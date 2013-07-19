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

ifneq (,$(filter wifi_bcm_43241,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
  include $(TOP)/hardware/broadcom/wlan_driver/bcm4334/AndroidBcmdhd43241.mk
endif

ifneq (,$(filter wifi_bcm_4334,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
  include $(TOP)/hardware/broadcom/wlan_driver/bcm4334/AndroidBcmdhd4334.mk
endif

ifneq (,$(filter wifi_bcm_4335 wifi_bcm_4339,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
  include $(TOP)/hardware/broadcom/wlan_driver/bcm4334/AndroidBcmdhd4335.mk
endif

ifneq (,$(filter wifi_bcm_4334x,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
  include $(TOP)/hardware/broadcom/wlan_driver/bcm4334/AndroidBcmdhd4334x.mk
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

####################################
# Rules and targets
####################################

# targets names
WIFI_CONF_TARGET = wifi_conf
WIFI_RC_TARGET   = wifi_rc

# common targets and rules
$(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET):
	$(MKDIR) -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	$(CAT) $(STA_CONF_FILES) > $(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET)
	$(call set_def_regdom,$(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET))
	$(call clean_conf_file,$(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET))

$(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET):
	$(MKDIR) -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	$(CAT) $(P2P_CONF_FILES) > $(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET)
	$(call set_def_regdom,$(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET))
	$(call clean_conf_file,$(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET))

$(PRODUCT_OUT)/$(HOSTAPD_CONF_PATH_ON_TARGET):
	$(MKDIR) -p $(PRODUCT_OUT)/$(CONF_PATH_ON_TARGET)
	$(CAT) $(HOSTAPD_CONF_FILES) > $(PRODUCT_OUT)/$(HOSTAPD_CONF_PATH_ON_TARGET)

$(WIFI_CONF_TARGET): $(PRODUCT_OUT)/$(STA_CONF_PATH_ON_TARGET)  \
           $(PRODUCT_OUT)/$(P2P_CONF_PATH_ON_TARGET)  \
           $(PRODUCT_OUT)/$(HOSTAPD_CONF_PATH_ON_TARGET)

systemimg_gz: $(WIFI_CONF_TARGET)

endif
