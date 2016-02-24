#!/system/bin/sh

PACKAGE="zhangx.kb3"

# Callgrind tool
VGPARAMS=' --tool=callgrind --trace-children=no --error-limit=no --compress-strings=no --log-file=/sdcard/valgrind_log/valgrind.log.%p  --callgrind-out-file=/sdcard/valgrind_log/callgrind.out.%p'
#--kernel-variant=android-no-hw-tls
# Memcheck tool
#VGPARAMS='--tool=memcheck --error-limit=no --log-file=/sdcard/valgrind_log/valgrind.log.%p'
#--kernel-variant=android-no-hw-tls
export TMPDIR=/data/data/$PACKAGE

adb shell su -c /data/local/Inst/bin/valgrind $VGPARAMS $* 
