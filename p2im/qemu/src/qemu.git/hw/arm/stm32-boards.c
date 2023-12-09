/*
 * STM32 boards emulation.
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

#include "hw/arm/stm32-mcus.h"
#include "hw/display/gpio-led.h"
#include "hw/arm/cortexm-helper.h"
#include "sysemu/sysemu.h"

/*
 * This file defines several STM32 boards.
 * Where available, the board names follow the CMSIS Packs names.
 */

/* ----- ST STM32F4-Discovery ----- */

static GPIOLEDInfo stm32f4_discovery_leds_info[] = {
    {
        .name = "green-led",
        .active_low = false,
        .colour_message = "Green",
        .x = 258,
        .y = 218,
        .w = 8,
        .h = 10,
        .gpio_path = "/machine/mcu/stm32/gpio[d]",
        .port_bit = 12, },
    {
        .name = "orange-led",
        .active_low = false,
        .colour_message = "Orange",
        .x = 287,
        .y = 246,
        .w = 8,
        .h = 10,
        .gpio_path = "/machine/mcu/stm32/gpio[d]",
        .port_bit = 13, },
    {
        .name = "red-led",
        .active_low = false,
        .colour_message = "Red",
        .x = 258,
        .y = 274,
        .w = 8,
        .h = 10,
        .gpio_path = "/machine/mcu/stm32/gpio[d]",
        .port_bit = 14, },
    {
        .name = "blue-led",
        .active_low = false,
        .colour_message = "Blue",
        .x = 230,
        .y = 246,
        .w = 8,
        .h = 10,
        .gpio_path = "/machine/mcu/stm32/gpio[d]",
        .port_bit = 15, },
    { }, /**/
};

static void stm32f4_discovery_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_STM32F407VG);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 8000000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F4-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
    gpio_led_create_from_info(peripheral, stm32f4_discovery_leds_info,
            board_surface);
}

static QEMUMachine stm32f4_discovery_machine = {
    .name = "STM32F4-Discovery",
    .desc = "ST Discovery kit for STM32F407/417 lines",
    .init = stm32f4_discovery_board_init_callback };

static void stm32f4_discovery2_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_STM32F407VG);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 8000000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F4-Discovery.png",
            cm_board_get_desc(machine));
    Object *peripheral = cm_container_get_peripheral();
    gpio_led_create_from_info(peripheral, stm32f4_discovery_leds_info,
            board_surface);
}

static QEMUMachine stm32f4_discovery2_machine = {
    .name = "STM32F4-Discovery2",
    .desc = "ST Discovery kit for STM32F407/417 lines",
    .init = stm32f4_discovery2_board_init_callback };

/* ----- ST STM32F429I-Discovery ----- */

#if 0
static GPIOLEDInfo stm32f429i_discovery_leds_info[] = {
    {
        .name = "green-led",
        .active_low = false,
        .colour_message = "Green",
        .x = 519,
        .y = 109,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 13, },
    {
        .name = "red-led",
        .active_low = false,
        .colour_message = "Red",
        .x = 519,
        .y = 130,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 14, },
    { }, /**/
};
#endif

static void stm32f429i_discovery_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_STM32F429ZI);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 8000000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
    //gpio_led_create_from_info(peripheral, stm32f429i_discovery_leds_info,
    //        board_surface);
}

static QEMUMachine stm32f429i_discovery_machine = {
    .name = "STM32F429I-Discovery",
    .desc = "ST Discovery kit for STM32F429/439 lines",
    .init = stm32f429i_discovery_board_init_callback };

// Bo: copy and slightly modified from STM32F429I-Discovery
// defines board
/* ----- NXP LPC4330 ----- */

#if 0
static GPIOLEDInfo nxp_lpc4330_leds_info[] = {
    {
        .name = "green-led",
        .active_low = false,
        .colour_message = "Green",
        .x = 519,
        .y = 109,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 13, },
    {
        .name = "red-led",
        .active_low = false,
        .colour_message = "Red",
        .x = 519,
        .y = 130,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 14, },
    { }, /**/
};
#endif


static void nxp_lpc4330_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_NXPLPC4330);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 8000000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
    //gpio_led_create_from_info(peripheral, nxp_lpc4330_leds_info,
    //        board_surface);
}

