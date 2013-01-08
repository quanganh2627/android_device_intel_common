# this file is symlinked by all the build makefile that we dont support
# in PRIVATE directories
ifneq (,$(findstring /PRIVATE/,$(LOCAL_PATH)))
$(info error in $(LOCAL_PATH))
$(error cannot be used in PRIVATE directories. Please ask support for external release/buildbot team if you really need it)
endif
include $(call original-metatarget)
