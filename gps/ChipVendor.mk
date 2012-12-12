GPS_CHIP_VENDOR := none
GPS_CHIP := none

ifneq (,$(filter gps_ti_wl128x%,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
GPS_CHIP_VENDOR := ti
GPS_CHIP := wl128x
endif

ifneq (,$(filter gps_csr_gsd4t%,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
GPS_CHIP_VENDOR := csr
GPS_CHIP := gsd4t
endif

ifneq (,$(filter gps_csr_gsd5t%,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
GPS_CHIP_VENDOR := csr
GPS_CHIP := gsd5t
endif

ifneq (,$(filter gps_bcm_4752%,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
GPS_CHIP_VENDOR := bcm
GPS_CHIP := 4752
endif
