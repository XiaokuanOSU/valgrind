#!/usr/bin/env bash

PACKAGE="zhangx.kb3"

adb push start_valgrind.sh /data/local/
adb shell su -c chmod 777 /data/local/start_valgrind.sh 

adb root
adb shell setprop wrap.$PACKAGE "logwrapper\ /data/local/start_valgrind.sh"

echo "wrap.$PACKAGE: $(adb shell getprop wrap.$PACKAGE)"

adb shell am force-stop $PACKAGE
adb shell am start -a android.intent.action.MAIN -n "zhangx.kb3/.MainActivity"

adb logcat -c
adb logcat

exit 0 