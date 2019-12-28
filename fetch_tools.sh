
# download toolchain archives
GCC_AARCH64=gcc-linaro-aarch64-none-elf-4.8-2013.11_linux 
GCC_ARM=gcc-linaro-arm-none-eabi-4.8-2013.11_linux


mkdir -p build/tools/

wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/${GCC_AARCH64}.tar.xz
wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/${GCC_ARM}.tar.xz


tar xvfJ ${GCC_AARCH64}.tar.xz -C build/tools/
tar xvfJ ${${GCC_ARM}.xz -C build/tools/