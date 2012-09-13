#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>
#include <dirent.h>
#include <cutils/log.h>

typedef enum {FALSE = 0, TRUE} bool;

#define PRIMARY_FILE "/system/etc/fg_config.bin"
#define SECONDARY_FILE "/data/system/battid.dat"
#define DEV_FILE "/dev/fg"
#define BATTID_LEN 8
#define POWER_SUPPLY_PATH "/sys/class/power_supply/"

#define TRUE 1
#define FALSE 0

struct __attribute__((__packed__))primary_header {
		unsigned short  rev;
		unsigned short file_size;
		unsigned short cksum;
		unsigned short res;
};

#define MAX_TABLE_NAME_SIZE 8
#define MAX_BATTID_SIZE 8
#define MAX_FG_CONFIG_SIZE 138
#define MODEL_NAME_SIZE 4


struct __attribute__((__packed__)) table_body {
	unsigned char table_type;
	unsigned short size;
	unsigned short rev;
	char table_name[MAX_TABLE_NAME_SIZE];
	char battid[MAX_BATTID_SIZE];
	unsigned char res;
	unsigned char fg_config[MAX_FG_CONFIG_SIZE];
	unsigned short cksum;
};

struct __attribute__((__packed__)) sec_file_body {
	struct table_body tbl;
	unsigned short pcksum;
};
#define MAX_FG_TABLES	15
#define MAX_PRIM_FILE_SIZE (sizeof(struct primary_header) +\
	MAX_FG_TABLES * sizeof(struct table_body))


#define LOG_TAG "EM FG User Space:"

int read_primary_header(struct primary_header *pheader)
{
	int ret;
	int fd = open(PRIMARY_FILE, O_RDONLY);
	if (fd < 0)
		return errno;
	ret = read(fd, pheader, sizeof(*pheader));
	if (ret !=  sizeof(*pheader)) {
		close(fd);
		return ENODATA;
	}
	close(fd);

	if (pheader->file_size > MAX_PRIM_FILE_SIZE)
		return EINVAL;
	return 0;
}


int read_primary_file(unsigned char *buf, int size)
{
	int fd;
	int ret;
	fd = open(PRIMARY_FILE, O_RDONLY);
	if (fd < 0)
		return errno;

	ret = read(fd, buf, size);
	if (ret != size) {
		LOGI("requested bytes:%d read bytes:%d\n", size, ret);
		close(fd);
		return ENODATA;
	}
	close(fd);
	return 0;
}

int read_secondary_file(struct sec_file_body *sbuf)
{
	int fd;
	int ret;
	fd = open(SECONDARY_FILE, O_RDONLY);
	if (fd < 0)
		return errno;
	ret = read(fd, sbuf, sizeof(*sbuf));
	if (ret !=  sizeof(*sbuf)) {
		close(fd);
		return ENODATA;
	}
	close(fd);
	return 0;
}

unsigned short checksum(void *buf, int len)
{
	short int chksum = 0;
	unsigned char *data = (unsigned char *)buf;
	while (len--)
		chksum += *data++;
	return chksum;
}

int get_battery_ps_name(char *ps_battery_path)
{
	struct dirent *dir_entry;
	char path[PATH_MAX];
	char buf[20];
	int length;
	int fd;

	DIR *dir = opendir(POWER_SUPPLY_PATH);
	if (dir == NULL)
		return errno;

	while ((dir_entry = readdir(dir))) {
		const char *ps_name = dir_entry->d_name;

		if (ps_name[0] == '.' && (ps_name[1] == 0 || (ps_name[1] == '.' && ps_name[2] == 0)))
			continue;
		snprintf(path, sizeof(path), "%s/%s/type", POWER_SUPPLY_PATH, ps_name);
		fd = open(path, O_RDONLY);

		if (fd < 0)
			return errno;

		length = read(fd, buf, sizeof(buf));
		close(fd);
		if (length > 0) {
			if (buf[length - 1] == '\n')
				buf[length - 1] = 0;
			if (strcmp(buf, "Battery") == 0) {
				snprintf(ps_battery_path, PATH_MAX, "%s", ps_name);
				closedir(dir);
				return 0;
				}

			LOGI("Power Supply type=%.8s name=%s\n", buf, ps_name);
		}
	}
	closedir(dir);
	return ENOENT;
}

