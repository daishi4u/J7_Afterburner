#!/bin/bash

cd /home/brett/android/rr/system/core/libmincrypt/
gcc -c *.c -I ../include/
ar rcs libmincrypt.a *.o
cd ../mkdtbhbootimg
gcc mkbootimg.c -o mkbootimg -I ../include/ ../libmincrypt/libmincrypt.a
cp mkbootimg ../../../../mkdtbhbootimg/bin