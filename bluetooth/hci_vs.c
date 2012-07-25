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

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include "hci_vs.h"

uint32_t hci_vs_write_codec_config(uint32_t dd,
		const pcm_clock_t *pcm_clock,
		const frame_sync_t *frame_sync,
		const channel_data_t *channel_1_data_out,
		const channel_data_t *channel_1_data_in,
		const channel_data_t *channel_2_data_out,
		const channel_data_t *channel_2_data_in,
		uint32_t to)
{
	vs_write_codec_config_cp cp;
	struct hci_request rq;

	memset(&cp, 0, sizeof(cp));
	memset(&rq, 0, sizeof(rq));
	if (pcm_clock)
		memcpy(&cp.pcm_clock, pcm_clock, sizeof(pcm_clock_t));
	else
		cp.pcm_clock.direction = 1;
	if (frame_sync)
		memcpy(&cp.frame_sync, frame_sync, sizeof(frame_sync_t));
	if (channel_1_data_out)
		memcpy(&cp.channel_1_data_out, channel_1_data_out, sizeof(channel_data_t));
	if (channel_1_data_in)
		memcpy(&cp.channel_1_data_in, channel_1_data_in, sizeof(channel_data_t));
	if (channel_2_data_out)
		memcpy(&cp.channel_2_data_out, channel_2_data_out, sizeof(channel_data_t));
	if (channel_2_data_in)
		memcpy(&cp.channel_2_data_in, channel_2_data_in, sizeof(channel_data_t));
	rq.ogf    = OGF_VS;
	rq.ocf    = OCF_VS_WRITE_CODEC_CONFIG;
	rq.cparam = &cp;
	rq.clen   = VS_WRITE_CODEC_CONFIG_SIZE;
	return hci_send_req(dd, &rq, to);
}

uint32_t hci_vs_btip1_1_set_fm_audio_path(uint32_t dd,
		uint32_t pcmi_override,
		uint32_t i2s_override,
		uint8_t bluetooth_audio_path,
		uint8_t fm_audio_path,
		uint8_t tdm_enable,
		uint32_t to)
{
	vs_btip1_1_set_fm_audio_path_cp cp;
	struct hci_request rq;

	memset(&cp, 0, sizeof(cp));
	memset(&rq, 0, sizeof(rq));
	cp.pcmi_override = pcmi_override;
	cp.i2s_override = i2s_override;
	cp.bluetooth_audio_path = bluetooth_audio_path;
	cp.fm_audio_path = fm_audio_path;
	cp.tdm_enable = tdm_enable;
	rq.ogf    = OGF_VS;
	rq.ocf    = OCF_VS_BTIP1_1_SET_FM_AUDIO_PATH;
	rq.cparam = &cp;
	rq.clen   = VS_BTIP1_1_SET_FM_AUDIO_PATH_SIZE;
	return hci_send_req(dd, &rq, to);
}
