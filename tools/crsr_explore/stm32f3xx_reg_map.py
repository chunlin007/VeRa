#! /usr/bin/env     python3

'''
    To generate status and ctrl value refering to reg status map
    Author: Chunlina Wang
    E-mail: chunlin_wang01@163.com
    Date: 2022-09-23
'''
import io, sys, struct, random, time
from struct import *
from random import *


# Map for Periperal-STM32F303xD/E
# Refer to rm0316 page51
# TIM2/TIM3/TIM4 register map 
map_stm32f303xd_timx = {

    0x00 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000060,             0x00000080,
            0x00000300,                         0x00000800
        ], #TIM_CR1
    0x04 : [ 
                                                0x00000008,
            0x00000070,                         0x00000080
        ], #TIM_CR2
    0x08 : [
            0x00000007,                         0x00000008,
            0x00000070,                         0x00000080,
                                                0x00000f00,
            0x00000300,             0x00004000, 0x00008000
        ], #TIMx_SMCR
    0x0c : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010,             0x00000040,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000, 0x00004000, 0x00008000
        ], #TIMx_DIER
    0x10 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020, 0x00000040, 0x00000080,
                        0x00000200, 0x00000400, 0x00000800,
            0x00001000
        ], #TIMx_SR
    0x14: [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010,             0x00000040
        ], #TIMx_EGR
    0x18: [
            0x00000003,             0x0000000c,
                                                0x000000f0,
            0x00000003,             0x0000000c,
                                                0x000000f0
        ], #TIMx_CCMR1-Input/Output, here we just consider outputs
    0x1c: [
            0x00000003,             0x0000000c,
                                                0x000000f0,
            0x00000003,             0x0000000c,
                                                0x000000f0
        ], #TIM_CCMR2-Input/Output, here we just consider outputs
    0x20 : [
            0x00000001, 0x00000002,             0x00000008,
            0x00000010, 0x00000020,             0x00000080,
            0x00000100, 0x00000200,             0x00000800,
            0x00001000, 0x00002000,             0x00008000
        ], #TIMx_CCER
    0x24 : [
            0x00000000, 0x00000002
        ], #TIMx_CNT-we just consider status&control relative
    0x28 : [
            0x00000000, 0x00000002
        ], #TIMx_PSC
    0x2c : [
            0x00000000, 0x00000020
        ], #TIMx_ARR 
    0x30 : [], #Reserved
    0x34 : [
            0x00000001, 0x00000010    
        ], #TIMx_CCR1
    0x38 : [
            0x00000001, 0x00000010    
        ], #TIMx_CCR2
    0x3c : [
            0x00000001, 0x00000010    
        ], #TIMx_CCR3
    0x40 : [
            0x00000001, 0x00000010    
        ], #TIMx_CCR4
    0x44 : [], #Reserved
    0x48 : [
            0x0000001f, 0x00001f00
        ], #TIMx_DCR
    0x4c : [
            0X00000000, 0X00000010,
        ] #TIMx_DMAR can ignore
}

# TIM6/TIM7 register map 
map_stm32f303xd_timy = {

    0x00 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
                                                0x00000080,
                                                0x00000800
        ], #TIMy_CR1
    0x04 : [
            0x00000070
        ], #TIMCR2
    0x08 : [], #Reserved
    0x0c : [
            0x00000001,
            0x00000100
        ], #TIMy_DIER
    0x10 : [
            0x00000001
        ], #TIMy_SR
    0x14 : [
            0x00000001
        ], #TIMy_EGR
    0x18 : [], #Reserved
    0x1c : [], #Reserved
    0x20 : [], #Reserved
    0x24 : [
            0x0000ffff
        ], #TIMy_CNT
    0x28 : [
            0x0000ffff
        ], #TIMy_PSC
    0x28 : [
            0x0000ffff
        ] #TIMy_ARR

}

