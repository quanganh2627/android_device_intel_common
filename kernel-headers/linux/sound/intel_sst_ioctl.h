/****************************************************************************
 ****************************************************************************
 ***
 ***   This header was automatically generated from a Linux kernel header
 ***   of the same name, to make information necessary for userspace to
 ***   call into the kernel available to libc.  It contains only constants,
 ***   structures, and macros generated from the original header, and thus,
 ***   contains no copyrightable information.
 ***
 ***   To edit the content of this header, modify the corresponding
 ***   source file (e.g. under external/kernel-headers/original/) then
 ***   run bionic/libc/kernel/tools/update_all.py
 ***
 ***   Any manual change here will be lost the next time this script will
 ***   be run. You've been warned!
 ***
 ****************************************************************************
 ****************************************************************************/
#ifndef __INTEL_SST_IOCTL_H__
#define __INTEL_SST_IOCTL_H__
#include <linux/types.h>
enum sst_codec_types {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SST_CODEC_TYPE_UNKNOWN = 0,
 SST_CODEC_TYPE_PCM,
 SST_CODEC_TYPE_MP3,
 SST_CODEC_TYPE_MP24,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SST_CODEC_TYPE_AAC,
 SST_CODEC_TYPE_AACP,
 SST_CODEC_TYPE_eAACP,
 SST_CODEC_TYPE_WMA9,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SST_CODEC_TYPE_WMA10,
 SST_CODEC_TYPE_WMA10P,
 SST_CODEC_TYPE_RA,
 SST_CODEC_TYPE_DDAC3,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SST_CODEC_TYPE_STEREO_TRUE_HD,
 SST_CODEC_TYPE_STEREO_HD_PLUS,
 SST_CODEC_TYPE_VOICE_PCM = 0x21,
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum sst_algo_types {
 SST_CODEC_SRC = 0x64,
 SST_CODEC_MIXER = 0x65,
 SST_CODEC_DOWN_MIXER = 0x66,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SST_CODEC_VOLUME_CONTROL = 0x67,
 SST_CODEC_OEM1 = 0xC8,
 SST_CODEC_OEM2 = 0xC9,
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum stream_mode {
 SST_STREAM_MODE_NONE = 0,
 SST_STREAM_MODE_DNR = 1,
 SST_STREAM_MODE_FNF = 2,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SST_STREAM_MODE_CAPTURE = 3
};
enum stream_type {
 SST_STREAM_TYPE_NONE = 0,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SST_STREAM_TYPE_MUSIC = 1,
 SST_STREAM_TYPE_NORMAL = 2,
 SST_STREAM_TYPE_LONG_PB = 3,
 SST_STREAM_TYPE_LOW_LATENCY = 4,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct snd_sst_fw_version {
 __u8 build;
 __u8 minor;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 major;
 __u8 type;
};
struct snd_sst_port_info {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u16 port_type;
 __u16 reserved;
};
struct snd_sst_mix_info {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u16 max_streams;
 __u16 reserved;
};
struct snd_pcm_params_mrfld {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u16 codec;
 __u8 num_chan;
 __u8 pcm_wd_sz;
 __u32 reserved;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 sfreq;
 __u8 use_offload_path;
 __u8 reserved2;
 __u16 reserved3;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 channel_map[8];
} __attribute__ ((packed));
struct snd_pcm_params {
 __u16 codec;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 num_chan;
 __u8 pcm_wd_sz;
 __u32 reserved;
 __u32 sfreq;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 ring_buffer_size;
 __u32 period_count;
 __u32 ring_buffer_addr;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_mp3_params {
 __u16 codec;
 __u8 num_chan;
 __u8 pcm_wd_sz;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 brate;
 __u32 sfreq;
 __u8 crc_check;
 __u8 op_align;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u16 reserved;
};
#define AAC_BIT_STREAM_ADTS 0
#define AAC_BIT_STREAM_ADIF 1
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define AAC_BIT_STREAM_RAW 2
struct snd_aac_params {
 __u16 codec;
 __u8 num_chan;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 pcm_wd_sz;
 __u32 brate;
 __u32 sfreq;
 __u32 aac_srate;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 mpg_id;
 __u8 bs_format;
 __u8 aac_profile;
 __u8 ext_chl;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 aot;
 __u8 op_align;
 __u8 brate_type;
 __u8 crc_check;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __s8 bit_stream_format[8];
 __u8 jstereo;
 __u8 sbr_present;
 __u8 downsample;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 num_syntc_elems;
 __s8 syntc_id[2];
 __s8 syntc_tag[2];
 __u8 pce_present;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 sbr_type;
 __u8 outchmode;
 __u8 ps_present;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_wma_params {
 __u16 codec;
 __u8 num_chan;
 __u8 pcm_wd_sz;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 brate;
 __u32 sfreq;
 __u32 channel_mask;
 __u16 format_tag;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u16 block_align;
 __u16 wma_encode_opt;
 __u8 op_align;
 __u8 pcm_src;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct snd_prp_params {
 __u32 reserved;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_ppp_params {
 __u8 algo_id;
 __u8 str_id;
 __u8 enable;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 reserved;
 __u32 size;
 void *params;
} __attribute__ ((packed));
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_sst_postproc_info {
 __u32 src_min;
 __u32 src_max;
 __u8 src;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 bass_boost;
 __u8 stereo_widening;
 __u8 volume_control;
 __s16 min_vol;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __s16 max_vol;
 __u8 mute_control;
 __u8 reserved1;
 __u16 reserved2;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct snd_sst_prp_info {
 __s16 min_vol;
 __s16 max_vol;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 volume_control;
 __u8 reserved1;
 __u16 reserved2;
} __attribute__ ((packed));
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_sst_ppp_info {
 __u32 src:1;
 __u32 mixer:1;
 __u32 volume_control:1;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 mute_control:1;
 __u32 anc:1;
 __u32 side_tone:1;
 __u32 dc_removal:1;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 equalizer:1;
 __u32 spkr_prot:1;
 __u32 bass_boost:1;
 __u32 stereo_widening:1;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 rsvd1:21;
 __u32 rsvd2;
};
struct snd_sst_fw_info {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct snd_sst_fw_version fw_version;
 __u8 audio_codecs_supported[8];
 __u32 recommend_min_duration;
 __u8 max_pcm_streams_supported;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 max_enc_streams_supported;
 __u16 reserved;
 struct snd_sst_ppp_info ppp_info;
 struct snd_sst_postproc_info pop_info;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct snd_sst_port_info port_info[3];
 struct snd_sst_mix_info mix_info;
 __u32 min_input_buf;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
union snd_sst_codec_params {
 struct snd_pcm_params pcm_params;
 struct snd_mp3_params mp3_params;
 struct snd_aac_params aac_params;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct snd_wma_params wma_params;
};
struct snd_sst_stream_params {
 union snd_sst_codec_params uc;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
} __attribute__ ((packed));
struct snd_sst_params {
 __u32 result;
 __u32 stream_id;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 codec;
 __u8 ops;
 __u8 stream_type;
 __u8 device_type;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct snd_sst_stream_params sparams;
};
struct snd_sst_vol {
 __u32 stream_id;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __s32 volume;
 __u32 ramp_duration;
 __u32 ramp_type;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_sst_mute {
 __u32 stream_id;
 __u32 mute;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_sst_pmic_config {
 __u32 sfreq;
 __u16 num_chan;
 __u16 pcm_wd_sz;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
} __attribute__ ((packed));
struct snd_sst_get_stream_params {
 struct snd_sst_params codec_params;
 struct snd_sst_pmic_config pcm_params;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
enum snd_sst_target_type {
 SND_SST_TARGET_PMIC = 1,
 SND_SST_TARGET_LPE,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SND_SST_TARGET_MODEM,
 SND_SST_TARGET_BT,
 SND_SST_TARGET_FM,
 SND_SST_TARGET_NONE,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
enum snd_sst_device_type {
 SND_SST_DEVICE_SSP = 1,
 SND_SST_DEVICE_PCM,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SND_SST_DEVICE_OTHER,
};
enum snd_sst_device_mode {
 SND_SST_DEV_MODE_PCM_MODE1 = 1,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SND_SST_DEV_MODE_PCM_MODE2,
 SND_SST_DEV_MODE_PCM_MODE3,
 SND_SST_DEV_MODE_PCM_MODE4_RIGHT_JUSTIFIED,
 SND_SST_DEV_MODE_PCM_MODE4_LEFT_JUSTIFIED,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SND_SST_DEV_MODE_PCM_MODE4_I2S,
 SND_SST_DEV_MODE_PCM_MODE5,
 SND_SST_DEV_MODE_PCM_MODE6,
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum snd_sst_port_action {
 SND_SST_PORT_PREPARE = 1,
 SND_SST_PORT_ACTIVATE,
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum stream_param_type {
 SST_SET_TIME_SLOT = 0,
 SST_SET_CHANNEL_INFO = 1,
 OTHERS = 2,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct snd_sst_slot_info {
 __u8 mix_enable;
 __u8 device_type;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 device_instance;
 __u8 target_device;
 __u16 target_sink;
 __u8 slot[2];
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 master;
 __u8 action;
 __u8 device_mode;
 __u8 reserved;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct snd_sst_pmic_config pcm_params;
} __attribute__ ((packed));
#define SST_MAX_TARGET_DEVICES 3
struct snd_sst_target_device {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 device_route;
 struct snd_sst_slot_info devices[SST_MAX_TARGET_DEVICES];
} __attribute__ ((packed));
struct snd_sst_driver_info {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 version;
 __u32 active_pcm_streams;
 __u32 active_enc_streams;
 __u32 max_pcm_streams;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 max_enc_streams;
 __u32 buf_per_stream;
};
enum snd_sst_buff_type {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 SST_BUF_USER = 1,
 SST_BUF_MMAP,
 SST_BUF_RAR,
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_sst_mmap_buff_entry {
 unsigned int offset;
 unsigned int size;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_sst_mmap_buffs {
 unsigned int entries;
 enum snd_sst_buff_type type;
 struct snd_sst_mmap_buff_entry *buff;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct snd_sst_buff_entry {
 void *buffer;
 unsigned int size;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct snd_sst_buffs {
 unsigned int entries;
 __u8 type;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct snd_sst_buff_entry *buff_entry;
};
struct snd_sst_dbufs {
 unsigned long long input_bytes_consumed;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned long long output_bytes_produced;
 struct snd_sst_buffs *ibufs;
 struct snd_sst_buffs *obufs;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct snd_sst_tuning_params {
 __u8 type;
 __u8 str_id;
 __u8 size;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 rsvd;
 __u64 addr;
} __attribute__ ((packed));
struct snd_sst_runtime_params {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u8 type;
 __u8 str_id;
 __u8 size;
 __u8 rsvd;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 void *addr;
} __attribute__ ((packed));
#define SNDRV_SST_STREAM_SET_PARAMS _IOWR('L', 0x00,   struct snd_sst_stream_params *)
#define SNDRV_SST_STREAM_GET_PARAMS _IOWR('L', 0x01,   struct snd_sst_get_stream_params *)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define SNDRV_SST_STREAM_GET_TSTAMP _IOWR('L', 0x02, __u64 *)
#define SNDRV_SST_STREAM_DECODE _IOWR('L', 0x03, struct snd_sst_dbufs *)
#define SNDRV_SST_STREAM_BYTES_DECODED _IOWR('L', 0x04, __u64 *)
#define SNDRV_SST_STREAM_START _IO('A', 0x42)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define SNDRV_SST_STREAM_DROP _IO('A', 0x43)
#define SNDRV_SST_STREAM_DRAIN _IO('A', 0x44)
#define SNDRV_SST_STREAM_PAUSE _IOW('A', 0x45, int)
#define SNDRV_SST_STREAM_RESUME _IO('A', 0x47)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define SNDRV_SST_MMAP_PLAY _IOW('L', 0x05, struct snd_sst_mmap_buffs *)
#define SNDRV_SST_MMAP_CAPTURE _IOW('L', 0x06, struct snd_sst_mmap_buffs *)
#define SNDRV_SST_DRIVER_INFO _IOR('L', 0x10, struct snd_sst_driver_info *)
#define SNDRV_SST_SET_VOL _IOW('L', 0x11, struct snd_sst_vol *)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define SNDRV_SST_GET_VOL _IOW('L', 0x12, struct snd_sst_vol *)
#define SNDRV_SST_MUTE _IOW('L', 0x13, struct snd_sst_mute *)
#define SNDRV_SST_FW_INFO _IOR('L', 0x20, struct snd_sst_fw_info *)
#define SNDRV_SST_SET_TARGET_DEVICE _IOW('L', 0x21,   struct snd_sst_target_device *)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define SNDRV_SST_SET_ALGO _IOW('L', 0x30, struct snd_ppp_params *)
#define SNDRV_SST_GET_ALGO _IOWR('L', 0x31, struct snd_ppp_params *)
#define SNDRV_SST_TUNING_PARAMS _IOW('L', 0x32, struct snd_sst_tuning_params *)
#define SNDRV_SST_SET_RUNTIME_PARAMS _IOW('L', 0x40, struct snd_sst_tuning_params *)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#endif
