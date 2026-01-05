#!/bin/sh -e

cd ${GITHUB_WORKSPACE}
ls
echo =====================================
echo =====================================
echo ============== W H A T ==============
echo =====================================
echo =====================================
export PATH="$PWD/toolchain/gcc/bin:$PWD/toolchain/clang/bin:$PATH"
echo $PATH
export ARCH=arm
export CC=clang
export HOSTCC=clang
export CROSS_COMPILE=arm-linux-androideabi-
export CLANG_TRIPLE=arm-linux-gnueabi-
export KCFLAGS=-w
export CFLAGS_WARN=-Wunused-but-set-variable
export CONFIG_SECTION_MISMATCH_WARN_ONLY=y
export XXX="ARCH=arm CC=clang HOSTCC=clang CROSS_COMPILE=arm-linux-androideabi- CLANG_TRIPLE=arm-linux-gnueabi- KCFLAGS=-w CFLAGS_WARN=-Wunused-but-set-variable CONFIG_SECTION_MISMATCH_WARN_ONLY=y"
echo =====================================
echo =====================================
echo ============== W H A T ==============
echo =====================================
echo =====================================
# Building Kernel Image
cd ${GITHUB_WORKSPACE}
mkdir -p out
make $XXX mrproper && make O=out $XXX mrproper
make O=out $XXX reco_defconfig
make O=out $XXX -j8

# Copying and Zip zImage
cd out/arch/arm/boot && zip -r zImage.zip zImage
mv zImage.zip ${GITHUB_WORKSPACE}/.
cd ${GITHUB_WORKSPACE}
rm -rf out
