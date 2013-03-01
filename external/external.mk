ifneq (,$(findstring intel_prebuilts,$(MAKECMDGOALS)))
# at the moment we only generate prebuilts for userdebug builds
# this is a safety feature, eng, user, and userdebug binaries should be the same
# so intel_prebuilts should be used only for one variant anyway.
ifneq (,$(findstring userdebug,$(TARGET_BUILD_VARIANT)))

# for easy porting to legacy branches, we setup REF_PRODUCT_NAME
ifeq ($(REF_PRODUCT_NAME),)
REF_PRODUCT_NAME:=$(TARGET_PRODUCT)
endif

# get the original path of the hooked build makefiles
define original-metatarget
$(strip \
  $(eval _LOCAL_BUILD_MAKEFILE := $$(lastword $$(MAKEFILE_LIST))) \
  $(BUILD_SYSTEM)/$(notdir $(_LOCAL_BUILD_MAKEFILE)))
endef

# $(1) : LOCAL_PREBUILT_* suffix
# $(2) : are we in host mode
define external-echo-prebuilt
$(if $($@.$(2)$(1)),
	echo 'LOCAL_PREBUILT_$(1):=$($@.$(2)$(1))' >> $@,)
endef
# $(1) : line to echo to the makefile
define external-echo-makefile
	echo $(1) >>$@
endef

# $(1) : metatarget
# $(2) : MULTI_PREBUILT variable
define external-gather-files
ifeq ($(1),$(_metatarget))
   $(my).$(2) := $($(my).$(2)) $(notdir $(LOCAL_INSTALLED_MODULE))
   $(my).copyfiles := $($(my).copyfiles) $(LOCAL_INSTALLED_MODULE)
   ifneq (,$(findstring(HOST,$(2))))
	$(my).hashosts := yes
   endif
endif
ifeq (multi_prebuilt,$(_metatarget))
   ifneq (,$(strip $(SAVED_$(2))))
      $(my).$(2) := $($(my).$(2)) $(foreach h,$(SAVED_$(2)),$(notdir $(h)))
      $(my).copyfiles := $($(my).copyfiles) $(foreach h,$(SAVED_$(2)),$(LOCAL_PATH)/$(h))
      ifneq (,$(findstring(HOST,$(2))))
        $(my).hashosts := yes
      endif
      # clean the variable
      SAVED_$(2) :=
   endif
endif
endef

EXTERNAL_BUILD_SYSTEM=vendor/intel/common/external

TARGET_OUT_prebuilts := $(PRODUCT_OUT)/prebuilts

# hook all the build makefiles with our own version
# most of them are only symlinks to "unsupported.mk", which will generate an
# error if included from a "PRIVATE" dir
# others are symlink to generic_rules.mk
# we cannot directly point to unsupported or generic_rules, because we would loose
# the information on what we are building
BUILD_HOST_STATIC_LIBRARY:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/host_static_library.mk
BUILD_HOST_SHARED_LIBRARY:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/host_shared_library.mk
BUILD_STATIC_LIBRARY:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/static_library.mk
BUILD_RAW_STATIC_LIBRARY := $(EXTERNAL_BUILD_SYSTEM)/symlinks/raw_static_library.mk
BUILD_SHARED_LIBRARY:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/shared_library.mk
BUILD_EXECUTABLE:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/executable.mk
BUILD_RAW_EXECUTABLE:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/raw_executable.mk
BUILD_HOST_EXECUTABLE:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/host_executable.mk
BUILD_PACKAGE:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/package.mk
BUILD_PHONY_PACKAGE:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/phony_package.mk
BUILD_HOST_PREBUILT:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/host_prebuilt.mk
BUILD_PREBUILT:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/prebuilt.mk
BUILD_MULTI_PREBUILT:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/multi_prebuilt.mk
BUILD_JAVA_LIBRARY:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/java_library.mk
BUILD_STATIC_JAVA_LIBRARY:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/static_java_library.mk
BUILD_HOST_JAVA_LIBRARY:= $(EXTERNAL_BUILD_SYSTEM)/symlinks/host_java_library.mk
BUILD_COPY_HEADERS := $(EXTERNAL_BUILD_SYSTEM)/symlinks/copy_headers.mk
BUILD_NATIVE_TEST := $(EXTERNAL_BUILD_SYSTEM)/symlinks/native_test.mk
BUILD_HOST_NATIVE_TEST := $(EXTERNAL_BUILD_SYSTEM)/symlinks/host_native_test.mk
BUILD_CUSTOM_EXTERNAL := $(EXTERNAL_BUILD_SYSTEM)/symlinks/custom_external.mk

endif # userdebug
endif # intel_prebuilt