static QEMUMachine nxp_lpc4330_machine = {
    .name = "NXP-LPC4330",
    .desc = "NXP-LPC4330 MCU, boards unknown",
    .init = nxp_lpc4330_board_init_callback };


// Bo: copy and slightly modified from STM32F429I-Discovery
// defines board
/* ----- Arduino Due ----- */

#if 0
static GPIOLEDInfo arduino_due_leds_info[] = {
    {
        .name = "green-led",
        .active_low = false,
        .colour_message = "Green",
        .x = 519,
        .y = 109,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 13, },
    {
        .name = "red-led",
        .active_low = false,
        .colour_message = "Red",
        .x = 519,
        .y = 130,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 14, },
    { }, /**/
};
#endif

static void arduino_due_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_SAM3X8E);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 8000000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
    //gpio_led_create_from_info(peripheral, arduino_due_leds_info,
    //        board_surface);
}

static QEMUMachine arduino_due_machine = {
    .name = "Arduino-Due",
    .desc = "Arduino Due board with SAM3X8E MCU",
    .init = arduino_due_board_init_callback };


// Bo: copy and slightly modified from STM32F429I-Discovery
// defines board
/* ----- FRDM-K64F ----- */

#if 0
static GPIOLEDInfo frdm_k64f_leds_info[] = {
    {
        .name = "green-led",
        .active_low = false,
        .colour_message = "Green",
        .x = 519,
        .y = 109,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 13, },
    {
        .name = "red-led",
        .active_low = false,
        .colour_message = "Red",
        .x = 519,
        .y = 130,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 14, },
    { }, /**/
};
#endif

static void frdm_k64f_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_MK64FN1M0VLL12);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 8000000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
    //gpio_led_create_from_info(peripheral, frdm_k64f_leds_info,
    //        board_surface);
}

static QEMUMachine frdm_k64f_machine = {
    .name = "FRDM-K64F",
    .desc = "FRDM-K64F board with MK64FN1M0VLL12 MCU",
    .init = frdm_k64f_board_init_callback };

#if 0
/* ----- ST STM32F3-Discovery ----- */
static void
stm32f3_discovery_board_init_callback(MachineState *machine);

static QEMUMachine stm32f3_discovery_machine = {
    .name = "STM32F3-Discovery",
    .desc = "ST Discovery kit for STM32F303 line (Experimental)",
    .init = stm32f3_discovery_board_init_callback};

static void stm32f3_discovery_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);
    //cortexm_mcu_alloc(machine, TYPE_STM32F303VC);

    /* TODO: Add board inits */
}

/* ----- ST STM32F0-Discovery ----- */
static void
stm32f0_discovery_board_init_callback(MachineState *machine);

static QEMUMachine stm32f0_discovery_machine = {
    .name = "STM32F0-Discovery",
    .desc = "ST Discovery kit for STM32F051 line (Experimental)",
    .init = stm32f0_discovery_board_init_callback};

static void stm32f0_discovery_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);
    //cortexm_mcu_alloc(machine, TYPE_STM32F051R8);

    /* TODO: Add board inits */
}

/* ----- ST STM32VL-Discovery ----- */
static void
stm32vl_discovery_init_callback(MachineState *machine);

static QEMUMachine stm32vl_discovery_machine = {
    .name = "STM32VL-Discovery",
    .desc = "ST Discovery kit for STM32F100 Value Line (Experimental)",
    .init = stm32vl_discovery_init_callback};

static void stm32vl_discovery_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);
    //cortexm_mcu_alloc(machine, TYPE_STM32F100RB);

    /* TODO: Add board inits */
}
#endif


static void Nordic_NRF52832_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_NRF52832);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 32000000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
    //gpio_led_create_from_info(peripheral, arduino_due_leds_info,
    //        board_surface);
}

static QEMUMachine Nordic_NRF52832_machine = {
    .name = "Nordic_NRF52832",
    .desc = "Nordic NRF52832 minimum development board",
    .init = Nordic_NRF52832_board_init_callback };



