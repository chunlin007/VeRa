#! /bin/bash
# Install the packages used by VeRa

apt update
apt install python pkg-config libtool zlib1g-dev libsdl-dev libpixman-1-dev libjansson-dev libsdl-image1.2-dev wget gcc-arm-none-eabi -y
