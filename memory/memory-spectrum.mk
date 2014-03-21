## Small ram device definition

ifeq ($(BOARD_HAVE_SMALL_RAM),true)
  NO_LIVEWALLPAPER := true
  SMALL_CODE_SIZE := true
  CAMERA_NO_REPOOL := true
  NO_MPM := true
endif

## Small and mid ram device definition

ifneq (,$(filter true,$(BOARD_HAVE_MID_RAM) $(BOARD_HAVE_SMALL_RAM)))
  BOARD_HAVE_KSM := true
  BOARD_HAVE_ZRAM := true
  LIMIT_READAHEAD := true
  ENABLE_PIC_PIE := true
endif


