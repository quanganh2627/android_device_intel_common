COMBO_CHIP_VENDOR:=
COMBO_CHIP:=

ifneq (,$(filter wifi_ti bt_ti,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP_VENDOR:=ti
COMBO_CHIP:=ti
endif

ifneq (,$(filter wifi_bcm_4354 wifi_bcm_43241 wifi_bcm_4334 wifi_bcm_4335 wifi_bcm_4339 wifi_bcm_4334x wifi_bcm_43430 bt_bcm,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP_VENDOR:=bcm

    ifneq (,$(filter wifi_bcm_4354,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm4354
    endif

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

    ifneq (,$(filter wifi_bcm_43430,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm43430
    endif
endif

ifneq (,$(filter wifi_intel_wkp wifi_intel_lnp bt_lightning_peak bt_intel_wkp fm_lightning_peak,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP_VENDOR:=intel
ifneq (,$(filter wifi_intel_wkp,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP:=wkp
endif
ifneq (,$(filter wifi_intel_lnp,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP:=lnp
endif
endif

ifneq (,$(filter wifi_bigcore,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
BOARD_WLAN_DEVICE:= wifi-bigcore
COMBO_CHIP_VENDOR:=
COMBO_CHIP:=
endif

ifneq (,$(filter bt_rtl8723a bt_rtl8723b bt_rtl8821a wifi_rtl_8723,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
BOARD_WLAN_DEVICE:=rtl
COMBO_CHIP_VENDOR:=rtl
COMBO_CHIP:=rtl8723
endif