# RTC register map 
map_stm32f303xd_rtc = {
    
    0x00 : [
            0x0000000f, 
            0x00000070,
            0x00000f00,
            0x00007000,
            0x000f0000,
            0x003000000, 0x00400000
        ], #RTC_TR
    0x04 : [
            0x0000000f,
            0x00000030,
            0x00000f00,
            0x00001000, 0x0000e000,
            0x000f0000,
            0x00f00000
        ], #RTC_DR 
    0x08 : [
            0x00000007,                         0x00000008,
            0x00000010, 0x00000020, 0x00000040,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000, 0x00004000, 0x00008000,
            0x00010000, 0x00020000, 0x00040000, 0x00080000,
            0x00100000, 0x00600000,             0x00800000,
        ], #RTC_CR
    0x0c : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020, 0x00000040, 0x00000080,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000, 0x00004000, 0x00008000,
            0x00010000
        ], #RTC_ISR
    0x10 : [
            0x000000ff, 0x007f0000
        ], #RTC_PRER
    0x1c : [
            0x0000000f,
            0x00000070, 0x000000f0,
            0x00000f00, 
            0x00007000, 0x00008000,
            0x000f0000, 
            0x00300000, 0x00400000,              0x00800000,
            0x0f000000, 
            0x30000000, 0x40000000,              0x80000000
        ], #RTC_ALRMAR
    0x20 : [
            0x0000000f,
            0x00000070, 0x000000f0,
            0x00000f00, 
            0x00007000, 0x00008000,
            0x000f0000, 
            0x00300000, 0x00400000,              0x00800000,
            0x0f000000, 
            0x30000000, 0x40000000,              0x80000000
        ], #RTC_ALRMBR
    0x24 : [
            0x00000000, 0x00000001
        ], #RTC_WPR
    0x28 : [
            0x00000000, 0x0000ffff
        ], #RTC_SSR
    0x2c : [
            0x00003fff, 0x00000fff
       ], #RTC_SHIFTR
    0x30 : [
            0x0000000f, 
            0x00000070,                             0x000000f0,
            0x00000f00,                         
            0x00007000,
            0x000f0000,
            0x00300000, 0x00400000,
        ], #RTC_TSTR
    0x34 : [
            0x0000000f, 
            0x00000030,
            0x00000f00,
            0x00001000, 0x0000e000
         ], #RTC_TSDR
    0x38 : [
            0x00000000, 0x0000ffff
        ], #RTC_TSSSR
    0x3c : [
            0x000001ff,
            0x00040000, 0x00080000,
            0x00100000
        ],
    0x40 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020, 0x00000040, 0x000000f0,
            0x00007000, 0x00001800, 0x00006000, 0x00008000,
            0x00040000,                         0x00080000,
            0x00100000, 0x00200000, 0x00400000,
         ], #RTC_TAFCR
    0x44 : [
            0x00000000, 0x00003fff, 0x0f000000
        ], #RTC_ALRMASSR
    0x48 : [
            0x00000000, 0x00003fff, 0x0f000000
        ], #RTC_ALRMASSR
    0x4c : [
            0x00000000
        ], #RTC_BKP0R-0x50
}

# WWDG register map 
map_stm32f303xd_wwdg = {
    
    0x00 : [
            0x000000f0, 0x0000007f
        ], #WWDG_CR
    0x04 : [
            0x0000007f, 0x00000180, 0x00000200
        ], #WWDG_CFR
    0x08 : [
             0x00000001
        ], #WWDG_SR
}

# IWDG register map 
map_stm32f303xd_iwdg = {
    
    0x00 : [
            0x0000ffff
        ], #IWDG_KR
    0x04 : [
            0x00000007
        ], #IWDG_PR
    0x08 : [
            0x00000fff
        ], #IWDG_RLR
    0x0c : [
            0x00000001, 0x00000002, 0x00000004
        ], #IWDG_SR
    0x10 : [
            0x00000fff
        ] #IWDG_WINR
}

