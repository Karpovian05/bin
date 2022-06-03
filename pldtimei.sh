#!/bin/sh
jffs2reset -y
fw_setenv dropbear_mode
fw_setenv dropbear_password
fw_setenv dropbear_key_type

wget https://github.com/Karpovian05/bin/raw/main/PLDTEasyImei.bin -O /tmp/a.bin

#check file and firmware
file=$(md5sum /tmp/a.bin | grep /tmp/a.bin | awk '{print $1}')
firmware2=$(cat /proc/mtd | grep firmware2 | awk '{print $1}')

if [ $file == '3f9706c22e9fc7bb1828e06b4614e8f6' ]; then
echo "Firmware verified. Proceeding..."
if [ $firmware2 == 'mtd7:' ]; then
echo "Wait for the modem to reboot..."
mtd -r write /tmp/a.bin /dev/mtd4

else
echo "Wait for the modem to reboot..."
mtd -r write /tmp/a.bin /dev/mtd5
fi

else
echo "Firmware not verified. Please contact dev."
echo "Process cancelled..."
rm -rf /tmp/a.bin
fi
exit
