
# download toolchain archives
GCC_AARCH64=gcc-linaro-aarch64-none-elf-4.8-2013.11_linux 
GCC_ARM=gcc-linaro-arm-none-eabi-4.8-2013.11_linux
GCC_AARCH64_M=gcc-arm-9.2-2019.12-x86_64-aarch64-none-elf


mkdir -p build/tools/

wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/${GCC_AARCH64}.tar.xz
wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/${GCC_ARM}.tar.xz
wget http://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/9.2-2019.12/binrel/${GCC_AARCH64_M}.tar.xz


tar xvfJ ${GCC_AARCH64}.tar.xz -C build/tools/
tar xvfJ ${GCC_ARM}.xz -C build/tools/
tar xvfJ ${GCC_AARCH64_M}.xz -C build/tools/