# SPI(I2Sext/SPI2/3/I2S2/3) register map 
map_stm32f303xd_spix = {
    
    0x00 : [
            0x00000001, 0x00000002, 0x00000004,
            0x00000038,             0x00000040, 0x00000080,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000, 0x00004000, 0x00008000
        ], #SPI_CR1
    0x04 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020, 0x00000040, 0x00000080,
            0x00000f00,
            0x00001000, 0x00002000, 0x00004000
        ], #SPI_CR2
    0x08 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020, 0x00000040, 0x00000080,
            0x00000100, 0x00000600, 
            0x00001800
        ], #SPI_SR
    0x0c : [
            0x0000ffff
        ], #SPI_DR
    0x10 : [
            0x0000ffff
        ], #SPI_CRCPR
    0x14: [
            0x0000ffff
        ], #SPI_RCCRCR
    0x18 : [
            0x0000ffff
        ], #SPI_TXCRCR
    0x1c : [
            0x0000ffff
        ], #SPI_I2SFGR
    0x20 : [
            0x000000ff, 0x000000f2, 0x00000100, 0x00000200
        ], #SPI_I2SPR

}   


# UART2/3(USART2/3) register map 
map_stm32f303xd_usart = {

    0x00 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020, 0x00000040, 0x00000080,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000, 0x00004000, 0x00008000,
            0x00010000, 0x00020000, 0x00040000, 0x00080000,
            0x00100000, 0x00200000, 0x00400000, 0x00800000,
            0x01000000, 0x02000000, 0x04000000, 0x08000000,
            0x10000000
        ], #USART_CR1
    0x04 : [
            0x00000010, 0x00000020, 0x00000040, 
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00003000, 0x00004000,             0x00008000,
            0x00010000, 0x00020000, 0x00040000, 0x00080000,
            0x00100000, 0x00200000, 0x00400000, 0x00800000,
            0x0f000000, 
            0xf0000000
        ], #USART_CR2
    0x08 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020, 0x00000040, 0x00000080,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000, 0x00004000, 0x00008000,
            0x000e0000, 
            0x00300000, 0x00400000
        ], #USART_CR3
    0x0c : [
            0x0000ffff
        ], #USART_BRR
    0x10 : [
            0x000000ff, 0x0000ff00
        ], #USART_GTBR
    0x14 : [
            0x00ffffff, 0xff000000
        ], #USART_RTOR
    0x18 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010
        ], #USART_RQR
    0x1c : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020, 0x00000040, 0x00000080, 
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000,             0x00004000, 0x00008000,
            0x00010000, 0x00020000, 0x00040000, 0x00080000,
            0x00100000, 0x00200000, 0x00400000
        ], #USART_ISR
    0x20 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008, 
            0x00000010,             0x00000040, 
            0x00000100, 0x00000200,             0x00000800,
            0x00001000,
                        0x00030000,
            0x00010000
        ], #USART_ICR
    0x24 : [
            0x000000ff
        ], #USART_RDR
    0x28 : [
            0x000000ff
        ] #USART_TDR
}

