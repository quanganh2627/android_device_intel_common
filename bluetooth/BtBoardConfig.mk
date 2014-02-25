include $(COMMON_PATH)/ComboChipVendor.mk

# Realtek
ifeq ($(COMBO_CHIP_VENDOR),rtl)

BOARD_HAVE_BLUETOOTH_RTK := true
RTK_BLUETOOTH_INTERFACE := uart
ifeq ($(RTK_BLUETOOTH_INTERFACE), uart)
    BLUETOOTH_HCI_USE_RTK_H5 := true
    BLUETOOTH_BLUEDROID_RTK := true
endif

endif
