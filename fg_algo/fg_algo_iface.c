/*FG Algo interface file */
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <dirent.h>
#include <poll.h>

#include "libfg/fg.h"
#include "libfg/android_fg.h"

#include <cutils/log.h>
#include <cutils/klog.h>

#define DEBUG_TAG "fg_algo_iface"
#define LOG_TAG "EM FG ALGO Iface:"

#define FG_ALGO_KLOG_LEVEL 3
#define KLOGE(x...) do { KLOG_ERROR(DEBUG_TAG, x); } while (0)
#define KLOGI(x...) do { KLOG_INFO(DEBUG_TAG, x); } while (0)
#define KLOGD(x...) do { KLOG_DEBUG(DEBUG_TAG, x); } while (0)

#define FG_SYSPATH "/sys/class/misc/intel_fg_iface"
#define FG_SUBSYS "intel_fg_iface"
#define FG_UEVENT_PATH "/sys/class/misc/intel_fg_iface/uevent"

#define MAX_FG_ATTR 13
#define MAX_PATH_LEN 256

/*PMIC Vendor suggested V_aDJUST Factor*/
#define VADJUST	150
/*
 * BYT-CR 5120mAhr Battery config data.
 */
/* FG Calibration */
const struct cal_config cal_volt = {
	.offset = 0,
	.slope = 0x8000,
};

const struct cal_config cal_cur = {
	.offset = 0,
	.slope = 0x8000,
};

const struct cal_config cal_temp = {
	.offset = 0,
	.slope = 0x8000,
};

/* EDV Configuration */
const struct edv_config edv_cfg = {
	.averaging = false, /* not using averaging value */
	/* polling interval seq_edv = Max 60 sec */
	.seq_edv = 2,
	.overload_current = 2000,  /* 2A */
	/* system termination voltage */
	.term_voltage = 3400,
	.z_factor = 200,
	.edv = { /* need to change */
		{3412, 0},
		{3625, 5},
		{3642, 10},
	},
};

#define UNIT_U  1000
#define OCV_TABLE_SIZE 21

const struct rate_config rate_cfg = {
	.max_rate = 200,
	.min_rate = 50,
	.chg_gain = 5,
	.dsg_gain = 5,
};
/* OCV Configuration */
const struct ocv_config ocv_cfg = {
	.voltage_diff = 75,
	.current_diff = 30,

	.sleep_enter_current = 60,
	.sleep_enter_samples = 3,

	.sleep_exit_current = 80,
	.sleep_exit_samples = 3,

	.long_sleep_current = 200,
	.ocv_period = 600,
	.relax_period = 1800,

	.flat_zone_low = 3721,
	.flat_zone_high = 3768,

	/*New values*/
	.c_factor = 0,
	.z_factor = 100,
	.fcc_update_valid_min = 10,
	.fcc_update_valid_max = 90,
	.table_size = OCV_TABLE_SIZE,
	/* %, max SOC correction by OCV */
	.max_delta = 1,

	.table = {
		3412, 3625, 3642, 3679, 3704,
		3721, 3734, 3750, 3768, 3790,
		3816, 3847, 3890, 3938, 3989,
		4040, 4094, 4149, 4206, 4264,
		4310
	},
};

/* General Battery Cell Configuration */
const struct cell_config cell_cfg =  {
	.cc_voltage = 4250, /* need to change */
	.cc_current = 270, /* can be changed, if needed */
	.cc_q = 300, /* uAh, 18mA*60sec */
	.seq_cc = 3, /* polling interval * n, max 80secs */
	.cc_term_voltage = 4355, /* max bat charging term voltage */

	.ocv_below_edv1 = false,

	.design_capacity = 4895 * UNIT_U, /* uAh - need to change */
	.r_sense = 10, /* 20mohm - need to change*/
	.fcc_adjust = 2 * UNIT_U, /* uAh */
	.max_impedance = 300, /* mohm - no chnage*/

	.max_overcharge = 10, /* % of fcc */

	.max_fcc_delta = 2, /* %, fcc*0.02 */

	.low_temp = 119,
	.light_load = 20,  /* current = fcc/light_load, C/17*/
	.near_full = 90, /* %,  fcc*0.9 */

	.recharge = 93, /* for CC clear %, fcc*0.93 */ /*80 * UNIT_U */

	.mode_switch_capacity = 5 * UNIT_U, /* uAh */

	.ocv = &ocv_cfg,
	.edv = &edv_cfg,
	.rate = &rate_cfg,
	.cal_volt = &cal_volt,
	.cal_cur = &cal_cur,
	.cal_temp = &cal_temp,
};

static struct cell_state ti_fg_cell_cfg = {
	.config = &cell_cfg,
};

struct fg_iface_attr_type {
	char *name;
	int id;
	int val;
};

enum {
	VOLT_NOW = 0,
	VOLT_OCV,
	VOLT_BOOT,
	IBAT_BOOT,
	CUR_NOW,
	CUR_AVG,
	BATT_TEMP,
	DELTA_Q,
	CAPACITY,
	NAC,
	FCC,
	CYC_CNT,
	CC_CALIB
} fg_attr;

