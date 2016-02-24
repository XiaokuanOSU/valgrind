#!/usr/bin/env bash

#set -x 

adb root
adb remount

# Ensure Valgrind on the phone is running
adb shell "/data/local/Inst/bin/valgrind --version"

# Add Valgrind executable to PATH (this might fail)
adb shell "export PATH=$PATH:/data/local/Inst/bin/"

export NDK_HOME=$HOME/Downloads/android-ndk-r10e
export SDK_HOME=$HOME/Downloads/android-sdk-linux
export PATH=$SDK_HOME/tools:$PATH
export PATH=$SDK_HOME/platform-tools:$PATH
RUN_HELLO_JNI_THROUGH_VALGRIND=true

cd valgrind-3.11.0

if [ $RUN_HELLO_JNI_THROUGH_VALGRIND = true ]; then
  PACKAGE="zhangx.kb3"

  # The location of the Hello JNI sample application
  HELLO_JNI_PATH="$HOME/zxk/valgrind/Kb3/"

  pushd "$HELLO_JNI_PATH" 

  # Update build target to the desired Android SDK version
  ANDROID_PROJECT_TARGET="android-18"
  android update project --target "$ANDROID_PROJECT_TARGET" --path . --name kb3 --subprojects

  # Enable Android NDK build with Ant
  echo '<?xml version="1.0" encoding="utf-8"?>

    <project name="Kb3" basedir="." default="debug">

    <target name="-pre-build">
      <exec executable="${ndk.dir}/ndk-build" failonerror="true"/>
    </target>

    <target name="clean" depends="android_rules.clean">
      <exec executable="${ndk.dir}/ndk-build" failonerror="true">
      <arg value="clean"/>
      </exec>
    </target> 

    </project>
  ' > "custom_rules.xml"

  # Set NDK HOME for Ant (only if not already set)
  if ! grep -P -q "ndk.dir=.+" "local.properties" ; then
    echo -e "\nndk.dir=$NDK_HOME" >> "local.properties"
  fi

  # Fix for Java 8 warning (warning: [options] source value 1.5 is obsolete and will be removed in a future release)
  echo "java.compilerargs=-Xlint:-options" >> "ant.properties"

  # Workaround INSTALL_PARSE_FAILED_INCONSISTENT_CERTIFICATES error
  adb uninstall "$PACKAGE"

  # Build Hello JNI project in debug mode and install it on the device
  ant clean && ant debug && ant installd

  popd

  cd ..  

  # Start HelloJNI app 
  #adb shell am start -a android.intent.action.MAIN -n $PACKAGE/.HelloJni

  # Make the script executable
  #chmod a+x bootstrap_valgrind.sh

  # Run application through Valgrind on the phone
  #/usr/bin/env bash bootstrap_valgrind.sh

  #adb shell ls -lR "/sdcard/*grind*"
  #adb shell ls -lR "/storage/sdcard0/*grind*"
  #adb shell ls -lR "/storage/sdcard1/*grind*"
fi
