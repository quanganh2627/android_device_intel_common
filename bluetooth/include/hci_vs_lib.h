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

#ifndef __HCI_VS_LIB_H
#define __HCI_VS_LIB_H

#ifdef __cplusplus
extern "C" {
#endif

#define AUDIO_PATH_NONE	0
#define AUDIO_PATH_PCM	1
#define AUDIO_PATH_I2S	2
#define AUDIO_PATH_DO_NOT_CHANGE	0xFF

typedef struct {
	uint16_t rate;
	uint8_t  direction;
}__attribute__ ((packed)) pcm_clock_t;

typedef struct {
	uint32_t frequency;
	uint16_t duty_cycle;
	uint8_t  edge;
	uint8_t  polarity;
}__attribute__ ((packed)) frame_sync_t;

typedef struct {
	uint16_t size;
	uint16_t offset;
	uint8_t  edge;
} __attribute__ ((packed)) channel_data_t;


uint32_t hci_vs_write_codec_config(uint32_t dd,
		const pcm_clock_t *pcm_clock,
		const frame_sync_t *frame_sync,
		const channel_data_t *channel_1_data_out,
		const channel_data_t *channel_1_data_in,
		const channel_data_t *channel_2_data_out,
		const channel_data_t *channel_2_data_in,
		uint32_t to);

uint32_t hci_vs_btip1_1_set_fm_audio_path(uint32_t dd,
		uint32_t pcmi_override,
		uint32_t i2s_override,
		uint8_t bluetooth_audio_path,
		uint8_t fm_audio_path,
		uint8_t tdm_enable,
		uint32_t to);


#ifdef __cplusplus
}
#endif

#endif /* __HCI_VS_LIB_H */
