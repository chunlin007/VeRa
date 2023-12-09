/*
 * Atmel SAM Cortex-M devices emulation.
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

#include "hw/arm/sam.h"
#include "hw/arm/cortexm-mcu.h"

/* ----- SAM3S4B ----- */
static CortexMCoreCapabilities sam3s4b_core_info = {
    //.flash_size_kb = 256,
    //.sram_size_kb = 48,
    .has_mpu = true };

qemu_irq *sam3s4b_mcu_init(MachineState *machine)
{
    return cortex_m3_core_init(&sam3s4b_core_info, machine);
}

