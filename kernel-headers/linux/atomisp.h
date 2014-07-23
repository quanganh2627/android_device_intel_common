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
#ifndef _ATOM_ISP_H
#define _ATOM_ISP_H
#include <linux/types.h>
#include <linux/version.h>
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_CSS_VERSION_MASK 0x00ffffff
#define ATOMISP_CSS_VERSION_15 KERNEL_VERSION(1, 5, 0)
#define ATOMISP_CSS_VERSION_20 KERNEL_VERSION(2, 0, 0)
#define ATOMISP_CSS_VERSION_21 KERNEL_VERSION(2, 1, 0)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_HW_REVISION_MASK 0x0000ff00
#define ATOMISP_HW_REVISION_SHIFT 8
#define ATOMISP_HW_REVISION_ISP2300 0x00
#define ATOMISP_HW_REVISION_ISP2400 0x10
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_HW_REVISION_ISP2401_LEGACY 0x11
#define ATOMISP_HW_REVISION_ISP2401 0x20
#define ATOMISP_HW_STEPPING_MASK 0x000000ff
#define ATOMISP_HW_STEPPING_A0 0x00
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_HW_STEPPING_B0 0x10
#define CI_MODE_PREVIEW 0x8000
#define CI_MODE_VIDEO 0x4000
#define CI_MODE_STILL_CAPTURE 0x2000
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define CI_MODE_CONTINUOUS 0x1000
#define CI_MODE_NONE 0x0000
#define OUTPUT_MODE_FILE 0x0100
#define OUTPUT_MODE_TEXT 0x0200
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_BUFFER_HAS_PER_FRAME_SETTING 0x80000000
#define V4L2_PIX_FMT_CUSTOM_M10MO_RAW v4l2_fourcc('M', '1', '0', '1')
#define V4L2_MBUS_FMT_CUSTOM_YUV420 0x8001
#define V4L2_MBUS_FMT_CUSTOM_YVU420 0x8002
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_MBUS_FMT_CUSTOM_YUV422P 0x8003
#define V4L2_MBUS_FMT_CUSTOM_YUV444 0x8004
#define V4L2_MBUS_FMT_CUSTOM_NV12 0x8005
#define V4L2_MBUS_FMT_CUSTOM_NV21 0x8006
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_MBUS_FMT_CUSTOM_NV16 0x8007
#define V4L2_MBUS_FMT_CUSTOM_YUYV 0x8008
#define V4L2_MBUS_FMT_CUSTOM_SBGGR16 0x8009
#define V4L2_MBUS_FMT_CUSTOM_RGB32 0x800a
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_MBUS_FMT_CUSTOM_M10MO_RAW 0x800b
struct atomisp_nr_config {
 unsigned int bnr_gain;
 unsigned int ynr_gain;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int direction;
 unsigned int threshold_cb;
 unsigned int threshold_cr;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_tnr_config {
 unsigned int gain;
 unsigned int threshold_y;
 unsigned int threshold_uv;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct atomisp_histogram {
 unsigned int num_elements;
 void __user *data;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
enum atomisp_ob_mode {
 atomisp_ob_mode_none,
 atomisp_ob_mode_fixed,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 atomisp_ob_mode_raster
};
struct atomisp_ob_config {
 enum atomisp_ob_mode mode;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int level_gr;
 unsigned int level_r;
 unsigned int level_b;
 unsigned int level_gb;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned short start_position;
 unsigned short end_position;
};
struct atomisp_ee_config {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int gain;
 unsigned int threshold;
 unsigned int detail_gain;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_3a_output {
 int ae_y;
 int awb_cnt;
 int awb_gr;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int awb_r;
 int awb_b;
 int awb_gb;
 int af_hpf1;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int af_hpf2;
};
enum atomisp_calibration_type {
 calibration_type1,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 calibration_type2,
 calibration_type3
};
struct atomisp_calibration_group {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int size;
 unsigned int type;
 unsigned short *calb_grp_values;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_gc_config {
 __u16 gain_k1;
 __u16 gain_k2;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_3a_config {
 unsigned int ae_y_coef_r;
 unsigned int ae_y_coef_g;
 unsigned int ae_y_coef_b;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int awb_lg_high_raw;
 unsigned int awb_lg_low;
 unsigned int awb_lg_high;
 int af_fir1_coef[7];
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int af_fir2_coef[7];
};
struct atomisp_dvs_grid_info {
 uint32_t enable;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t width;
 uint32_t aligned_width;
 uint32_t height;
 uint32_t aligned_height;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t bqs_per_grid_cell;
 uint32_t num_hor_coefs;
 uint32_t num_ver_coefs;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_dvs_envelop {
 unsigned int width;
 unsigned int height;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_grid_info {
 uint32_t enable;
 uint32_t use_dmem;
 uint32_t has_histogram;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t s3a_width;
 uint32_t s3a_height;
 uint32_t aligned_width;
 uint32_t aligned_height;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t s3a_bqs_per_grid_cell;
 uint32_t deci_factor_log2;
 uint32_t elem_bit_depth;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_dis_vector {
 int x;
 int y;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_dvs2_coef_types {
 short __user *odd_real;
 short __user *odd_imag;
 short __user *even_real;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 short __user *even_imag;
};
struct atomisp_dvs2_stat_types {
 int __user *odd_real;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int __user *odd_imag;
 int __user *even_real;
 int __user *even_imag;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_dis_coefficients {
 struct atomisp_dvs_grid_info grid_info;
 struct atomisp_dvs2_coef_types hor_coefs;
 struct atomisp_dvs2_coef_types ver_coefs;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct atomisp_dvs2_statistics {
 struct atomisp_dvs_grid_info grid_info;
 struct atomisp_dvs2_stat_types hor_prod;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_dvs2_stat_types ver_prod;
};
struct atomisp_dis_statistics {
 struct atomisp_dvs2_statistics dvs2_stat;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t exp_id;
};
struct atomisp_3a_rgby_output {
 uint32_t r;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t g;
 uint32_t b;
 uint32_t y;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum atomisp_metadata_type {
 ATOMISP_MAIN_METADATA = 0,
 ATOMISP_SEC_METADATA,
 ATOMISP_METADATA_TYPE_NUM,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct atomisp_metadata_with_type {
 enum atomisp_metadata_type type;
 void __user *data;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t width;
 uint32_t height;
 uint32_t stride;
 uint32_t exp_id;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t *effective_width;
};
struct atomisp_metadata {
 void __user *data;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t width;
 uint32_t height;
 uint32_t stride;
 uint32_t exp_id;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t *effective_width;
};
struct atomisp_ext_isp_ctrl {
 uint32_t id;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t data;
};
struct atomisp_3a_statistics {
 struct atomisp_grid_info grid_info;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_3a_output __user *data;
 struct atomisp_3a_rgby_output __user *rgby_data;
 uint32_t exp_id;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_cont_capture_conf {
 int num_captures;
 unsigned int skip_frames;
 int offset;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 reserved[5];
};
struct atomisp_ae_window {
 int x_left;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int x_right;
 int y_top;
 int y_bottom;
 int weight;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct atomisp_wb_config {
 unsigned int integer_bits;
 unsigned int gr;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int r;
 unsigned int b;
 unsigned int gb;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_cc_config {
 unsigned int fraction_bits;
 int matrix[3 * 3];
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_de_config {
 unsigned int pixelnoise;
 unsigned int c1_coring_threshold;
 unsigned int c2_coring_threshold;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct atomisp_ce_config {
 unsigned char uv_level_min;
 unsigned char uv_level_max;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct atomisp_dp_config {
 unsigned int threshold;
 unsigned int gain;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int gr;
 unsigned int r;
 unsigned int b;
 unsigned int gb;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct atomisp_xnr_config {
 __u16 threshold;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_metadata_config {
 uint32_t metadata_height;
 uint32_t metadata_stride;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_parm {
 struct atomisp_grid_info info;
 struct atomisp_dvs_grid_info dvs_grid;
 struct atomisp_dvs_envelop dvs_envelop;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_wb_config wb_config;
 struct atomisp_cc_config cc_config;
 struct atomisp_ob_config ob_config;
 struct atomisp_de_config de_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_ce_config ce_config;
 struct atomisp_dp_config dp_config;
 struct atomisp_nr_config nr_config;
 struct atomisp_ee_config ee_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_tnr_config tnr_config;
 struct atomisp_metadata_config metadata_config;
};
struct dvs2_bq_resolution {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int width_bq;
 int height_bq;
};
struct atomisp_dvs2_bq_resolutions {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct dvs2_bq_resolution source_bq;
 struct dvs2_bq_resolution output_bq;
 struct dvs2_bq_resolution envelope_bq;
 struct dvs2_bq_resolution ispfilter_bq;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct dvs2_bq_resolution gdc_shift_bq;
};
struct atomisp_dvs_6axis_config {
 uint32_t exp_id;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t width_y;
 uint32_t height_y;
 uint32_t width_uv;
 uint32_t height_uv;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint32_t *xcoords_y;
 uint32_t *ycoords_y;
 uint32_t *xcoords_uv;
 uint32_t *ycoords_uv;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct atomisp_formats_config {
 uint32_t video_full_range_flag;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_parameters {
 struct atomisp_wb_config *wb_config;
 struct atomisp_cc_config *cc_config;
 struct atomisp_tnr_config *tnr_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_ecd_config *ecd_config;
 struct atomisp_ynr_config *ynr_config;
 struct atomisp_fc_config *fc_config;
 struct atomisp_formats_config *formats_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_cnr_config *cnr_config;
 struct atomisp_macc_config *macc_config;
 struct atomisp_ctc_config *ctc_config;
 struct atomisp_aa_config *aa_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_aa_config *baa_config;
 struct atomisp_ce_config *ce_config;
 struct atomisp_dvs_6axis_config *dvs_6axis_config;
 struct atomisp_ob_config *ob_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_dp_config *dp_config;
 struct atomisp_nr_config *nr_config;
 struct atomisp_ee_config *ee_config;
 struct atomisp_de_config *de_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_gc_config *gc_config;
 struct atomisp_anr_config *anr_config;
 struct atomisp_3a_config *a3a_config;
 struct atomisp_xnr_config *xnr_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_dz_config *dz_config;
 struct atomisp_cc_config *yuv2rgb_cc_config;
 struct atomisp_cc_config *rgb2yuv_cc_config;
 struct atomisp_macc_table *macc_table;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_gamma_table *gamma_table;
 struct atomisp_ctc_table *ctc_table;
 struct atomisp_xnr_table *xnr_table;
 struct atomisp_rgb_gamma_table *r_gamma_table;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_rgb_gamma_table *g_gamma_table;
 struct atomisp_rgb_gamma_table *b_gamma_table;
 struct atomisp_vector *motion_vector;
 struct atomisp_shading_table *shading_table;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_morph_table *morph_table;
 struct atomisp_dvs_coefficients *dvs_coefs;
 struct atomisp_dvs2_coefficients *dvs2_coefs;
 struct atomisp_capture_config *capture_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 struct atomisp_anr_thres *anr_thres;
 void *lin_2500_config;
 void *obgrid_2500_config;
 void *bnr_2500_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 void *shd_2500_config;
 void *dm_2500_config;
 void *rgbpp_2500_config;
 void *dvs_stat_2500_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 void *lace_stat_2500_config;
 void *yuvp1_2500_config;
 void *yuvp2_2500_config;
 void *tnr_2500_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 void *dpc_2500_config;
 void *awb_2500_config;
 void *awb_fr_2500_config;
 void *anr_2500_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 void *af_2500_config;
 void *ae_2500_config;
 void *bds_2500_config;
 void *dvs_2500_config;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 void *res_mgr_2500_config;
 void *output_frame;
 uint32_t isp_config_id;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_GAMMA_TABLE_SIZE 1024
struct atomisp_gamma_table {
 unsigned short data[ATOMISP_GAMMA_TABLE_SIZE];
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_MORPH_TABLE_NUM_PLANES 6
struct atomisp_morph_table {
 unsigned int enabled;
 unsigned int height;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int width;
 unsigned short __user *coordinates_x[ATOMISP_MORPH_TABLE_NUM_PLANES];
 unsigned short __user *coordinates_y[ATOMISP_MORPH_TABLE_NUM_PLANES];
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_NUM_SC_COLORS 4
#define ATOMISP_SC_FLAG_QUERY (1 << 0)
struct atomisp_shading_table {
 __u32 enable;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 sensor_width;
 __u32 sensor_height;
 __u32 width;
 __u32 height;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 fraction_bits;
 __u16 *data[ATOMISP_NUM_SC_COLORS];
};
struct atomisp_makernote_info {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int focal_length;
 unsigned int f_number_curr;
 unsigned int f_number_range;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_NUM_MACC_AXES 16
struct atomisp_macc_table {
 short data[4 * ATOMISP_NUM_MACC_AXES];
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_macc_config {
 int color_effect;
 struct atomisp_macc_table table;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_CTC_TABLE_SIZE 1024
struct atomisp_ctc_table {
 unsigned short data[ATOMISP_CTC_TABLE_SIZE];
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_overlay {
 struct v4l2_framebuffer *frame;
 unsigned char bg_y;
 char bg_u;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 char bg_v;
 unsigned char blend_input_perc_y;
 unsigned char blend_input_perc_u;
 unsigned char blend_input_perc_v;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned char blend_overlay_perc_y;
 unsigned char blend_overlay_perc_u;
 unsigned char blend_overlay_perc_v;
 unsigned int overlay_start_x;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int overlay_start_y;
};
struct atomisp_sensor_mode_data {
 unsigned int coarse_integration_time_min;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int coarse_integration_time_max_margin;
 unsigned int fine_integration_time_min;
 unsigned int fine_integration_time_max_margin;
 unsigned int fine_integration_time_def;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int frame_length_lines;
 unsigned int line_length_pck;
 unsigned int read_mode;
 unsigned int vt_pix_clk_freq_mhz;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int crop_horizontal_start;
 unsigned int crop_vertical_start;
 unsigned int crop_horizontal_end;
 unsigned int crop_vertical_end;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int output_width;
 unsigned int output_height;
 uint8_t binning_factor_x;
 uint8_t binning_factor_y;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 uint8_t reserved[2];
};
struct atomisp_exposure {
 unsigned int integration_time[8];
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int shutter_speed[8];
 unsigned int gain[4];
 unsigned int aperture;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_bc_video_package {
 int ioctl_cmd;
 int device_id;
 int inputparam;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 int outputparam;
};
enum atomisp_focus_hp {
 ATOMISP_FOCUS_HP_IN_PROGRESS = (1U << 2),
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_FOCUS_HP_COMPLETE = (2U << 2),
 ATOMISP_FOCUS_HP_FAILED = (3U << 2)
};
#define ATOMISP_FOCUS_STATUS_MOVING (1U << 0)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_FOCUS_STATUS_ACCEPTS_NEW_MOVE (1U << 1)
#define ATOMISP_FOCUS_STATUS_HOME_POSITION (3U << 2)
enum atomisp_camera_port {
 ATOMISP_CAMERA_PORT_SECONDARY,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_CAMERA_PORT_PRIMARY,
 ATOMISP_CAMERA_PORT_TERTIARY,
 ATOMISP_CAMERA_NR_PORTS
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum atomisp_flash_mode {
 ATOMISP_FLASH_MODE_OFF,
 ATOMISP_FLASH_MODE_FLASH,
 ATOMISP_FLASH_MODE_TORCH,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_FLASH_MODE_INDICATOR,
};
enum atomisp_flash_status {
 ATOMISP_FLASH_STATUS_OK,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_FLASH_STATUS_HW_ERROR,
 ATOMISP_FLASH_STATUS_INTERRUPTED,
 ATOMISP_FLASH_STATUS_TIMEOUT,
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum atomisp_frame_status {
 ATOMISP_FRAME_STATUS_OK,
 ATOMISP_FRAME_STATUS_CORRUPTED,
 ATOMISP_FRAME_STATUS_FLASH_EXPOSED,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_FRAME_STATUS_FLASH_PARTIAL,
 ATOMISP_FRAME_STATUS_FLASH_FAILED,
};
enum atomisp_acc_type {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_ACC_STANDALONE,
 ATOMISP_ACC_OUTPUT,
 ATOMISP_ACC_VIEWFINDER
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
enum atomisp_acc_arg_type {
 ATOMISP_ACC_ARG_SCALAR_IN,
 ATOMISP_ACC_ARG_SCALAR_OUT,
 ATOMISP_ACC_ARG_SCALAR_IO,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_ACC_ARG_PTR_IN,
 ATOMISP_ACC_ARG_PTR_OUT,
 ATOMISP_ACC_ARG_PTR_IO,
 ATOMISP_ARG_PTR_NOFLUSH,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_ARG_PTR_STABLE,
 ATOMISP_ACC_ARG_FRAME
};
enum atomisp_acc_memory {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_ACC_MEMORY_PMEM0 = 0,
 ATOMISP_ACC_MEMORY_DMEM0,
 ATOMISP_ACC_MEMORY_DMEM = ATOMISP_ACC_MEMORY_DMEM0,
 ATOMISP_ACC_MEMORY_VMEM0,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_ACC_MEMORY_VAMEM0,
 ATOMISP_ACC_MEMORY_VAMEM1,
 ATOMISP_ACC_MEMORY_VAMEM2,
 ATOMISP_ACC_MEMORY_HMEM0,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 ATOMISP_ACC_NR_MEMORY
};
enum atomisp_ext_isp_id {
 EXT_ISP_CID_ISO = 0,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 EXT_ISP_CID_CAPTURE_HDR,
 EXT_ISP_CID_CAPTURE_LLS,
 EXT_ISP_CID_FOCUS_MODE,
 EXT_ISP_CID_FOCUS_EXECUTION,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 EXT_ISP_CID_TOUCH_POSX,
 EXT_ISP_CID_TOUCH_POSY,
 EXT_ISP_CID_CAF_STATUS,
 EXT_ISP_CID_AF_STATUS,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 EXT_ISP_CID_GET_AF_MODE,
 EXT_ISP_CID_CAPTURE_BURST,
 EXT_ISP_CID_FLASH_MODE,
 EXT_ISP_CID_ZOOM,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 EXT_ISP_CID_SHOT_MODE
};
#define EXT_ISP_FOCUS_MODE_NORMAL 0
#define EXT_ISP_FOCUS_MODE_MACRO 1
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define EXT_ISP_FOCUS_MODE_TOUCH_AF 2
#define EXT_ISP_FOCUS_MODE_PREVIEW_CAF 3
#define EXT_ISP_FOCUS_MODE_MOVIE_CAF 4
#define EXT_ISP_FOCUS_MODE_FACE_CAF 5
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define EXT_ISP_FOCUS_MODE_TOUCH_MACRO 6
#define EXT_ISP_FOCUS_MODE_TOUCH_CAF 7
#define EXT_ISP_FOCUS_STOP 0
#define EXT_ISP_FOCUS_SEARCH 1
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define EXT_ISP_PAN_FOCUSING 2
#define EXT_ISP_CAF_RESTART_CHECK 1
#define EXT_ISP_CAF_STATUS_FOCUSING 2
#define EXT_ISP_CAF_STATUS_SUCCESS 3
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define EXT_ISP_CAF_STATUS_FAIL 4
#define EXT_ISP_AF_STATUS_INVALID 1
#define EXT_ISP_AF_STATUS_FOCUSING 2
#define EXT_ISP_AF_STATUS_SUCCESS 3
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define EXT_ISP_AF_STATUS_FAIL 4
enum atomisp_burst_capture_options {
 EXT_ISP_BURST_CAPTURE_CTRL_START = 0,
 EXT_ISP_BURST_CAPTURE_CTRL_STOP
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
#define EXT_ISP_FLASH_MODE_OFF 0
#define EXT_ISP_FLASH_MODE_ON 1
#define EXT_ISP_FLASH_MODE_AUTO 2
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define EXT_ISP_LED_TORCH_OFF 3
#define EXT_ISP_LED_TORCH_ON 4
#define EXT_ISP_SHOT_MODE_AUTO 0
#define EXT_ISP_SHOT_MODE_BEAUTY_FACE 1
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define EXT_ISP_SHOT_MODE_BEST_PHOTO 2
#define EXT_ISP_SHOT_MODE_DRAMA 3
#define EXT_ISP_SHOT_MODE_BEST_FACE 4
#define EXT_ISP_SHOT_MODE_ERASER 5
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define EXT_ISP_SHOT_MODE_PANORAMA 6
#define EXT_ISP_SHOT_MODE_RICH_TONE_HDR 7
#define EXT_ISP_SHOT_MODE_NIGHT 8
#define EXT_ISP_SHOT_MODE_SOUND_SHOT 9
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define EXT_ISP_SHOT_MODE_ANIMATED_PHOTO 10
#define EXT_ISP_SHOT_MODE_SPORTS 11
struct atomisp_sp_arg {
 enum atomisp_acc_arg_type type;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 void *value;
 unsigned int size;
};
struct atomisp_acc_fw_arg {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int fw_handle;
 unsigned int index;
 void __user *value;
 size_t size;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
struct atomisp_acc_s_mapped_arg {
 unsigned int fw_handle;
 __u32 memory;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 size_t length;
 unsigned long css_ptr;
};
struct atomisp_acc_fw_abort {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int fw_handle;
 unsigned int timeout;
};
struct atomisp_acc_fw_load {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 unsigned int size;
 unsigned int fw_handle;
 void __user *data;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct atomisp_acc_fw_load_to_pipe {
 __u32 flags;
 unsigned int fw_handle;
 __u32 size;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 void __user *data;
 __u32 type;
 __u32 reserved[3];
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_ACC_FW_LOAD_FL_PREVIEW (1 << 0)
#define ATOMISP_ACC_FW_LOAD_FL_COPY (1 << 1)
#define ATOMISP_ACC_FW_LOAD_FL_VIDEO (1 << 2)
#define ATOMISP_ACC_FW_LOAD_FL_CAPTURE (1 << 3)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_ACC_FW_LOAD_FL_ACC (1 << 4)
#define ATOMISP_ACC_FW_LOAD_FL_ENABLE (1 << 16)
#define ATOMISP_ACC_FW_LOAD_TYPE_NONE 0
#define ATOMISP_ACC_FW_LOAD_TYPE_OUTPUT 1
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_ACC_FW_LOAD_TYPE_VIEWFINDER 2
#define ATOMISP_ACC_FW_LOAD_TYPE_STANDALONE 3
struct atomisp_acc_map {
 __u32 flags;
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 length;
 void __user *user_ptr;
 unsigned long css_ptr;
 __u32 reserved[4];
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
#define ATOMISP_MAP_FLAG_NOFLUSH 0x0001
#define ATOMISP_MAP_FLAG_CACHED 0x0002
struct atomisp_acc_state {
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 __u32 flags;
#define ATOMISP_STATE_FLAG_ENABLE ATOMISP_ACC_FW_LOAD_FL_ENABLE
 unsigned int fw_handle;
};
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
struct v4l2_private_int_data {
 __u32 size;
 void __user *data;
 __u32 reserved[2];
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
};
#define ATOMISP_IOC_G_XNR   _IOR('v', BASE_VIDIOC_PRIVATE + 0, int)
#define ATOMISP_IOC_S_XNR   _IOW('v', BASE_VIDIOC_PRIVATE + 0, int)
#define ATOMISP_IOC_G_NR   _IOR('v', BASE_VIDIOC_PRIVATE + 1, struct atomisp_nr_config)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_S_NR   _IOW('v', BASE_VIDIOC_PRIVATE + 1, struct atomisp_nr_config)
#define ATOMISP_IOC_G_TNR   _IOR('v', BASE_VIDIOC_PRIVATE + 2, struct atomisp_tnr_config)
#define ATOMISP_IOC_S_TNR   _IOW('v', BASE_VIDIOC_PRIVATE + 2, struct atomisp_tnr_config)
#define ATOMISP_IOC_G_HISTOGRAM   _IOWR('v', BASE_VIDIOC_PRIVATE + 3, struct atomisp_histogram)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_S_HISTOGRAM   _IOW('v', BASE_VIDIOC_PRIVATE + 3, struct atomisp_histogram)
#define ATOMISP_IOC_G_BLACK_LEVEL_COMP   _IOR('v', BASE_VIDIOC_PRIVATE + 4, struct atomisp_ob_config)
#define ATOMISP_IOC_S_BLACK_LEVEL_COMP   _IOW('v', BASE_VIDIOC_PRIVATE + 4, struct atomisp_ob_config)
#define ATOMISP_IOC_G_EE   _IOR('v', BASE_VIDIOC_PRIVATE + 5, struct atomisp_ee_config)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_S_EE   _IOW('v', BASE_VIDIOC_PRIVATE + 5, struct atomisp_ee_config)
#define ATOMISP_IOC_G_DIS_STAT   _IOWR('v', BASE_VIDIOC_PRIVATE + 6, struct atomisp_dis_statistics)
#define ATOMISP_IOC_G_DVS2_BQ_RESOLUTIONS   _IOR('v', BASE_VIDIOC_PRIVATE + 6, struct atomisp_dvs2_bq_resolutions)
#define ATOMISP_IOC_S_DIS_COEFS   _IOW('v', BASE_VIDIOC_PRIVATE + 6, struct atomisp_dis_coefficients)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_S_DIS_VECTOR   _IOW('v', BASE_VIDIOC_PRIVATE + 6, struct atomisp_dvs_6axis_config)
#define ATOMISP_IOC_G_3A_STAT   _IOWR('v', BASE_VIDIOC_PRIVATE + 7, struct atomisp_3a_statistics)
#define ATOMISP_IOC_G_ISP_PARM   _IOR('v', BASE_VIDIOC_PRIVATE + 8, struct atomisp_parm)
#define ATOMISP_IOC_S_ISP_PARM   _IOW('v', BASE_VIDIOC_PRIVATE + 8, struct atomisp_parm)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_G_ISP_GAMMA   _IOR('v', BASE_VIDIOC_PRIVATE + 9, struct atomisp_gamma_table)
#define ATOMISP_IOC_S_ISP_GAMMA   _IOW('v', BASE_VIDIOC_PRIVATE + 9, struct atomisp_gamma_table)
#define ATOMISP_IOC_G_ISP_GDC_TAB   _IOR('v', BASE_VIDIOC_PRIVATE + 10, struct atomisp_morph_table)
#define ATOMISP_IOC_S_ISP_GDC_TAB   _IOW('v', BASE_VIDIOC_PRIVATE + 10, struct atomisp_morph_table)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_ISP_MAKERNOTE   _IOWR('v', BASE_VIDIOC_PRIVATE + 11, struct atomisp_makernote_info)
#define ATOMISP_IOC_G_ISP_MACC   _IOR('v', BASE_VIDIOC_PRIVATE + 12, struct atomisp_macc_config)
#define ATOMISP_IOC_S_ISP_MACC   _IOW('v', BASE_VIDIOC_PRIVATE + 12, struct atomisp_macc_config)
#define ATOMISP_IOC_G_ISP_BAD_PIXEL_DETECTION   _IOR('v', BASE_VIDIOC_PRIVATE + 13, struct atomisp_dp_config)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_S_ISP_BAD_PIXEL_DETECTION   _IOW('v', BASE_VIDIOC_PRIVATE + 13, struct atomisp_dp_config)
#define ATOMISP_IOC_G_ISP_FALSE_COLOR_CORRECTION   _IOR('v', BASE_VIDIOC_PRIVATE + 14, struct atomisp_de_config)
#define ATOMISP_IOC_S_ISP_FALSE_COLOR_CORRECTION   _IOW('v', BASE_VIDIOC_PRIVATE + 14, struct atomisp_de_config)
#define ATOMISP_IOC_G_ISP_CTC   _IOR('v', BASE_VIDIOC_PRIVATE + 15, struct atomisp_ctc_table)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_S_ISP_CTC   _IOW('v', BASE_VIDIOC_PRIVATE + 15, struct atomisp_ctc_table)
#define ATOMISP_IOC_G_ISP_WHITE_BALANCE   _IOR('v', BASE_VIDIOC_PRIVATE + 16, struct atomisp_wb_config)
#define ATOMISP_IOC_S_ISP_WHITE_BALANCE   _IOW('v', BASE_VIDIOC_PRIVATE + 16, struct atomisp_wb_config)
#define ATOMISP_IOC_S_ISP_FPN_TABLE   _IOW('v', BASE_VIDIOC_PRIVATE + 17, struct v4l2_framebuffer)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_G_ISP_OVERLAY   _IOWR('v', BASE_VIDIOC_PRIVATE + 18, struct atomisp_overlay)
#define ATOMISP_IOC_S_ISP_OVERLAY   _IOW('v', BASE_VIDIOC_PRIVATE + 18, struct atomisp_overlay)
#define ATOMISP_IOC_CAMERA_BRIDGE   _IOWR('v', BASE_VIDIOC_PRIVATE + 19, struct atomisp_bc_video_package)
#define ATOMISP_IOC_G_SENSOR_MODE_DATA   _IOR('v', BASE_VIDIOC_PRIVATE + 20, struct atomisp_sensor_mode_data)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_S_EXPOSURE   _IOW('v', BASE_VIDIOC_PRIVATE + 21, struct atomisp_exposure)
#define ATOMISP_IOC_G_SENSOR_CALIBRATION_GROUP   _IOWR('v', BASE_VIDIOC_PRIVATE + 22, struct atomisp_calibration_group)
#define ATOMISP_IOC_G_3A_CONFIG   _IOR('v', BASE_VIDIOC_PRIVATE + 23, struct atomisp_3a_config)
#define ATOMISP_IOC_S_3A_CONFIG   _IOW('v', BASE_VIDIOC_PRIVATE + 23, struct atomisp_3a_config)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_ACC_LOAD   _IOWR('v', BASE_VIDIOC_PRIVATE + 24, struct atomisp_acc_fw_load)
#define ATOMISP_IOC_ACC_UNLOAD   _IOWR('v', BASE_VIDIOC_PRIVATE + 24, unsigned int)
#define ATOMISP_IOC_ACC_S_ARG   _IOW('v', BASE_VIDIOC_PRIVATE + 24, struct atomisp_acc_fw_arg)
#define ATOMISP_IOC_ACC_START   _IOW('v', BASE_VIDIOC_PRIVATE + 24, unsigned int)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_ACC_WAIT   _IOW('v', BASE_VIDIOC_PRIVATE + 25, unsigned int)
#define ATOMISP_IOC_ACC_ABORT   _IOW('v', BASE_VIDIOC_PRIVATE + 25, struct atomisp_acc_fw_abort)
#define ATOMISP_IOC_ACC_DESTAB   _IOW('v', BASE_VIDIOC_PRIVATE + 25, struct atomisp_acc_fw_arg)
#define ATOMISP_IOC_G_SENSOR_PRIV_INT_DATA   _IOWR('v', BASE_VIDIOC_PRIVATE + 26, struct v4l2_private_int_data)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_S_ISP_SHD_TAB   _IOWR('v', BASE_VIDIOC_PRIVATE + 27, struct atomisp_shading_table)
#define ATOMISP_IOC_G_ISP_GAMMA_CORRECTION   _IOR('v', BASE_VIDIOC_PRIVATE + 28, struct atomisp_gc_config)
#define ATOMISP_IOC_S_ISP_GAMMA_CORRECTION   _IOW('v', BASE_VIDIOC_PRIVATE + 28, struct atomisp_gc_config)
#define ATOMISP_IOC_G_MOTOR_PRIV_INT_DATA   _IOWR('v', BASE_VIDIOC_PRIVATE + 29, struct v4l2_private_int_data)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_ACC_MAP   _IOWR('v', BASE_VIDIOC_PRIVATE + 30, struct atomisp_acc_map)
#define ATOMISP_IOC_ACC_UNMAP   _IOW('v', BASE_VIDIOC_PRIVATE + 30, struct atomisp_acc_map)
#define ATOMISP_IOC_ACC_S_MAPPED_ARG   _IOW('v', BASE_VIDIOC_PRIVATE + 30, struct atomisp_acc_s_mapped_arg)
#define ATOMISP_IOC_ACC_LOAD_TO_PIPE   _IOWR('v', BASE_VIDIOC_PRIVATE + 31, struct atomisp_acc_fw_load_to_pipe)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_S_PARAMETERS   _IOW('v', BASE_VIDIOC_PRIVATE + 32, struct atomisp_parameters)
#define ATOMISP_IOC_S_CONT_CAPTURE_CONFIG   _IOWR('v', BASE_VIDIOC_PRIVATE + 33, struct atomisp_cont_capture_conf)
#define ATOMISP_IOC_G_METADATA   _IOWR('v', BASE_VIDIOC_PRIVATE + 34, struct atomisp_metadata)
#define ATOMISP_IOC_G_METADATA_BY_TYPE   _IOWR('v', BASE_VIDIOC_PRIVATE + 34, struct atomisp_metadata_with_type)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_EXT_ISP_CTRL   _IOWR('v', BASE_VIDIOC_PRIVATE + 35, struct atomisp_ext_isp_ctrl)
#define ATOMISP_IOC_EXP_ID_UNLOCK   _IOW('v', BASE_VIDIOC_PRIVATE + 36, int)
#define ATOMISP_IOC_EXP_ID_CAPTURE   _IOW('v', BASE_VIDIOC_PRIVATE + 37, int)
#define ATOMISP_IOC_S_ENABLE_DZ_CAPT_PIPE   _IOWR('v', BASE_VIDIOC_PRIVATE + 38, unsigned int)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_G_FORMATS_CONFIG   _IOR('v', BASE_VIDIOC_PRIVATE + 39, struct atomisp_formats_config)
#define ATOMISP_IOC_S_FORMATS_CONFIG   _IOW('v', BASE_VIDIOC_PRIVATE + 39, struct atomisp_formats_config)
#define ATOMISP_IOC_S_EXPOSURE_WINDOW   _IOW('v', BASE_VIDIOC_PRIVATE + 40, struct atomisp_ae_window)
#define ATOMISP_IOC_S_ACC_STATE   _IOW('v', BASE_VIDIOC_PRIVATE + 41, struct atomisp_acc_state)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_IOC_G_ACC_STATE   _IOR('v', BASE_VIDIOC_PRIVATE + 41, struct atomisp_acc_state)
#define V4L2_CID_ATOMISP_BAD_PIXEL_DETECTION   (V4L2_CID_PRIVATE_BASE + 0)
#define V4L2_CID_ATOMISP_POSTPROCESS_GDC_CAC   (V4L2_CID_PRIVATE_BASE + 1)
#define V4L2_CID_ATOMISP_VIDEO_STABLIZATION   (V4L2_CID_PRIVATE_BASE + 2)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_CID_ATOMISP_FIXED_PATTERN_NR   (V4L2_CID_PRIVATE_BASE + 3)
#define V4L2_CID_ATOMISP_FALSE_COLOR_CORRECTION   (V4L2_CID_PRIVATE_BASE + 4)
#define V4L2_CID_ATOMISP_LOW_LIGHT   (V4L2_CID_PRIVATE_BASE + 5)
#define V4L2_CID_CAMERA_LASTP1 (V4L2_CID_CAMERA_CLASS_BASE + 1024)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_CID_FOCAL_ABSOLUTE (V4L2_CID_CAMERA_LASTP1 + 0)
#define V4L2_CID_FNUMBER_ABSOLUTE (V4L2_CID_CAMERA_LASTP1 + 1)
#define V4L2_CID_FNUMBER_RANGE (V4L2_CID_CAMERA_LASTP1 + 2)
#define V4L2_CID_REQUEST_FLASH (V4L2_CID_CAMERA_LASTP1 + 3)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_CID_FLASH_STATUS (V4L2_CID_CAMERA_LASTP1 + 5)
#define V4L2_CID_FLASH_MODE (V4L2_CID_CAMERA_LASTP1 + 10)
#define V4L2_CID_VCM_SLEW (V4L2_CID_CAMERA_LASTP1 + 11)
#define V4L2_CID_VCM_TIMEING (V4L2_CID_CAMERA_LASTP1 + 12)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_CID_FOCUS_STATUS (V4L2_CID_CAMERA_LASTP1 + 14)
#define V4L2_CID_BIN_FACTOR_HORZ (V4L2_CID_CAMERA_LASTP1 + 15)
#define V4L2_CID_BIN_FACTOR_VERT (V4L2_CID_CAMERA_LASTP1 + 16)
#define V4L2_CID_G_SKIP_FRAMES (V4L2_CID_CAMERA_LASTP1 + 17)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_CID_2A_STATUS (V4L2_CID_CAMERA_LASTP1 + 18)
#define V4L2_2A_STATUS_AE_READY (1 << 0)
#define V4L2_2A_STATUS_AWB_READY (1 << 1)
#define V4L2_CID_FMT_AUTO (V4L2_CID_CAMERA_LASTP1 + 19)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_CID_RUN_MODE (V4L2_CID_CAMERA_LASTP1 + 20)
#define ATOMISP_RUN_MODE_VIDEO 1
#define ATOMISP_RUN_MODE_STILL_CAPTURE 2
#define ATOMISP_RUN_MODE_CONTINUOUS_CAPTURE 3
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_RUN_MODE_PREVIEW 4
#define ATOMISP_RUN_MODE_SDV 5
#define V4L2_CID_ENABLE_VFPP (V4L2_CID_CAMERA_LASTP1 + 21)
#define V4L2_CID_ATOMISP_CONTINUOUS_MODE (V4L2_CID_CAMERA_LASTP1 + 22)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_CID_ATOMISP_CONTINUOUS_RAW_BUFFER_SIZE   (V4L2_CID_CAMERA_LASTP1 + 23)
#define V4L2_CID_ATOMISP_CONTINUOUS_VIEWFINDER   (V4L2_CID_CAMERA_LASTP1 + 24)
#define V4L2_CID_VFPP (V4L2_CID_CAMERA_LASTP1 + 25)
#define ATOMISP_VFPP_ENABLE 0
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define ATOMISP_VFPP_DISABLE_SCALER 1
#define ATOMISP_VFPP_DISABLE_LOWLAT 2
#define V4L2_CID_FLASH_STATUS_REGISTER (V4L2_CID_CAMERA_LASTP1 + 26)
#define V4L2_CID_START_ZSL_CAPTURE (V4L2_CID_CAMERA_LASTP1 + 28)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_CID_ENABLE_RAW_BUFFER_LOCK (V4L2_CID_CAMERA_LASTP1 + 29)
#define V4L2_CID_DEPTH_MODE (V4L2_CID_CAMERA_LASTP1 + 30)
#define V4L2_CID_EXPOSURE_ZONE_NUM (V4L2_CID_CAMERA_LASTP1 + 31)
#define V4L2_BUF_FLAG_BUFFER_INVALID 0x0400
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_BUF_FLAG_BUFFER_VALID 0x0800
#define V4L2_BUF_TYPE_VIDEO_CAPTURE_ION (V4L2_BUF_TYPE_PRIVATE + 1024)
#define V4L2_EVENT_ATOMISP_3A_STATS_READY (V4L2_EVENT_PRIVATE_START + 1)
#define V4L2_EVENT_ATOMISP_METADATA_READY (V4L2_EVENT_PRIVATE_START + 2)
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
#define V4L2_EVENT_ATOMISP_RAW_BUFFERS_ALLOC_DONE (V4L2_EVENT_PRIVATE_START + 3)
#define V4L2_EVENT_ATOMISP_ACC_COMPLETE (V4L2_EVENT_PRIVATE_START + 4)
enum {
 V4L2_COLORFX_SKIN_WHITEN_LOW = 1001,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 V4L2_COLORFX_SKIN_WHITEN_HIGH = 1002,
 V4L2_COLORFX_WARM = 1003,
 V4L2_COLORFX_COLD = 1004,
 V4L2_COLORFX_WASHED = 1005,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 V4L2_COLORFX_RED = 1006,
 V4L2_COLORFX_GREEN = 1007,
 V4L2_COLORFX_BLUE = 1008,
 V4L2_COLORFX_PINK = 1009,
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
 V4L2_COLORFX_YELLOW = 1010,
 V4L2_COLORFX_PURPLE = 1011,
};
#endif
/* WARNING: DO NOT EDIT, AUTO-GENERATED CODE - SEE TOP FOR INSTRUCTIONS */
