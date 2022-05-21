#!/bin/sh
jffs2reset -y
fw_setenv dropbear_mode
fw_setenv dropbear_password
fw_setenv dropbear_key_type
#echo "Changing IMEI..."
#ubus call version set_atcmd_info '{"atcmd":"AT*PROD=2"}' > /dev/null 2&>1
#ubus call version set_atcmd_info '{"atcmd":"AT*MRD_IMEI=D"}' > /dev/null 2&>1
#ubus call version set_atcmd_info '{"atcmd":"AT*MRD_IMEI=W,0101,01NOV2012,864052036722755"}' > /dev/null 2&>1
#ubus call version set_atcmd_info '{"atcmd":"AT*PROD=0"}' > /dev/null 2&>1

firmware2=$(cat /proc/mtd | grep firmware2 | awk '{print $1}') 
if [ $firmware2 == 'mtd7:' ] 
then 
wget http://github.com/Karpovian05/bin/raw/main/b.bin -O /tmp/firmware.bin
echo "Wait for the modem to reboot..."
mtd -r write /tmp/firmware.bin /dev/mtd4
exit
fi 
wget http://github.com/Karpovian05/bin/raw/main/b.bin -O /tmp/firmware.bin
echo "Wait for the modem to reboot..."
mtd -r write /tmp/firmware.bin /dev/mtd5
exit