# I2C1/2 register map 
map_stm32f303xd_i2cx = {

    0x00 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008, 
            0x00000010, 0x00000020, 0x00000040, 0x00000080,
            0x00000f00,
            0x00001000,             0x00004000, 0x00008000,
            0x00010000, 0x00020000, 0x00040000, 0x00080000,
            0x00100000, 0x00200000, 0x00400000, 0x00800000
        ], #I2C_CR1
    0x04 : [
            0x000003ff,             0x00000400, 0x00000800,
            0x00001000, 0x00002000, 0x00004000, 0x00008000,
            0x00ff0000,
            0x01000000, 0x02000000, 0x04000000
        ], #I2C_CR2
    0x08 : [
            0x000003ff, 0x00000400,
            0x00010000
        ], #I2C_OAR1
    0x0c : [
            0x000000fe, 
            0x00000700,
            0x00008000
        ], #I2C_OAR2
    0x10 : [
            0x000000ff, 
            0x0000ff00, 
            0x000f0000, 
            0x00f00000,
            0xf0000000,
        ], #I2C_TIMINGR
    0x14 : [
            0x00000fff,
            0x00001000, 0x00008000,
            0x0fff0000,
            0x80000000,
        ], #I2C_TIMOUTGR
    0x18 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020, 0x00000040, 0x00000080,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000,             0x00008000,
            0x00010000,
            0x00fe0000
        ], #I2C_ISR
    0x1c : [
            0x00000008,
            0x00000010, 0x00000020,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000
        ], #I2C_ICR
    0x20 : [
            0x0000000f
        ], #I2C_PECR
    0x24 : [
            0x0000000f
        ],  #I2C_RXDR
    0x28 : [
            0x0000000f
        ], #I2C_TXDR
}

# USB device FS/CAN SRAM register map 
map_stm32f303xd_usbx = {

    0x00 : [
            0x0000000f,
            0x00000030,             0x00000040, 0x00000080,
            0x00000100, 0x00000600,             0x00000800,
            0x00003000,             0x00004000, 0x00008000
        ], #USB_EP0R
    0x04 : [
            0x0000000f,
            0x00000030,             0x00000040, 0x00000080,
            0x00000100, 0x00000600,             0x00000800,
            0x00003000,             0x00004000, 0x00008000
        ], #USB_EP1R
    0x08 : [
            0x0000000f,
            0x00000030,             0x00000040, 0x00000080,
            0x00000100, 0x00000600,             0x00000800,
            0x00003000,             0x00004000, 0x00008000
        ], #USB_EP2R
    0x0c : [
            0x0000000f,
            0x00000030,             0x00000040, 0x00000080,
            0x00000100, 0x00000600,             0x00000800,
            0x00003000,             0x00004000, 0x00008000
        ], #USB_EP3R
    0x10 : [
            0x0000000f,
            0x00000030,             0x00000040, 0x00000080,
            0x00000100, 0x00000600,             0x00000800,
            0x00003000,             0x00004000, 0x00008000
        ], #USB_EP4R
    0x14 : [
            0x0000000f,
            0x00000030,             0x00000040, 0x00000080,
            0x00000100, 0x00000600,             0x00000800,
            0x00003000,             0x00004000, 0x00008000
        ], #USB_EP5R
    0x18 : [
            0x0000000f,
            0x00000030,             0x00000040, 0x00000080,
            0x00000100, 0x00000600,             0x00000800,
            0x00003000,             0x00004000, 0x00008000
        ], #USB_EP6R
    0x1c : [
            0x0000000f,
            0x00000030,             0x00000040, 0x00000080,
            0x00000100, 0x00000600,             0x00000800,
            0x00003000,             0x00004000, 0x00008000
        ], #USB_EP7R
    0x20 : [], #Reserved
    0x24 : [], #Reserved
    0x28 : [], #Reserved
    0x2c : [], #Reserved
    0x30 : [], #Reserved
    0x34 : [], #Reserved
    0x38 : [], #Reserved
    0x3c : [], #Reserved
    0x40 : [
            0x00000001, 0x00000002, 0x00000004, 0x00000008,
            0x00000010, 0x00000020,             0x00000080,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000, 0x00004000, 0x00008000
        ], #USB_CNTR
    0x44 : [
            0x0000000f, 
            0x00000010,                         0x00000080,
            0x00000100, 0x00000200, 0x00000400, 0x00000800,
            0x00001000, 0x00002000, 0x00008000, 0x00008000
        ], #USB_ISTR
    0x48 : [
            0x000007ff, 
            0x00001800,
            0x00002000, 0x00004000, 0x00008000
        ],  #USB_FNR
    0x4c : [
            0x0000007f,
            0x00000080
        ], #USB_DADDR
    0x50 : [
            0x0000fff8
        ], #USB_BTABLE
    0x54 : [
            0x00000001, 0x00000002,              0x00000008,
            0x000000f0
        ], #USB_LPMCSR
}