static struct fg_iface_attr_type fg_att[MAX_FG_ATTR] = {
	{.name = "volt_now",	.id = VOLT_NOW,	.val = 0},
	{.name = "volt_ocv",	.id = VOLT_OCV,	.val = 0},
	{.name = "volt_boot",	.id = VOLT_BOOT, .val = 0},
	{.name = "ibat_boot",	.id = IBAT_BOOT, .val = 0},
	{.name = "cur_now",		.id = CUR_NOW,	.val = 0},
	{.name = "cur_avg",		.id = CUR_AVG,	.val = 0},
	{.name = "batt_temp",	.id = BATT_TEMP, .val = 0},
	{.name = "delta_q",		.id = DELTA_Q,	.val = 0},
	{.name = "capacity",	.id = CAPACITY,	.val = 0},
	{.name = "nac",			.id = NAC,		.val = 0},
	{.name = "fcc",			.id = FCC,		.val = 0},
	{.name = "cyc_cnt",		.id = CYC_CNT,	.val = 0},
	{.name = "cc_calib",	.id = CC_CALIB,	.val = 0},
};

/*
 * read_sysfs_attr: Function to read an attribute from the given syspath
 *	@syspath: path in the sysfs of the attr which has to be read.
 *	@attr: Name of the attribute within the syspath to be read.
 *	@val: Vlaue of the attribute in integer format which has to
 *			returned to the caller.
 *	@Returns: 0 for success, negetive error code on failure.
 */
static int read_sysfs_attr(const char *syspath, const char *attr, int *val)
{
	int ret = 0, fd = 0, count = 0;
	char full_path[PATH_MAX] = {0}, read_buf[8] = {0};

	if (!syspath || !attr) {
		SLOGE("\n Null path or att passed");
		return ret = -EINVAL;
	}

	snprintf(full_path, sizeof(full_path), "%s/%s", syspath, attr);
	fd = open(full_path, O_RDONLY);
	if (fd < 0) {
		SLOGE("\n Failed to open the file at %s", full_path);
		return ret = -EPERM;
	}
	count = read(fd, &read_buf, 8);
	*val = atoi(&read_buf);
	close(fd);

	return ret;
}

/*
 * write_sysfs_attr: Function to write an attribute from the given syspath
 *  @syspath: path in the sysfs of the attr which has to be read.
 *  @attr: Name of the attribute within the syspath to be written.
 *  @val: Vlaue of the attribute in integer format which has to
 *          to be written from the caller.
 *  @Returns: 0 for success, negetive error code on failure.
 */
static int write_sysfs_attr(const char *syspath, const char *attr, int val)
{
	int ret = 0, fd = 0, count = 0;
	char full_path[PATH_MAX] = {0}, write_buf[8] = {0};

	if (!syspath || !attr) {
		SLOGE("\n Null path or att passed");
		return ret = -EINVAL;
	}

	snprintf(full_path, sizeof(full_path), "%s/%s", syspath, attr);
	fd = open(full_path, O_WRONLY);
	if (fd < 0) {
		SLOGE("\n Failed to open the file at %s", full_path);
		return ret = -EPERM;
	}
	snprintf(&write_buf, 8, "%d", val);
	count = write(fd, &write_buf, 8);
	close(fd);

	return ret;
}

/*
 * read_bootup_data: Function to read bootup prams from FG Driver.
 *  @v_bootup: pointer to store the bootup VOCV from the FG drvier
 *	sysfs interface.
 *  @i_bootup: pointer to store the bootup IBAT from the FG drvier's
 *	sysfs interface
 *  @Returns: 0 for success, negetive error code on failure.
 */
static int read_bootup_data(int *v_bootup, int *i_bootup)
{
	int ret = 0, fd = 0;
	char *attr_v_boot = NULL, *att_i_boot = NULL;

	ret = read_sysfs_attr(FG_SYSPATH, fg_att[VOLT_BOOT].name, v_bootup);
	if (ret < 0) {
		SLOGE("\nError in reading attr %s, ret = %d",
				fg_att[VOLT_BOOT].name, ret);
		return ret;
	}

	ret = read_sysfs_attr(FG_SYSPATH, fg_att[IBAT_BOOT].name, i_bootup);
	if (ret < 0) {
		SLOGE("\nError in reading attr %s, ret = %d",
				fg_att[IBAT_BOOT].name, ret);
		return ret;
	}

	return ret;
}

/*
 * populate_fg_input_params: Function to populate FG params from FG Driver.
 *	No input arguments.
 *	This function reads all the sttribute of Fule Gauge interface driver
 *	and populates them into a table which can be passed to the libfg algo
 *  @Returns: 0 for success, negetive error code on failure.
 */
static int populate_fg_input_params(void)
{
	int ret = 0, i = 0;

	for (i = VOLT_NOW; i <= DELTA_Q; i++) {
		ret = read_sysfs_attr(FG_SYSPATH, fg_att[i].name, &fg_att[i].val);
		SLOGD("\n\t %s = %d", fg_att[i].name, fg_att[i].val);
	}

	return ret;
}

