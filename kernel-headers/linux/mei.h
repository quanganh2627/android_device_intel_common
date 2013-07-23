/**********************************************************************
 * Copyright (C) 2011 Intel Corporation. All rights reserved.

 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at

 * http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **********************************************************************/

#ifndef _LINUX_MEI_H
#define _LINUX_MEI_H

#include <linux/uuid.h>

/*
 * This IOCTL is used to associate the current file descriptor with a
 * FW Client (given by UUID). This opens a communication channel
 * between a host client and a FW client. From this point every read and write
 * will communicate with the associated FW client.
 * Only in close() (file_operation release()) the communication between
 * the clients is disconnected
 *
 * The IOCTL argument is a struct with a union that contains
 * the input parameter and the output parameter for this IOCTL.
 *
 * The input parameter is UUID of the FW Client.
 * The output parameter is the properties of the FW client
 * (FW protocol version and max message size).
 *
 */
#define IOCTL_MEI_CONNECT_CLIENT \
	_IOWR('H' , 0x01, struct mei_connect_client_data)

/*
 * Intel MEI client information struct
 */
struct mei_client {
	__u32 max_msg_length;
	__u8 protocol_version;
	__u8 reserved[3];
};

/*
 * IOCTL Connect Client Data structure
 */
struct mei_connect_client_data {
	union {
		uuid_le in_client_uuid;
		struct mei_client out_client_properties;
	};
};

#endif /* _LINUX_MEI_H  */
