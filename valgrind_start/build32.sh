export NDKROOT=$HOME/Downloads/android-ndk-r6

export HWKIND=generic

export AR=$NDKROOT/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-ar
export LD=$NDKROOT/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-ld
export CC=$NDKROOT/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc


CPPFLAGS="--sysroot=$NDKROOT/platforms/android-3/arch-arm" \
   CFLAGS="--sysroot=$NDKROOT/platforms/android-3/arch-arm" \
   ./configure --prefix=/data/local/Inst \
   --host=armv7-unknown-linux --target=armv7-unknown-linux \
   --with-tmpdir=/sdcard

