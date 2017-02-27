#!/bin/bash

make j7elte_00_defconfig
make -j4 2> builderrors.txt
mv builderrors.txt afterburner/out/