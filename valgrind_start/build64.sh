export NDK_HOME=$HOME/Downloads/android-ndk-r10e

export HWKIND=generic

export TOOLCHAIN=$NDK_HOME/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin/aarch64-linux-android

export AR=$TOOLCHAIN-ar
export LD=$TOOLCHAIN-ld
export CC=$TOOLCHAIN-gcc

CPPFLAGS="--sysroot=$NDK_HOME/platforms/android-21/arch-arm64" \
   CFLAGS="--sysroot=$NDK_HOME/platforms/android-21/arch-arm64" \
   ./configure --prefix=/data/local/Inst \
   --host=aarch64-unknown-linux --target=aarch64-unknown-linux \
   --with-tmpdir=/sdcard