static void Generic_SAMD21_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_SAMD21);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 48000000, "hse-freq-hz"); /* 48.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
    //gpio_led_create_from_info(peripheral, arduino_due_leds_info,
    //        board_surface);
}

static QEMUMachine Generic_SAMD21_machine = {
    .name = "Generic_SAMD21",
    .desc = "Generic SAMD21 minimum development board",
    .init = Generic_SAMD21_board_init_callback };




static void NUCLEO_F303RE_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_STM32F303RE);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 800000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */
        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
    //gpio_led_create_from_info(peripheral, stm32f429i_discovery_leds_info,
    //        board_surface);
}

static QEMUMachine NUCLEO_F303RE_machine = {
    .name = "NUCLEO_F303RE",
    .desc = "NUCLEO64 F303RE ",
    .init = NUCLEO_F303RE_board_init_callback };



static void LISA_F105RC_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_STM32F105RC);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 800000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */
        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
    //gpio_led_create_from_info(peripheral, stm32f429i_discovery_leds_info,
    //        board_surface);
}

static QEMUMachine LISA_F105RC_machine = {
    .name = "LISA_F105RC",
    .desc = "Lisa/M v2.0",
    .init = LISA_F105RC_board_init_callback };



static void NUVOTON_nuc123_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_NUC123);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 8000000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
}

static QEMUMachine NUVOTON_nuc123_machine = {
    .name = "NUVOTON_nuc123",
    .desc = "Nuvoton generic NUC123 MCU",
    .init = NUVOTON_nuc123_board_init_callback };


static void  NXP_LPC1837_board_init_callback(MachineState *machine)
{
    cm_board_greeting(machine);

    {
        /* Create the MCU */
        Object *mcu = cm_object_new_mcu(machine, TYPE_LPC1837);

        /* Set the board specific oscillator frequencies. */
        cm_object_property_set_int(mcu, 8000000, "hse-freq-hz"); /* 8.0 MHz */
        cm_object_property_set_int(mcu, 32768, "lse-freq-hz"); /* 32 kHz */

        cm_object_realize(mcu);
    }

    void *board_surface = cm_board_init_image("STM32F429I-Discovery.jpg",
            cm_board_get_desc(machine));

    Object *peripheral = cm_container_get_peripheral();
}



static QEMUMachine NXP_LPC1837_machine = {
    .name = "NXP_LPC1837",
    .desc = "NXP LPC1837 MCU",
    .init =  NXP_LPC1837_board_init_callback };


// Bo: copy and slightly modified from STM32F429I-Discovery
// defines board
/* ----- FRDM-K64F ----- */

#if 0
static GPIOLEDInfo frdm_k64f_leds_info[] = {
    {
        .name = "green-led",
        .active_low = false,
        .colour_message = "Green",
        .x = 519,
        .y = 109,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 13, },
    {
        .name = "red-led",
        .active_low = false,
        .colour_message = "Red",
        .x = 519,
        .y = 130,
        .w = 10,
        .h = 8,
        .gpio_path = "/machine/mcu/stm32/gpio[g]",
        .port_bit = 14, },
    { }, /**/
};
#endif




/* ----- Boards inits ----- */
static void stm32_machines_init(void)
{
    qemu_register_machine(&stm32f4_discovery_machine);
    qemu_register_machine(&stm32f4_discovery2_machine);
    qemu_register_machine(&stm32f429i_discovery_machine);
    // Bo
    qemu_register_machine(&nxp_lpc4330_machine);
    qemu_register_machine(&arduino_due_machine);
    qemu_register_machine(&frdm_k64f_machine);
    // Alejandro
    qemu_register_machine(&Nordic_NRF52832_machine);
    qemu_register_machine(&Generic_SAMD21_machine);
    qemu_register_machine(&NUCLEO_F303RE_machine);
    qemu_register_machine(&LISA_F105RC_machine);
    qemu_register_machine(&NUVOTON_nuc123_machine);
    qemu_register_machine(&NXP_LPC1837_machine);


#if 0
    qemu_register_machine(&stm32f3_discovery_machine);
    qemu_register_machine(&stm32f0_discovery_machine);
    qemu_register_machine(&stm32vl_discovery_machine);
#endif
}

machine_init(stm32_machines_init);
