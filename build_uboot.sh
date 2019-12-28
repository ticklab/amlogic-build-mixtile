# this is the uboot build script
GCC_AARCH64=gcc-arm-9.2-2019.12-x86_64-aarch64-none-elf 

# first we have to got the toolchains

# export toolchains 
export PATH=$PWD/build/tools/${GCC_AARCH64}/bin:$PATH

export FIPDIR=$PWD/aml-uboot-legacy/fip
export FIPDIR_ML=$PWD/aml-uboot/fip

# build mainline uboot
cd $PWD/aml-uboot

make ARCH=arm CROSS_COMPILE=aarch64-none-elf- khadas-vim3_defconfig
make ARCH=arm CROSS_COMPILE=aarch64-none-elf-

mkdir -p $FIPDIR_ML

# Copy legacy fip referring to mainline
cp $FIPDIR/gxl/bl2.bin $FIPDIR_ML/
cp $FIPDIR/gxl/acs.bin $FIPDIR_ML/
cp $FIPDIR/gxl/bl21.bin $FIPDIR_ML/
cp $FIPDIR/gxl/bl30.bin $FIPDIR_ML/
cp $FIPDIR/gxl/bl301.bin $FIPDIR_ML/
cp $FIPDIR/gxl/bl31.img $FIPDIR_ML/
cp u-boot.bin $FIPDIR_ML/bl33.bin

$FIPDIR/blx_fix.sh \
	$FIPDIR_ML/bl30.bin \
	$FIPDIR_ML/zero_tmp \
	$FIPDIR_ML/bl30_zero.bin \
	$FIPDIR_ML/bl301.bin \
	$FIPDIR_ML/bl301_zero.bin \
	$FIPDIR_ML/bl30_new.bin \
	bl30

python $FIPDIR/acs_tool.pyc $FIPDIR_ML/bl2.bin $FIPDIR_ML/bl2_acs.bin $FIPDIR_ML/acs.bin 0

$FIPDIR/blx_fix.sh \
	$FIPDIR_ML/bl2_acs.bin \
	$FIPDIR_ML/zero_tmp \
	$FIPDIR_ML/bl2_zero.bin \
	$FIPDIR_ML/bl21.bin \
	$FIPDIR_ML/bl21_zero.bin \
	$FIPDIR_ML/bl2_new.bin \
	bl2

$FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input $FIPDIR_ML/bl30_new.bin
$FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input $FIPDIR_ML/bl31.img
$FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input $FIPDIR_ML/bl33.bin
$FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input $FIPDIR_ML/bl2_new.bin --output $FIPDIR_ML/bl2.n.bin.sig
$FIPDIR/gxl/aml_encrypt_gxl --bootmk \
		--output $FIPDIR_ML/u-boot.bin \
		--bl2 $FIPDIR_ML/bl2.n.bin.sig \
		--bl30 $FIPDIR_ML/bl30_new.bin.enc \
		--bl31 $FIPDIR_ML/bl31.img.enc \
		--bl33 $FIPDIR_ML/bl33.bin.enc