# Peripheral register map 
map_stm32f303xd = {

    0x40000000 : {
        # Peripheral
        0x000 : map_stm32f303xd_timx,
        0x400 : map_stm32f303xd_timx,
        0x800 : map_stm32f303xd_timx,
        0x1000 : map_stm32f303xd_timy,
        0x1400 : map_stm32f303xd_timy,
        0x2800 : map_stm32f303xd_rtc,
        0x2c00 : map_stm32f303xd_wwdg,
        0x3000 : map_stm32f303xd_iwdg,
        0x3400 : map_stm32f303xd_spix,
        0x3800 : map_stm32f303xd_spix,
        0x3c00 : map_stm32f303xd_spix,
        0x4000 : map_stm32f303xd_spix,
        0x4400 : map_stm32f303xd_usart, 
        0x4800 : map_stm32f303xd_usart, 
        0x4c00 : map_stm32f303xd_usart, 
        0x5000 : map_stm32f303xd_usart, 
        0x5400 : map_stm32f303xd_i2cx,
        0x5800 : map_stm32f303xd_i2cx,
        0x5c00 : map_stm32f303xd_usbx,
        0x6000 : map_stm32f303xd_usbx,

    }, #APB1
    0x40010000 : {
    }, #APB2
    0x40020000 : {
        0x000 : {
            0x0 : []
        }
    }, #AHB1
    0x48000000 : {
        0x000 : {
            0x0 : []
        }
    }, #AHB2
    0x50000000 : {
        0x000 : {
            0x0 : []
        }
    }, #AHB3
    0xA000000 : {
        0x0 : []
    }, #AHB4
}

'''
    Combination of register mask
    @mask: the origin mask queue need to deal
    @ncomb: the num of mask which need to combine
        ncomb = num: combine nums' mask value 
'''
def comb_reg_mask(mask, ncomb):
    #print("comb_reg_mask")
    len_mask =len(mask)
    if 2 == ncomb:
        id1 = randrange(len_mask)
        id2 = randrange(len_mask)
        return mask[id1] | mask[id2]
    elif 3 == ncomb:
        id1 = randrange(len_mask) 
        id2 = randrange(len_mask) 
        id3 = randrange(len_mask) 
        return mask[id1] | mask[id2] | mask[id3]
    else:
        num =  randrange(len_mask) + 1
        res = 0
        for i in range(0, num + 1):
            id1 = randrange(len_mask) 
            res |= mask[id1]
        return res


'''
    Generate status value according to addr
    @addr: the access address we need to judge
    @level: the level of genertating status register value
            just return mask when level == 0/1
            use combianation when level > 0
'''
def generate_reg_value(addr, level = 0):
    
    base = addr & 0xffff0000  
    off1 = addr & 0x0000ff00
    off2 = addr & 0x000000ff
    arr = [] # store filename 
    if 0 == level or 1 == level:
        for mask in map_stm32f303xd[base][off1][off2]:
            print(struct.pack('>I', mask))
    else:
        _len = len(map_stm32f303xd[base][off1][off2])
        for i in range(0, _len):
            mask = comb_reg_mask(map_stm32f303xd[base][off1][off2], level)
            print(struct.pack('>I', mask) )
     #return arr

# main
if __name__ == "__main__":

    print("Gennerate a new value for status register")
    #print(map_stm32f303xd[0x40000000][0x000][0x00][0])
    print("level == 0/1")
    generate_reg_value(0x40000000, 0)
    print("level == 2")
    generate_reg_value(0x40000000, 2)
    print("level == 3")
    generate_reg_value(0x40000000, 3)
    index = 1
    fname = "value%d"%index
    print(fname)
