/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2000-2001  Qualcomm Incorporated
 *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
 *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#ifndef __HCI_VS_H
#define __HCI_VS_H

#ifdef __cplusplus
extern "C" {
#endif

#include "hci_vs_lib.h"

#define OGF_VS	0x3F

#define OCF_VS_WRITE_CODEC_CONFIG	0x0106
#define OCF_VS_BTIP1_1_SET_FM_AUDIO_PATH	0x0195

typedef struct {
	pcm_clock_t pcm_clock;
	frame_sync_t frame_sync;
	/* reserved */
	uint8_t reserved_1;
	channel_data_t channel_1_data_out;
	channel_data_t channel_1_data_in;
	/* reserved */
	uint8_t reserved_2;
	channel_data_t channel_2_data_out;
	channel_data_t channel_2_data_in;
	/* reserved */
	uint8_t reserved_3;
} __attribute__ ((packed)) vs_write_codec_config_cp;
#define VS_WRITE_CODEC_CONFIG_SIZE 34

typedef struct {
	uint32_t pcmi_override;
	uint32_t i2s_override;
	uint8_t bluetooth_audio_path;
	uint8_t fm_audio_path;
	uint8_t tdm_enable;
}__attribute__ ((packed)) vs_btip1_1_set_fm_audio_path_cp;
#define VS_BTIP1_1_SET_FM_AUDIO_PATH_SIZE 11

#ifdef __cplusplus
}
#endif

#endif /* __HCI_VS_H */
