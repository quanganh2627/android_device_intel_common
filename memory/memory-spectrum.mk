## Small ram device definition

ifeq ($(BOARD_HAVE_SMALL_RAM),true)
  REMOVE_LIVEWALLPAPER := true
  SMALL_CODE_SIZE := true
endif

## Small and mid ram device definition

ifneq (,$(filter true,$(BOARD_HAVE_MID_RAM) $(BOARD_HAVE_SMALL_RAM)))
  MINIMIZE_MALLOC_ALIGNMENT := true
  BOARD_HAVE_KSM := true
  BOARD_HAVE_ZRAM := true
  REMOVE_MPM := true
  CAMERA_NO_REPOOL := true
  LIMIT_READAHEAD := true
  ENABLE_PIC_PIE := true
endif