int get_battid(char *battid)
{
	int ret;
	int fd;
	char ps_batt_name[PATH_MAX];
	char battid_path[PATH_MAX];
	ret =  get_battery_ps_name(ps_batt_name);
	if (ret) {
		LOGE("Error(%d) in get_battery_ps_name:%s\n", ret, strerror(ret));
		return ret;
	}

	snprintf(battid_path, sizeof(battid_path), "%s/%s/model_name", POWER_SUPPLY_PATH, ps_batt_name);

	LOGI("Reading battid from %s\n", battid_path);

	fd = open(battid_path, O_RDONLY);

	if (fd < 0)
		return errno;

	ret = read(fd, battid, BATTID_LEN);
	if (ret < 0) {
		close(fd);
		return errno;
	}

	return 0;
}

bool is_prim_cksum_ok(unsigned char *buf, int size)
{

	struct primary_header *pheader = (struct primary_header *)buf;
	unsigned short pcksum = pheader->cksum;
	pheader->cksum = 0x00;

	if (checksum(buf, size) != pcksum) {
		LOGE("Primary checksum failed:%x:%x\n",
				checksum(buf, size), pcksum);
		pheader->cksum = pcksum;
		return FALSE;
	}

	pheader->cksum = pcksum;
	return TRUE;
}

bool is_sec_cksum_ok(struct sec_file_body *sbuf, int len)
{
	if (checksum(sbuf, len - 4) != sbuf->tbl.cksum) {
		LOGE("Secondary checksum failed:%x:%x\n", checksum(sbuf, len - 4), sbuf->tbl.cksum);
		return FALSE;
	} else
		return TRUE;
}


int write_to_dev(struct table_body *fg_tbl)
{
	int ret;
	int fd = open(DEV_FILE, O_WRONLY, S_IRWXU|S_IRWXG|S_IRWXO);
	if (fd < 0)
		return errno;

	/* write fg config table to device file */
	ret = write(fd, fg_tbl, sizeof(*fg_tbl) - sizeof(fg_tbl->cksum));
	if (ret != (sizeof(*fg_tbl) - sizeof(fg_tbl->cksum))) {
		close(fd);
		if (ret < 0)
			return errno;
		else
			return EIO;
	}

	close(fd);
	return 0;
}

int get_primary_fg_config(unsigned char *pbuf,
		struct table_body *tbl, char *battid)
{
	int size;
	struct primary_header *pheader;
	struct table_body *temp_tbl;
	unsigned char *ptr;
	int i = 1;
	char ps_batt_name[PATH_MAX];
	int ret;

	ret = get_battery_ps_name(ps_batt_name);
	if (ret) {
		LOGE("Error(%d) in get_battery_ps_name:%s\n", ret, strerror(ret));
		return ret;
	}

	pheader = (struct primary_header *)pbuf;
	size = sizeof(struct primary_header);
	ptr  = (unsigned char *)pbuf;
	ptr += size;

	LOGI("pheader->file_size =%d\n", pheader->file_size);

	while (size < pheader->file_size) {

		temp_tbl = (struct table_body *)ptr;
		LOGI("Table[%d].name:%.8s FG.name=%s\n", i, temp_tbl->table_name, ps_batt_name);
		LOGI("Table[%d].Battid:%.8s FG.Battid:%.8s\n",
				i, temp_tbl->battid, battid);
		/* FIXME: Read Table name from power_supply sysfs */
		if (!strncmp(temp_tbl->table_name, ps_batt_name,
					MAX_TABLE_NAME_SIZE)) {
			if (!strncmp(temp_tbl->battid, battid,
						MODEL_NAME_SIZE)) {
				LOGI("Matching table_name and battid:%.8s:%.8s\n", temp_tbl->table_name, temp_tbl->battid);
				memcpy(tbl, temp_tbl, sizeof(*tbl));
				return 0;
			}

		}
		size += sizeof(*temp_tbl);
		ptr += sizeof(*temp_tbl);
		i++;
	}
	return EINVAL;
}

