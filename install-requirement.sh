#! /bin/bash
# Dependent packets
apt update
apt install python pkg-config libtool zlib1g-dev libsdl-dev libpixman-1-dev libjansson-dev libsdl-image1.2-dev wget

# Get arm gcc
tar xvf gcc-arm-none-eabi-10.tar.gz 
ln -sf $PWD/gcc-arm-none-eabi-10/bin/arm-none-eabi-nm /bin/arm-none-eabi-nm
ln -sf $PWD/gcc-arm-none-eabi-10/bin/arm-none-eabi-objdump /bin/arm-none-eabi-objdump
