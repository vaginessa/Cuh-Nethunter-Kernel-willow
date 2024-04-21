#!/bin/bash -e
#
# Compile script for Cuh kernel
# Copyright (C) 2020-2023 Adithya R.
# Copyright (C) 2023 Tejas Singh.

SECONDS=0 # builtin bash timer

TC_DIR="$PWD/tc"
CLANG_DIR="$TC_DIR/prelude-clang"
GCC_64_DIR="$TC_DIR/aarch64-linux-android-4.9"
GCC_32_DIR="$TC_DIR/arm-linux-androideabi-4.9"

DEFCONFIG="nethunter_defconfig" # w/o: "vendor/ginkgo-perf_defconfig"; w: nethunter_defconfig
export PATH="$CLANG_DIR/bin:$PATH"

if [[ $1 = "-r" || $1 = "--regen" ]]; then
make O=out ARCH=arm64 $DEFCONFIG savedefconfig
cp out/defconfig arch/arm64/configs/$DEFCONFIG
exit
fi

mkdir -p out
make O=out ARCH=arm64 $DEFCONFIG

echo -e "\nStarting compilation...\n"
make -j$(nproc --all) O=out ARCH=arm64 CC=clang LD=ld.lld AR=llvm-ar AS=llvm-as NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip CROSS_COMPILE=$GCC_64_DIR/bin/aarch64-linux-android- CROSS_COMPILE_ARM32=$GCC_32_DIR/bin/arm-linux-androideabi- CLANG_TRIPLE=aarch64-linux-gnu- Image.gz-dtb dtbo.img 2>&1 | tee error.log

if [ -f "out/arch/arm64/boot/Image.gz-dtb" ] && [ -f "out/arch/arm64/boot/dtbo.img" ]; then
echo -e "\nCompilation done!\n"
fi
exit
