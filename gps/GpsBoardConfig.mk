GPS_PATH := vendor/intel/common/gps

containing = $(strip $(foreach v,$2,$(if $(findstring $1,$v),$v)))

include $(GPS_PATH)/ChipVendor.mk

ifeq (,$(filter none,$(GPS_CHIP_VENDOR) $(GPS_CHIP)))

##################################################

ifneq (,$(call containing,cpd,$(filter gps_%,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES))))
GPS_USES_CP_DAEMON := true
endif

ifneq (,$(call containing,extlna,$(filter gps_%,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES))))
GPS_USES_EXTERNAL_LNA := true
endif

##################################################

endif