int get_fg_config_table(struct table_body *sec_tbl)
{
	char battid[MAX_BATTID_SIZE];
	unsigned char *pbuf;
	int is_pcksum_ok = 0;
	int is_scksum_ok = 0;
	struct primary_header pheader;
	struct sec_file_body sbuf;
	int ret;

	/* get battid */
	ret = get_battid(battid);
	if (ret) {
		LOGE("Error(%d) in get_battid:%s\n", ret, strerror(ret));
		return ret;
	}

	/* read primary header */
	ret = read_primary_header(&pheader);
	if (ret) {
		LOGE("Error(%d) in read_primary_header:%s\n", ret, strerror(ret));
		return ret;
	}
	pbuf = malloc(pheader.file_size);

	/*read primary file including header */
	ret = read_primary_file(pbuf, pheader.file_size);
	if (ret) {
		LOGE("Error(%d) in read_primary:%s\n", ret, strerror(ret));
		return ret;
	}

	LOGI("pheader.size=%d\n", pheader.file_size);

	is_pcksum_ok = is_prim_cksum_ok(pbuf, pheader.file_size);

	/* read secondary */
	ret = read_secondary_file(&sbuf);
	if (ret) {
		LOGE("Error(%d) in read_secondary_file:%s\n", ret, strerror(ret));
		goto read_pri_config;
	} else
		is_scksum_ok = is_sec_cksum_ok(&sbuf, sizeof(sbuf));

	/* If primary checksum mismatch return error */
	if (!(is_pcksum_ok) && !(is_scksum_ok)) {
		LOGE("primary and secondary checksum failed.\n");
		return EINVAL;
	}

	/* Read primary config if secondary battid doesn't match or
	secondary checksum is not ok or primary file has a new config */
	if (!is_scksum_ok)
		LOGE("Secondary checksum failed\n");
	else if (strncmp(sbuf.tbl.battid, battid, MODEL_NAME_SIZE))
		LOGE("Secondary Battid doesn't match %s:%s\n", sbuf.tbl.battid, battid);
	else if (pheader.cksum != sbuf.pcksum)
		LOGE("Secondary.primary_checksum mismatch. New primary file detected\n");
	else {
		LOGI("Using FG data from %s\n", SECONDARY_FILE);
		memcpy(sec_tbl, &sbuf.tbl, sizeof(*sec_tbl));
		free(pbuf);
		return 0;
	}

read_pri_config:
	if (!is_pcksum_ok)
		return -EINVAL;

	LOGI("Using FG data from %s\n", PRIMARY_FILE);
	ret = get_primary_fg_config(pbuf, &sbuf.tbl, battid);
	if (ret) {
		LOGE("Error(%d) in get_primary_fg_config:%s\n", ret, strerror(ret));
		return ret;
	}
	/* copy the secondary table */
	memcpy(sec_tbl, &sbuf.tbl, sizeof(*sec_tbl));
	free(pbuf);
	return 0;
}

