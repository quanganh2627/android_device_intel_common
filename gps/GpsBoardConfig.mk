GPS_PATH := vendor/intel/common/gps

include $(GPS_PATH)/ChipVendor.mk

ifeq (,$(filter none,$(GPS_CHIP_VENDOR) $(GPS_CHIP)))

##################################################

-include $(GPS_PATH)/$(GPS_CHIP_VENDOR)/GpsBoardConfig.mk

##################################################

ifneq (,$(filter gps%_cpd%,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
GPS_USES_CP_DAEMON := true
endif

ifneq (,$(filter gps%_extlna%,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
GPS_USES_EXTERNAL_LNA := true
endif

##################################################

endif
