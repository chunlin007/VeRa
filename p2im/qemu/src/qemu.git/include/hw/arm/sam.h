/*
 * Atmel SAM devices emulation.
 *
 * Copyright (c) 2014 Liviu Ionescu.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, see <http://www.gnu.org/licenses/>.
 */

#ifndef HW_ARM_SAM_H
#define HW_ARM_SAM_H 1

#include "hw/boards.h"
#include "hw/arm/cortexm-mcu.h"

void sam_board_init(MachineState *machine, QEMUMachine *qm);

qemu_irq *sam3s4b_mcu_init(MachineState *machine);

#endif /* HW_ARM_SAM_H */