int write_sec_config(struct sec_file_body *sbuf)
{
	int fds, ret;
	struct primary_header pheader;
	/* open secondary file in write mode */
	fds = open(SECONDARY_FILE, O_WRONLY|O_CREAT, S_IRWXU|S_IRWXG|S_IRWXO);
	if (fds < 0) {
		LOGE("Error(%d) in opening %s:%s\n", errno, SECONDARY_FILE, strerror(errno));
		return errno;
	}

	/* Read primary header to get primary checksum. This is to detect
	changes in the primary config, so that when configure FG, config data
	can be read from primary, instead of reading from secondary.*/
	ret = read_primary_header(&pheader);
	if (ret) {
		LOGE("Error(%d) in read_primary_header:%s\n", ret, strerror(ret));
		close(fds);
		return ENODATA;
	}

	/* set primary checksum in secondary. This field will be used to check
	if the primary is modified or not */
	sbuf->pcksum = pheader.cksum;

	/*set secondary checksum */
	sbuf->tbl.cksum = checksum(&sbuf->tbl,
				sizeof(sbuf->tbl) - sizeof(sbuf->tbl.cksum));

	/* write secondary file */
	ret = write(fds, sbuf, sizeof(*sbuf));
	if (ret != sizeof(*sbuf)) {
		LOGE("Error in writing secondary file\n");
		close(fds);
		return ENODATA;
	}
	close(fds);
	LOGI("Wrote %d bytes to %s Size of table=%ld\n", ret, SECONDARY_FILE, sizeof(sbuf->tbl));
	return 0;
}

int write_fgdev_config(void)
{
	struct sec_file_body sbuf;
	int ret;

	/* get FG config from secondary/primary */
	ret = get_fg_config_table(&sbuf.tbl);
	if (ret)
		return ret;

	/* write to device file */
	return write_to_dev(&sbuf.tbl);
}

int  read_fg_write_sec()
{
	int fds, fdd, ret;
	unsigned char fg_config[MAX_FG_CONFIG_SIZE];
	struct sec_file_body sbuf;

	/*open device file */
	fdd = open(DEV_FILE, O_RDONLY);
	if (fdd < 0) {
		LOGE("Error(%d) in opening %s:%s\n", errno, DEV_FILE, strerror(errno));
		return errno;
	}

	/*read from device file except checksum*/
	ret = read(fdd, &sbuf.tbl, (sizeof(sbuf.tbl) - sizeof(sbuf.tbl.cksum)));
	if (ret != (sizeof(sbuf.tbl) - sizeof(sbuf.tbl.cksum))) {
		close(fdd);
		close(fds);

		LOGE("Error(%d) in reading %s:%s requested=%d read=%d\n", errno, DEV_FILE, strerror(errno),
				(int)(sizeof(sbuf.tbl) - sizeof(sbuf.tbl.cksum)), ret);
		if (ret < 0)
			return errno;
		else
			return ENODATA;
	}

	ret = write_sec_config(&sbuf);
	if (ret) {
		LOGE("Error(%d) in saving secondary:%s\n", ret, strerror(ret));
		return ret;
	}

	close(fdd);

	return 0;
}

char *cfg_name[] = {
	"rcomp0",
	"tempCo",
	"kempty0",
	"full_cap",
	"cycles",
	"full_capnom",
	"soc_empty",
	"ichgt_term",
	"design_cap",
	"etc",
	"rsense",
	"cfg",
	"learn_cfg",
	"filter_cfg",
	"relax_cfg",
	"qrtbl00",
	"qrtbl10",
	"qrtbl20",
	"qrtbl30",
	"full_soc_thr",
	"vempty",
	NULL
};

int dump_config(struct table_body *config)
{
	unsigned short  *data_ptr =  (unsigned short *) config->fg_config;
	int i = 0;


	LOGI("table_type:0x%x\n", (unsigned int)config->table_type);
	LOGI("size:0x%x\n", config->size);
	LOGI("revision:0x%x\n", (int)config->rev);
	LOGI("table_name:%.8s\n", config->table_name);
	LOGI("battid:%.8s\n", config->battid);
	LOGI("reserved:0x%x\n", (unsigned int)config->res);

	while (cfg_name[i] != NULL)
		LOGI("%s:0x%x\n", cfg_name[i++], *data_ptr++);

	data_ptr--;

	for (i = (i - 1); i < MAX_FG_CONFIG_SIZE / sizeof(unsigned short); ++i)
		LOGI("cell_char_tbl[%d]:0x%x\n", i, *data_ptr++);

	LOGI("checksum:0x%x\n", config->cksum);
	return 0;
}
void dump_primary_header(struct primary_header pheader)
{
	LOGI("Primary Header\n===================\n");
	LOGI("revision=0x%x\n", (unsigned short) pheader.rev);
	LOGI("file_size=0x%x\n", (unsigned short) pheader.file_size);
	LOGI("checksum=0x%x\n", (unsigned short) pheader.cksum);
	LOGI("reserved=0x%x\n", (unsigned short) pheader.res);

}

