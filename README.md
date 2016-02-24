# valgrind

valgrind_start: Some scripts for running valgrind on Android Apps

      build32.sh:       build valgrind for arm devices
      build64.sh:       build valgrind for aarch-64 devices 
      pushapk.sh:       modify an App and push it to the device (not working for now)
      bootstrap.sh:     set logwrapper to start_valgrind.sh for the PACKAGE and start the App
      start_valgrind.sh:exec valgrind
      
Inst_xxx: cross-compiled Valgrind on different platforms

      usage: rename the one you want to "Inst", then "adb push Inst/ /". "Inst" should be in /data/local/. 
      Try "/data/local/Inst/bin/valgrind --version" to see if valgrind works.
