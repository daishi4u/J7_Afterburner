#!/bin/bash

KERNELDIR=/home/brett/android/j7kernel
MYOUT=$KERNELDIR/arch/arm64/boot
ABDIR=$KERNELDIR/afterburner
MYTOOLS=$ABDIR/mkdtbhbootimg/bin
cp $ABDIR/ramdisk/boot.img-ramdisk.gz $MYOUT/
cd $MYOUT
cp Image $ABDIR/zipsrc/kernel/zImage

# a workaround to get the dt.img
$MYTOOLS/mkbootimg --kernel Image --ramdisk boot.img-ramdisk.gz --dt_dir dts -o boot-new.img
mkdir tmp
$MYTOOLS/unpackbootimg -i boot-new.img -o tmp
cp tmp/boot-new.img-dt $ABDIR/zipsrc/kernel/dt.img
rm -rf $MYOUT/tmp
cd $ABDIR/zipsrc

# make the flashable zip
zip -r afterburner.zip stock/ kernel/ bootimgtools/ add-ons/ META-INF/
cp afterburner.zip $ABDIR/out/

# move to my personal out dir
mv afterburner.zip $KERNELDIR/../../dev/buildout/kernel/
