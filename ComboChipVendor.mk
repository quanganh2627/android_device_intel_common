COMBO_CHIP_VENDOR:=
COMBO_CHIP:=

ifneq (,$(filter wifi_ti bt_ti,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP_VENDOR:=ti
COMBO_CHIP:=ti
endif

ifneq (,$(filter wifi_bcm_4330f wifi_bcm_43362 wifi_bcm_43430 wifi_bcm_4330 wifi_bcm_4354 wifi_bcm_43241 wifi_bcm_4334 wifi_bcm_4335 wifi_bcm_4339 wifi_bcm_4334x bt_bcm,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
COMBO_CHIP_VENDOR:=bcm

    ifneq (,$(filter wifi_bcm_4330,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm4330
    endif
    
    ifneq (,$(filter wifi_bcm_4330f,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm4330f
    endif
    
    ifneq (,$(filter wifi_bcm_43362,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm43362
    endif

    ifneq (,$(filter wifi_bcm_43430,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
    COMBO_CHIP:=bcm43430
    endif

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

ifneq (,$(filter bt_rtl8723a bt_rtl8723b bt_rtl8821a wifi_rtl_8723,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
BOARD_WLAN_DEVICE:=rtl
COMBO_CHIP_VENDOR:=rtl
COMBO_CHIP:=rtl8723
endif
ifneq (,$(filter wifi_rtl_8189,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
BOARD_WLAN_DEVICE:=rtl
COMBO_CHIP_VENDOR:=rtl
COMBO_CHIP:=rtl8189
endif

ifneq (,$(filter marvell88w8777,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)))
BOARD_WIFI_VENDOR := marvell
COMBO_CHIP_VENDOR:=marvell
ifeq ($(BOARD_WIFI_VENDOR), marvell)
        WPA_SUPPLICANT_VERSION := VER_0_8_X
        BOARD_WPA_SUPPLICANT_DRIVER := NL80211
#        BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mrvl
        BOARD_HOSTAPD_DRIVER := NL80211
#        BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mrvl

        SW_BOARD_USR_WIFI := 88W8777
        BOARD_WLAN_DEVICE := 88W8777
endif
endif