/*
 * write_fg_output_params: Function to write libfg output to FG Driver.
 *	No input arguments.
 *  This function writes libfg algorithm output like SoC etc to the
 *	to the Fule Gauge interface driver.
 *  @Returns: 0 for success, negetive error code on failure.
 */
static int write_fg_output_params(void)
{
	int ret = 0, i = 0;

	/*Copy the Algo Output and write it to the sysfs entries*/
	fg_att[CAPACITY].val = ti_fg_cell_cfg.soc;
	fg_att[NAC].val = ti_fg_cell_cfg.nac;
	fg_att[FCC].val = ti_fg_cell_cfg.fcc;
	fg_att[CYC_CNT].val = ti_fg_cell_cfg.cycle_count;
	fg_att[CC_CALIB].val = ti_fg_cell_cfg.calibrate;

	for (i = CAPACITY; i <= CC_CALIB; i++) {
		ret = write_sysfs_attr(FG_SYSPATH, fg_att[i].name, fg_att[i].val);
		if (ret < 0)
			SLOGE("\nError in writing att %s", fg_att[i].name);
	}

	return ret;
}

/*
 * main: Entry point of the executable.
 * fg_algo_iface user space execution starts here.
 * Since this needs to run for the entire duration,
 * It will not return.
 */
int main(int argc, char *argv[])
{
	int ret = 0, i = 0;

	int fd = 0, cnt = 0;
	char read_buf = {0};
	struct pollfd fg_poll;

	/*Initialize Klog*/
	klog_init();
	klog_set_level(FG_ALGO_KLOG_LEVEL);

	/*Get a file descriptor for the monitoring FG sysfs entry.
	If the file descriptor is not present then the kernel does
	not support software fuel gauge. Exit the program*/
	fd = open(FG_UEVENT_PATH, O_RDWR);
	if (fd < 0) {
		SLOGE("\nFailed to get File Descriptor");
		exit(1);
	}

	/*Dummy Read call to clear pending events*/
	cnt = read(fd, &read_buf, 4);

	/*Get the Boot up Parameters to start fg_init*/
	ret = read_bootup_data(&fg_att[VOLT_BOOT].val,
							&fg_att[IBAT_BOOT].val);
	/*The Algo is not utilizing IBAT to adjust VOCV.
	Hence adjusting VOCV before sending it to FG Init*/
	fg_att[VOLT_BOOT].val -= ((fg_att[IBAT_BOOT].val * VADJUST)/1000);
	if (ret >= 0) {
		fg_init(&ti_fg_cell_cfg, (fg_att[VOLT_BOOT].val/1000),
					0);
		KLOGE("\n\t fg_init, vboot = %d, iboot = %d, soc = %d",
		fg_att[VOLT_BOOT].val, fg_att[IBAT_BOOT].val, ti_fg_cell_cfg.soc);
	}
	/*
	** Wait for the event from the FG kernel driver.
		Poll for the intel_fg_uiface driver to send
		sysfs_notify to user space, after receiving
		the notification, pass the parameters to
		libfg. poll is blocking
	*/
	while (1) {
		int timeout_ms = 60000, ret = 0;

		/*Dummy read to clear pending events*/
		cnt = read(fd, &read_buf, 8);

		fg_poll.fd = fd;
		fg_poll.events = POLLPRI;
		fg_poll.revents = 0;

		/*Invoke poll. This will block till FG Iface driver sends
			sysfs_notify*/
		ret = poll(&fg_poll, 1, timeout_ms);
		if (ret < 0) {
			SLOGE("\nFailed to poll %d", ret);
			KLOGE("\nFailed to poll %d", ret);
		} else if (ret == 0) {
			SLOGE("\nTimeout occured during poll");
			KLOGE("\nTimeout occured during poll");
		} else if ((fg_poll.revents & POLLPRI)) {

			/*If Poll Event, get all FG values and Invoke functions to process
			fg*/
			populate_fg_input_params();

			/*Invoke PMIC Vendor provided libfg process API*/
			fg_process(&ti_fg_cell_cfg, fg_att[DELTA_Q].val,
						(fg_att[VOLT_NOW].val/1000),
						(fg_att[CUR_AVG].val/1000),
						(fg_att[BATT_TEMP].val/1000));

			SLOGD("\n\t Capacity = %d, nac = %d, fcc = %d\n",
				fg_att[CAPACITY].val, fg_att[NAC].val, fg_att[FCC].val);

			KLOGE("\n\t Capacity = %d, nac = %d, fcc = %d\n",
				fg_att[CAPACITY].val, fg_att[NAC].val, fg_att[FCC].val);

			/*Copy the Algo Output and write it to the sysfs entries*/
			write_fg_output_params();

		} else {
			SLOGE("\n Unknow revent for poll");
			KLOGE("\n Unknow revent for poll");
			sleep(2);
		}
	} /*end of while*/

	/*Should not come here*/
	if (fd)
		close(fd);
	SLOGE("\n Fule Gauge User Space Interface Exiting\n");
	exit(1);
}