int dump_fg_config(char sel)
{
	int ret;
	struct sec_file_body sbuf;
	char battid[MAX_BATTID_SIZE];
	struct primary_header pheader;
	unsigned char *pbuf;
	unsigned long offset = 0;
	int i = 1;

	/* get FG config from secondary/primary */
	if (sel == 'p') {
		/* read primary header */
		ret = read_primary_header(&pheader);
		if (ret) {
			LOGE("Error(%d) in read_primary_header:%s\n", ret, strerror(ret));
			return ret;
		}

		dump_primary_header(pheader);
		pbuf = malloc(pheader.file_size);

		/*read primary file including header */
		ret = read_primary_file(pbuf, pheader.file_size);
		if (ret) {
			LOGE("Error(%d) in read_primary:%s\n", ret, strerror(ret));
			return ret;
		}

		offset += sizeof(pheader);
		while (offset < pheader.file_size) {
			LOGI("Table:%d\n=========================\n", i++);
			ret = dump_config((struct table_body *)(pbuf + offset));
			if (ret) {
				LOGE("Error(%d) in dump_config:%s\n", ret, strerror(ret));
				return ret;
			}
			offset += sizeof(struct table_body);

		}
		free(pbuf);
		return ret;
	}
	else if (sel == 's')
		ret = read_secondary_file(&sbuf);
	else if (sel == '\0')
		ret = get_fg_config_table(&sbuf.tbl);
	else {
		LOGE("Invalid argument with -d\n");
		return EINVAL;
	}

	if (ret) {
		LOGE("Error(%d) in reading config:%s\n", ret, strerror(ret));
		return ret;
	}
	return dump_config(&sbuf.tbl);
}

void print_help(void)
{
	LOGI("\nfg_conf [-w/-r/-d/-ds/-dp]\n");
	LOGI("-w - Read config and write to fg interface\n");
	LOGI("-r - Read config from fg and save in secondary\n");
	LOGI("-d - Dump the matching table from secondary/primary\n");
	LOGI("-ds - Dump secondaty file\n");
	LOGI("-dp -  Dump primary file\n");

}

int main(int argc, char *argv[])
{
	int ret = 0;
	if (argc != 2) {
		LOGE("Invalid argument list\n");
		return -EINVAL;
	}

	if ((argc == 2) && (argv[1][0] == '-'))	{
		switch (argv[1][1]) {

		case 'w':
			LOGI("Invoked with -w\n");
			ret = write_fgdev_config();
			if (ret) {
				LOGE("Error(%d) in write_fgdev_config\n", ret);
				return ret;
			}
			LOGI("Restored FG data successfully\n");

			break;
		case 'r':
			LOGI("Invoked with -r\n");
			ret = read_fg_write_sec();
			if (ret) {
				LOGE("Error(%d) in read_fg_write_sec\n", ret);
				return ret;
			}
			LOGI("Saved FG data successfully in %s\n", SECONDARY_FILE);
			break;
		case 'd':
			LOGI("Invoked with -d\n");
			ret =  dump_fg_config(argv[1][2]);
			if (ret) {
				LOGE("Error(%d) in dumping FG Config:%s\n", ret, strerror(ret));
				return ret;
			}
			break;
		case 'h':
			LOGI("Invoked with -h\n");
			print_help();
			break;
		default:
			LOGE("Invoked with invalid argument\n");
			return EINVAL;
		}
	} else  {
		LOGE("Invoked with invalid argument\n");
		return EINVAL;

	}
	return ret;
}
