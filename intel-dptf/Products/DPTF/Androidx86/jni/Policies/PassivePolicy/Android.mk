# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

DPTF_SRC = ../../../../Sources
DPTF_INC = $(LOCAL_PATH)/$(DPTF_SRC)

include $(CLEAR_VARS)
#LOCAL_ALLOW_UNDEFINED_SYMBOLS := true
LOCAL_MODULE    := DptfPolicyPassive

LOCAL_C_INCLUDES := \
        bionic \
        bionic/libstdc++ \
	prebuilts/ndk/current/sources/cxx-stl/gnu-libstdc++/libs/x86/include \
	prebuilts/ndk/current/sources/cxx-stl/gnu-libstdc++/include \
	$(DPTF_INC) \
	$(DPTF_INC)/SharedLib/SharedLib \
	$(DPTF_INC)/PolicyLib/PolicyLib \
	$(DPTF_INC)/Policies/PassivePolicy/PassivePolicy \
	$(DPTF_INC)/EsifInclude \
	$(DPTF_INC)/ThirdParty

LOCAL_SHARED_LIBRARIES := \
        libnativehelper \
        libcutils \
        libutils \
        liblog \
	libdl \
        libgnustl_shared

LOCAL_CFLAGS += -std=c++11 -fexceptions -frtti -Wall -fPIC \
        -DESIF_ATTR_OS_ANDROID -DESIF_ATTR_USER \
	-Wno-error=non-virtual-dtor

LOCAL_STATIC_LIBRARIES := DptfPolicy DptfParticipant DptfShared

FILE_LIST := $(wildcard $(LOCAL_PATH)/$(DPTF_SRC)/Policies/PassivePolicy/PassivePolicy/*.cpp)
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
include $(BUILD_SHARED_LIBRARY)
