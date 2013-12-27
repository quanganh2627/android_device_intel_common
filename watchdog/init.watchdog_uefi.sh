#!/system/bin/sh

# This script is started from watchdog.rc to
# determine if watchdog counter should be clear if
# androidboot.notclearwdogcounter is set in cmdline
notclearcounter=`getprop ro.boot.notclearwdogcounter`

if test "$notclearcounter" != "1"
then
    /sbin/uefivar -n WdtCounter -g 80868086-8086-8086-8086-000000000200 -s 0 -t int -k
fi
exit 0
