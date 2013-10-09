COMBO_CHIP_VENDOR:=
COMBO_CHIP:=

ifneq (,$(filter wifi_ti bt_ti,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP_VENDOR:=ti
COMBO_CHIP:=ti
endif

ifneq (,$(filter wifi_bcm_43241 wifi_bcm_4334 wifi_bcm_4335 wifi_bcm_4339 wifi_bcm_4334x bt_bcm,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP_VENDOR:=bcm

    ifneq (,$(filter wifi_bcm_43241,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm43241
    endif

    ifneq (,$(filter wifi_bcm_4334,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm4334
    endif

    ifneq (,$(filter wifi_bcm_4335,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm4335
    endif

    ifneq (,$(filter wifi_bcm_4339,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm4339
    endif

    ifneq (,$(filter wifi_bcm_4334x,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm4334x
    endif
endif

ifneq (,$(filter wifi_intel_wkp bt_lightning_peak,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP_VENDOR:=intel
COMBO_CHIP:=xmm
endif

ifneq (,$(filter wifi_bigcore,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
BOARD_WLAN_DEVICE:= wifi-bigcore
COMBO_CHIP_VENDOR:=
COMBO_CHIP:=
endif
