ifneq (,$(findstring /PRIVATE/,$(LOCAL_PATH)))
$(info $(call original-metatarget) $(LOCAL_PATH) $(LOCAL_MODULE))
endif
include $(call original-metatarget)
