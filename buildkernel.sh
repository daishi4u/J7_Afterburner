#!/bin/bash

make j7elte_00_defconfig
make -j4
cp arch/arm64/boot/Image /srv/samba/dev/buildout/kernel/zImage
