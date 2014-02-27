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

#modules += DptfShared
#modules += PolicyLib
#modules += UnifiedParticipant
#modules += ActivePolicy
#modules += CriticalPolicy
#modules += PassivePolicy
#modules += Manager
#include $(call all-named-subdir-makefiles,$(modules))

TOP_PATH := $(call my-dir)
include $(TOP_PATH)/SharedLib/Android.mk
include $(TOP_PATH)/PolicyLib/Android.mk
include $(TOP_PATH)/UnifiedParticipant/Android.mk
include $(TOP_PATH)/Policies/PassivePolicy/Android.mk
include $(TOP_PATH)/Policies/ActivePolicy/Android.mk
include $(TOP_PATH)/Policies/CriticalPolicy/Android.mk
include $(TOP_PATH)/Manager/Android.mk
