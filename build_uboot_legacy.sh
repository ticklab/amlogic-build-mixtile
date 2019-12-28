# this is the uboot build script
GCC_AARCH64=gcc-linaro-aarch64-none-elf-4.8-2013.11_linux 
GCC_ARM=gcc-linaro-arm-none-eabi-4.8-2013.11_linux

# first we have to got the toolchains

# export toolchains 
export PATH=$PWD/build/tools/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PATH
export PATH=$PWD/build/tools/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH

export FIPDIR=$PWD/aml-uboot-legacy/fip
export FIPDIR_ML=$PWD/aml-uboot/fip

mkdir -p $FIPDIR_ML

# build legacy uboot
cd $PWD/aml-uboot-legacy
make ARCH=arm CROSS_COMPILE=aarch64-none-elf- kvim_defconfig
make ARCH=arm CROSS_COMPILE=aarch64-none-elf-

cd -
