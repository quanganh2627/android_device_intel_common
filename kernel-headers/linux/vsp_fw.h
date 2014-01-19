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
#ifndef _VSP_FW_H_
#define _VSP_FW_H_
#define VssProcPipelineMaxNumFilters 5
#define VSS_PROC_MAX_INPUT_PICTURES 1
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define VSS_PROC_MAX_OUTPUT_PICTURES 4
#define VSP_APP_ID_NONE 0
#define VSP_APP_ID_FRC_VPP 1
#define VSP_APP_ID_VP8_ENC 2
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define VSP_APP_ID_WIDI_ENC 3
enum VssProcFilterType {
 VssProcFilterDenoise,
 VssProcFilterSharpening,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssProcFilterColorEnhancement,
 VssProcFilterFrameRateConversion
};
enum VssDenoiseType {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssProcDegrain,
 VssProcDeblock
};
enum VssFrcQuality {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssFrcMediumQuality,
 VssFrcHighQuality
};
enum VssFrcConversionRate {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssFrc2xConversionRate,
 VssFrc2_5xConversionRate,
 VssFrc4xConversionRate,
 VssFrc1_25xConversionRate
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct VssProcPipelineParameterBuffer {
 unsigned int num_filters;
 enum VssProcFilterType filter_pipeline[VssProcPipelineMaxNumFilters];
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int intermediate_buffer_base;
 unsigned int intermediate_buffer_size;
};
struct VssProcSharpenParameterBuffer {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int quality;
 unsigned int _pad[7];
};
struct VssProcDenoiseParameterBuffer {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 enum VssDenoiseType type;
 int value_thr;
 int cnt_thr;
 int coef;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int temp_thr1;
 int temp_thr2;
 int _pad[2];
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct VssProcColorEnhancementParameterBuffer {
 int temp_detect;
 int temp_correct;
 int clip_thr;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int mid_thr;
 int luma_amm;
 int chroma_amm;
 int _pad[2];
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct VssProcFrcParameterBuffer {
 enum VssFrcQuality quality;
 enum VssFrcConversionRate conversion_rate;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int _pad[6];
};
#define VSP_ROTATION_NONE 0
#define VSP_ROTATION_90 90
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define VSP_ROTATION_180 180
#define VSP_ROTATION_270 270
struct VssProcPicture {
 unsigned int surface_id;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int irq;
 unsigned int base;
 unsigned int height;
 unsigned int width;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int rot_angle;
 unsigned int stride;
 unsigned int format;
 unsigned int tiled;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int _pad[7];
};
struct VssProcPictureParameterBuffer {
 unsigned int num_input_pictures;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int num_output_pictures;
 int _pad[6];
 struct VssProcPicture input_picture[VSS_PROC_MAX_INPUT_PICTURES];
 struct VssProcPicture output_picture[VSS_PROC_MAX_OUTPUT_PICTURES];
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
union VssProcBuffer {
 struct VssProcPipelineParameterBuffer pipeline;
 struct VssProcSharpenParameterBuffer sharpen_base;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct VssProcDenoiseParameterBuffer denoiser_base;
 struct VssProcColorEnhancementParameterBuffer enhancer_base;
 struct VssProcFrcParameterBuffer frc;
 struct VssProcPictureParameterBuffer picture;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
enum VssProcCommandType {
 VssProcPipelineParameterCommand = 0xFFFE,
 VssProcSharpenParameterCommand = 0xFFFD,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssProcDenoiseParameterCommand = 0xFFFC,
 VssProcColorEnhancementParameterCommand = 0xFFFB,
 VssProcFrcParameterCommand = 0xFFFA,
 VssProcPictureCommand = 0xFFF9,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VspFencePictureParamCommand = 0xEBEC,
 VspSetContextCommand = 0xEBED,
 Vss_Sys_STATE_BUF_COMMAND
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define VSP_CMD_QUEUE_SIZE (64)
#define VSP_ACK_QUEUE_SIZE (64)
struct vss_command_t {
 unsigned int context;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int type;
 unsigned int buffer;
 unsigned int size;
 unsigned int buffer_id;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int irq;
 unsigned int reserved6;
 unsigned int reserved7;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct vss_response_t {
 unsigned int context;
 unsigned int type;
 unsigned int buffer;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int size;
 unsigned int vss_cc;
 unsigned int reserved5;
 unsigned int reserved6;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int reserved7;
};
#define VSP_COMMAND_INITIALIZER {0, 0, 0, 0, 0, 0, 0, 0}
#define VSP_RESPONSE_INITIALIZER {0, 0, 0, 0, 0, 0, 0, 0}
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum VssResponseType {
 VssIdleResponse = 0x80010000,
 VssErrorResponse = 0x80020000,
 VssEndOfSequenceResponse = 0x80030000,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssCommandBufferReadyResponse = 0x80040000,
 VssInputSurfaceReadyResponse = 0x80050000,
 VssOutputSurfaceReadyResponse = 0x80060000,
 VssVp8encSetSequenceParametersResponse = 150,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssVp8encEncodeFrameResponse
};
enum VssStatus {
 VssOK = 0x8001,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssInvalidCommandType = 0x8002,
 VssInvalidCommandArgument = 0x8003,
 VssInvalidProcPictureCommand = 0x8004,
 VssInvalidDdrAddress = 0x8005,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssInvalidSequenceParameters_VP8 = 0x1,
 VssInvalidPictureParameters_VP8 = 0x2,
 VssInitFailure_VP8 = 0x5
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum FrcResponseType {
 VssOutputSurfaceFreeResponse = 0x0000F001,
 VssOutputSurfaceCrcResponse = 0x0000F002
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum vsp_format {
 VSP_NV12,
 VSP_YV12,
 VSP_UYVY,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VSP_YUY2,
 VSP_NV11,
 VSP_NV16,
 VSP_IYUV,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VSP_TYPE_ERROR
};
struct vsp_data {
 unsigned int fw_state;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int uninit_req;
};
#define VSP_SECURE_BOOT_MAGIC_NR 0xb0070001
enum vsp_processor {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 vsp_sp0 = 0,
 vsp_sp1 = 1,
 vsp_vp0 = 2,
 vsp_vp1 = 3,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 vsp_mea = 4
};
struct vsp_secure_boot_header {
 unsigned int magic_number;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int boot_text_offset;
 unsigned int boot_text_reg;
 unsigned int boot_icache_value;
 unsigned int boot_icache_reg;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int boot_pc_value;
 unsigned int boot_pc_reg;
 unsigned int ma_header_offset;
 unsigned int ma_header_reg;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int boot_start_value;
 unsigned int boot_start_reg;
};
enum vsp_ctrl_reg_addr {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VSP_SETTING_ADDR_REG = 3,
 VSP_SECBOOT_DEBUG_REG = 4,
 VSP_ENTRY_KIND_REG = 5,
 VSP_POWER_SAVING_MODE_REG = 6,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VSP_CONTEXT_ID_REG = 7,
 VSP_CMD_QUEUE_RD_REG = 12,
 VSP_CMD_QUEUE_WR_REG = 13,
 VSP_ACK_QUEUE_RD_REG = 14,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VSP_ACK_QUEUE_WR_REG = 15
};
struct vsp_ctrl_reg {
 unsigned int reserved_2;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int setting_addr;
 unsigned int secboot_debug;
 unsigned int entry_kind;
 unsigned int power_saving_mode;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int context_setting_addr;
 unsigned int reserved_8;
 unsigned int reserved_9;
 unsigned int reserved_10;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int reserved_11;
 unsigned int cmd_rd;
 unsigned int cmd_wr;
 unsigned int ack_rd;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int ack_wr;
};
struct vsp_settings_t {
 unsigned int max_contexts;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int command_queue_size;
 unsigned int command_queue_addr;
 unsigned int response_queue_size;
 unsigned int response_queue_addr;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int contexts_array_addr;
 unsigned int reserved6;
 unsigned int reserved7;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct vsp_context_settings_t {
 unsigned int app_id;
 unsigned int state_buffer_size;
 unsigned int state_buffer_addr;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int reserved3;
 unsigned int reserved4;
 unsigned int reserved5;
 unsigned int reserved6;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int usage;
};
enum vsp_context_usage {
 vsp_context_unused = 0,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 vsp_context_deinit = 1,
 vsp_context_starting = 16,
 vsp_context_in_use = 17
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define VSP_SETTINGS_INITIALIZER {0, 0, 0, 0, 0, 0, 0, 0}
enum vsp_entry_kind {
 vsp_entry_booted = 0,
 vsp_entry_init = 1,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 vsp_entry_resume = 2,
 vsp_exit = 3
};
enum vsp_power_saving_mode {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 vsp_always_on = 0,
 vsp_suspend_on_empty_queue = 1,
 vsp_hw_idle_on_empty_queue = 2,
 vsp_suspend_and_hw_idle_on_empty_queue
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct VssProcPictureVP8 {
 uint32_t surface_id;
 uint32_t irq;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t base;
 uint32_t base_uv;
 uint32_t height;
 uint32_t width;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t stride;
 uint32_t format;
};
typedef enum {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 vss_vp8enc_seq_param_recon_buffer_mode_per_seq = 0,
 vss_vp8enc_seq_param_recon_buffer_mode_per_pic,
 vss_vp8enc_seq_param_recon_buffer_mode_cnt
} vss_vp8enc_seq_param_recon_buffer_mode_t;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct VssVp8encSequenceParameterBuffer {
 uint32_t frame_width;
 uint32_t frame_height;
 uint32_t frame_rate;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t error_resilient;
 uint32_t num_token_partitions;
 uint32_t kf_mode;
 uint32_t kf_min_dist;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t kf_max_dist;
 uint32_t rc_target_bitrate;
 uint32_t rc_min_quantizer;
 uint32_t rc_max_quantizer;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t rc_undershoot_pct;
 uint32_t rc_overshoot_pct;
 uint32_t rc_end_usage;
 uint32_t rc_buf_sz;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t rc_buf_initial_sz;
 uint32_t rc_buf_optimal_sz;
 uint32_t max_intra_rate;
 uint32_t cyclic_intra_refresh;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t concatenate_partitions;
 uint32_t recon_buffer_mode;
 struct VssProcPictureVP8 ref_frame_buffers[4];
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct VssVp8encEncodedFrame {
 uint32_t frame_size;
 uint32_t status;
 uint32_t partitions;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t partition_size[9];
 uint32_t partition_start[9];
 uint32_t segments;
 uint32_t quantizer[4];
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t frame_flags;
 uint32_t partition_id;
 uint32_t buffer_level;
 uint32_t quality;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t surfaceId_of_ref_frame[4];
 uint32_t reserved[15];
 uint32_t coded_data[1];
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct VssVp8encPictureParameterBuffer {
 struct VssProcPictureVP8 input_frame;
 struct VssProcPictureVP8 recon_frame;
 uint32_t version;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t pic_flags;
 uint32_t prev_frame_dropped;
 uint32_t cpuused;
 uint32_t sharpness;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t num_token_partitions;
 uint32_t encoded_frame_size;
 uint32_t encoded_frame_base;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum VssVp8encCommandType {
 VssVp8encSetSequenceParametersCommand = 123,
 VssVp8encEncodeFrameCommand,
 VssVp8encEndOfSequenceCommand,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 VssVp8encInit,
 Vss_Sys_Ref_Frame_COMMAND
};
#endif
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
