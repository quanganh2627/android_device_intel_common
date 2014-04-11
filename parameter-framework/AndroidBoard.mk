LOCAL_PATH := $(call my-dir)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.common
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    parameter \
    ConfigurationSubsystem.xml
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.vibrator.common
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    vibrator
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.imc.subsystem
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    IMCSubsystem.xml
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.power.subsystem
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    PowerSubsystem.xml
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.voice_processing_lock.module
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    ModuleVoiceProcessingLock_V1_0.xml
include $(BUILD_PHONY_PACKAGE)

##################################################

ifeq ($(TARGET_BUILD_VARIANT),eng)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SYSTEM
LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
LOCAL_SRC_FILES := SCRIPTS/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

else

include $(CLEAR_VARS)
LOCAL_MODULE := parameter
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SYSTEM
LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
LOCAL_SRC_FILES := SCRIPTS/$(LOCAL_MODULE).user_debug
include $(BUILD_PREBUILT)

endif

include $(CLEAR_VARS)
LOCAL_MODULE := vibrator
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SYSTEM
LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
LOCAL_SRC_FILES := SCRIPTS/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := ConfigurationSubsystem.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio
LOCAL_SRC_FILES := XML/Structure/Audio/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := IMCSubsystem.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio
LOCAL_SRC_FILES := XML/Structure/Audio/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := PowerSubsystem.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio
LOCAL_SRC_FILES := XML/Structure/Audio/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.cme.subsystem
LOCAL_MODULE_STEM := CMESubsystem.xml
LOCAL_REQUIRED_MODULES := libremoteparameter-subsystem
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio
LOCAL_SRC_FILES := XML/Structure/Audio/$(LOCAL_MODULE_STEM)

######### Audio Algos #########

include $(CLEAR_VARS)
LOCAL_MODULE := CommonAlgoTypes.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := Gain.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := VoiceVolume.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := Dcr.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := SbaFir.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := SbaIir.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := Lpro.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := Mdrc.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ToneGenerator_V2_4.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

##############################
# VoiceAlgos_Gen3_5 Phony package
include $(CLEAR_VARS)
LOCAL_MODULE := VoiceAlgos_Gen3_5
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
    Algos_Gen3_5.xml \
    AmbientNoiseAdapter_V2_5.xml \
    NoiseReduction_V1_1.xml \
    ComfortNoiseInjector_V1_1.xml \
    ComfortNoiseInjector_V1_2.xml \
    AutomaticGainControl_V1_3.xml \
    FbaFir_V1_1.xml \
    FbaIir_V1_1.xml \
    DualMicrophoneNoiseReduction_V1_5.xml \
    SpectralEchoReduction_V2_5.xml \
    Beamforming_V1.1.xml \
    EchoDelayLine_V1_1.xml \
    GainLossControl_V1_0.xml \
    AcousticEchoCanceler_V1_6.xml \
    ReferenceLine_V1_1.xml \
    NonLinearFilter_V1_0.xml \
    TrafficNoiseReduction_V1_0.xml \
    DynamicRangeProcessor_V1_4.xml \
    BandWidthExtender_V1_0.xml \
    WindNoiseReduction_V1_0.xml \
    SlowVoice_V1_0.xml \
    MultibandDynamicRangeProcessor_V1_0.xml

include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := Algos_Gen3_5.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := AmbientNoiseAdapter_V2_5.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := NoiseReduction_V1_1.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ComfortNoiseInjector_V1_1.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := FbaFir_V1_1.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := FbaIir_V1_1.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ComfortNoiseInjector_V1_2.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := AutomaticGainControl_V1_3.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := DualMicrophoneNoiseReduction_V1_5.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := SpectralEchoReduction_V2_5.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := Beamforming_V1.1.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := EchoDelayLine_V1_1.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := GainLossControl_V1_0.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := AcousticEchoCanceler_V1_6.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ReferenceLine_V1_1.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := NonLinearFilter_V1_0.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := TrafficNoiseReduction_V1_0.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := DynamicRangeProcessor_V1_4.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := BandWidthExtender_V1_0.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := WindNoiseReduction_V1_0.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := SlowVoice_V1_0.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := MultibandDynamicRangeProcessor_V1_0.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ModuleVoiceProcessingLock_V1_0.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/parameter-framework/Structure/Audio/intel
LOCAL_SRC_FILES := XML/Structure/Audio/intel/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

##################################################

