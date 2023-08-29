#! /bin/bash

# Chunlin:
#   Boot gdb to connect to Qemu

arm-none-eabi-gdb -ex 'target remote localhost:9000'

