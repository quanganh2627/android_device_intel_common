
# We need to refer to the standard frameworks/base path for flavors
FRAMEWORKS_BASE_STD := frameworks/base
FRAMEWORKS_NATIVE_STD := frameworks/native


# Deduce the flavor from the product name
TMP_EXT := $(shell echo $(TARGET_PRODUCT) | tail -c 4)
ifeq ($(TMP_EXT), _ds)
USE_FLAVOR := dsds
FRAMEWORKS_BASE := $(FRAMEWORKS_BASE_STD)-$(USE_FLAVOR)
FRAMEWORKS_NATIVE := $(FRAMEWORKS_NATIVE_STD)-$(USE_FLAVOR)
else
USE_FLAVOR := $(empty)
FRAMEWORKS_BASE := $(FRAMEWORKS_BASE_STD)
FRAMEWORKS_NATIVE := $(FRAMEWORKS_NATIVE_STD)
endif

# Substitute the standard frameworks occurences in the pathmap_INCL
pathmap_INCL := $(subst $(FRAMEWORKS_BASE_STD),$(FRAMEWORKS_BASE),$(pathmap_INCL))
pathmap_INCL := $(subst $(FRAMEWORKS_NATIVE_STD),$(FRAMEWORKS_NATIVE),$(pathmap_INCL))

# Substitute the standard frameworks occurences in the SRC_HEADERS
SRC_HEADERS := $(subst $(FRAMEWORKS_BASE_STD),$(FRAMEWORKS_BASE),$(SRC_HEADERS))
SRC_HEADERS := $(subst $(FRAMEWORKS_NATIVE_STD),$(FRAMEWORKS_NATIVE),$(SRC_HEADERS))

#
# A version of FRAMEWORKS_BASE_SUBDIRS that is expanded to full paths from
# the root of the tree.  This currently needs to be here so that other libraries
# and apps can find the .aidl files in the framework, though we should really
# figure out a better way to do this.
#
FRAMEWORKS_BASE_JAVA_SRC_DIRS := \
	$(addprefix $(FRAMEWORKS_BASE)/,$(FRAMEWORKS_BASE_SUBDIRS))

