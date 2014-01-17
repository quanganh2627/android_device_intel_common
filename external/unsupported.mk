# this file is symlinked by all the build makefile that we dont support
# in PRIVATE directories - ignore the projects that are never released.
ifneq (,$(findstring /PRIVATE/,$(LOCAL_PATH)))
_need_prebuilts :=
$(foreach project, $(_prebuilt_projects),\
  $(if $(findstring $(project), $(LOCAL_MODULE_MAKEFILE)),\
    $(eval _need_prebuilts := true)))

ifeq (true,$(_need_prebuilts))
$(info Error in $(LOCAL_PATH).)
$(info Cannot be used in binary released PRIVATE directories.)
$(info Please ask support for external release/buildbot team if you really need it.)
$(error Abort prebuilts!)
endif # _need_prebuilts
endif # PRIVATE

include $(call original-metatarget)
