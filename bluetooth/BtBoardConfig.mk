include $(COMMON_PATH)/ComboChipVendor.mk

# Realtek
ifeq ($(COMBO_CHIP_VENDOR),rtl)

BOARD_HAVE_BLUETOOTH_RTK := true
RTK_BLUETOOTH_INTERFACE := uart
BLUETOOTH_BLUEDROID_RTK := true
BLUETOOTH_HCI_USE_RTK_H5 := true

endif

# Intel chip compilation flag
ifeq ($(COMBO_CHIP_VENDOR), intel)
BOARD_USES_WCS := true
else
BOARD_USES_WCS := false
endif
