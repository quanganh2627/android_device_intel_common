#!/system/bin/sh

echo "setup for cdk"

echo "create sst device"
mknod /dev/sst c 255 0
chmod 777 /dev/sst
mknod /dev/sst_am c 255 1
chmod 777 /dev/sst_am

echo "chmod /dev/lpe_ctl"
chmod 777 /dev/lpe
chmod 777 /dev/lpe_ctrl

echo "set sst pmic frequency and channel"
system/bin/sst_pmic_freq -f 44100 -c 2

echo "create psb device"
mkdir /dev/dri
mknod /dev/dri/card0 c 226 0
chmod 777 /dev/dri/card0
