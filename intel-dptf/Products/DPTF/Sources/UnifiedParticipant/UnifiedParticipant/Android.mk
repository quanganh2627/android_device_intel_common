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

include $(CLEAR_VARS)

LOCAL_MODULE    := DptfParticipant

ANDROID_NDK_HOME = /home/bbian/android/ndk
DPTF_SRC = /home/bbian/android/workspace/dptf/jni/Sources
LOCAL_C_INCLUDES := $(ANDROID_NDK_HOME)/sources/cxx-stl/gnu-libstdc++/4.8/include \
$(ANDROID_NDK_HOME)/sources/cxx-stl/gnu-libstdc++/4.8/libs/x86/include \
$(DPTF_SRC) \
$(DPTF_SRC)/SharedLib/SharedLib \
$(DPTF_SRC)/UnifiedParticipant/UnifiedParticipant \
$(DPTF_SRC)/EsifInclude \
$(DPTF_SRC)/ThirdParty

LOCAL_CFLAGS += -std=c++11 -fexceptions -frtti -O2 -Wall -fPIC -DESIF_ATTR_OS_LINUX -DESIF_ATTR_USER

LOCAL_SRC_FILES := ClassFactories.cpp \
DomainActiveControl_000.cpp \
DomainActiveControl_001.cpp \
DomainActiveControlFactory.cpp \
DomainConfigTdpControl_000.cpp \
DomainConfigTdpControl_001.cpp \
DomainConfigTdpControlFactory.cpp \
DomainCoreControl_000.cpp \
DomainCoreControl_001.cpp \
DomainCoreControlFactory.cpp \
DomainDisplayControl_000.cpp \
DomainDisplayControl_001.cpp \
DomainDisplayControlFactory.cpp \
DomainPerformanceControl_000.cpp \
DomainPerformanceControl_001.cpp \
DomainPerformanceControl_002.cpp \
DomainPerformanceControl_003.cpp \
DomainPerformanceControlFactory.cpp \
DomainPowerControl_000.cpp \
DomainPowerControl_001.cpp \
DomainPowerControlFactory.cpp \
DomainPowerStatus_000.cpp \
DomainPowerStatus_001.cpp \
DomainPowerStatusFactory.cpp \
DomainPriority_000.cpp \
DomainPriority_001.cpp \
DomainPriorityFactory.cpp \
DomainTemperature_000.cpp \
DomainTemperature_001.cpp \
DomainTemperatureFactory.cpp \
DomainUtilization_000.cpp \
DomainUtilization_001.cpp \
DomainUtilizationFactory.cpp \
ParticipantGetSpecificInfo_000.cpp \
ParticipantGetSpecificInfo_001.cpp \
ParticipantGetSpecificInfoFactory.cpp \
ParticipantSetSpecificInfo_000.cpp \
ParticipantSetSpecificInfo_001.cpp \
ParticipantSetSpecificInfoFactory.cpp \
UnifiedDomain.cpp \
UnifiedParticipant.cpp \
UnifiedParticipantInterface.cpp 

include $(BUILD_STATIC_LIBRARY)
