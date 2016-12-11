#!/bin/bash

home="/home/ttn/Desktop"
isoimage="/home/ttn/Desktop/debian/debian-live-8.6.0-i386-cinnamon-desktop.iso"
loopdir="/home/ttn/Desktop/loopdir"
cd="/home/ttn/Desktop/cd"
irmod="/home/ttn/Desktop/irmod"
preseed="/home/ttn/Desktop/preseed.cfg"
newiso="/home/ttn/Desktop/test4.iso"

cd $home #start in "/home/ttn/Desktop"

mkdir $loopdir
mount -o loop $isoimage $loopdir
mkdir $cd
rsync -a -H --exclude=TRANS.TBL $loopdir/ $cd
umount $loopdir

mkdir $irmod
cd $irmod
gzip -d < $cd/install/initrd.gz | cpio --extract --verbose --make-directories --no-absolute-filenames
cp $preseed preseed.cfg
find . | cpio -H newc --create --verbose | gzip -9 > $cd/install/initrd.gz
cd ../

cd $cd
md5sum `find -follow -type f` > md5sum.txt
cd ..

genisoimage -o $newiso -r -J -no-emul-boot -boot-load-size 4 -boot-info-table -b isolinux/isolinux.bin -c isolinux/boot.cat $cd

rm -rf $cd $irmod $loopdir
