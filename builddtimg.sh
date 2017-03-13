#!/bin/bash

KERNELDIR=/home/brett/j7elte/j7kernel
MYOUT=$KERNELDIR/arch/arm64/boot
ABDIR=$KERNELDIR/afterburner
MYTOOLS=$ABDIR/mkdtbhbootimg/bin

# copy a temp ramdisk to make a temp boot image
cp $ABDIR/ramdisk/boot.img-ramdisk.gz $MYOUT/

cd $MYOUT
mkdir $MYOUT/j7elte
mkdir $MYOUT/j7e3g

# Compile the dt for J7elte
cp dts/exynos7580-j7elte_rev00.dtb j7elte/
cp dts/exynos7580-j7elte_rev04.dtb j7elte/
cp dts/exynos7580-j7elte_rev06.dtb j7elte/
cp dts/exynos7580-j7e3g_rev00.dtb j7e3g/
cp dts/exynos7580-j7e3g_rev05.dtb j7e3g/
cp dts/exynos7580-j7e3g_rev08.dtb j7e3g/


# a workaround to get the dt.img for j7elte
$MYTOOLS/mkbootimg --kernel Image --ramdisk boot.img-ramdisk.gz --dt_dir j7elte -o boot-new.img
mkdir $MYOUT/tmp
$MYTOOLS/unpackbootimg -i boot-new.img -o tmp
cp $MYOUT/tmp/boot-new.img-dt $ABDIR/zipsrc/devices/j7elte/dt.img
rm -rf $MYOUT/tmp
rm $MYOUT/boot-new.img

# a workaround to get the dt.img for j7e3g
$MYTOOLS/mkbootimg --kernel Image --ramdisk boot.img-ramdisk.gz --dt_dir j7e3g -o boot-new2.img
mkdir $MYOUT/tmp2
$MYTOOLS/unpackbootimg -i boot-new2.img -o tmp2
cp $MYOUT/tmp2/boot-new2.img-dt $ABDIR/zipsrc/devices/j7e3g/dt.img
rm -rf $MYOUT/tmp2
rm $MYOUT/boot-new2.img

# copy the kernel
cp Image $ABDIR/zipsrc/kernel/zImage

# cleanup
rm -rf $MYOUT/j7elte/
rm -rf $MYOUT/j7e3g/
rm $MYOUT/Image.gz-dtb
rm $MYOUT/boot.img-ramdisk.gz

# make the flashable zip
cd $ABDIR/zipsrc
zip -r afterburner.zip kernel/ bootimgtools/ add-ons/ META-INF/ devices/
mv afterburner.zip $ABDIR/out/
rm $ABDIR/zipsrc/devices/j7elte/dt.img
rm $ABDIR/zipsrc/devices/j7e3g/dt.img
rm $ABDIR/zipsrc/kernel/zImage

# move to my personal out dir
cp $ABDIR/out/afterburner.zip $KERNELDIR/../../dev/buildout/kernel/
