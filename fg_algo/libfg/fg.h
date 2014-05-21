/*
 * linux/drivers/power/fg/fg.h
 *
 * TI Fuel Gauge driver for Linux
 *
 * Copyright (C) 2008-2009 Texas Instruments, Inc.
 * Author: Texas Instruments, Inc.
 *
 * This package is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

#ifndef __FG_H
#define __FG_H

#include "android_fg.h"

void fg_init(struct cell_state *cell, short voltage, short curr);
void fg_process(struct cell_state *cell, int delta_q, short voltage,
		short cur, short temperature);
void fg_learn_capacity(struct cell_state *cell, unsigned int capacity);

#define PERCENT_VAL(VAL, PERCENT) (VAL * PERCENT / MAX_PERCENTAGE)

#endif
