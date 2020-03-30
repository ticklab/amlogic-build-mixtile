# this is the uboot build script
GCC_AARCH64=gcc-arm-9.2-2019.12-x86_64-aarch64-none-elf

# first we have to got the toolchains

# export toolchains 
export PATH=$PWD/build/tools/${GCC_AARCH64}/bin:$PATH

export UBOOTDIR=$PWD/aml-uboot-legacy
export FIPDIR=$PWD/aml-uboot-legacy/fip
export FIPDIR_ML=$PWD/aml-uboot/fip
export ROOTDIR=$PWD

# build mainline uboot
cd $PWD/aml-uboot

#make ARCH=arm CROSS_COMPILE=aarch64-none-elf- khadas-vim3_defconfig
make ARCH=arm CROSS_COMPILE=aarch64-none-elf- mixtile-edge_defconfig
make ARCH=arm CROSS_COMPILE=aarch64-none-elf-

mkdir -p $FIPDIR_ML

# Copy legacy fip referring to mainline
cp $UBOOTDIR/build/scp_task/bl301.bin $FIPDIR_ML/
#cp $UBOOTDIR/build/board/khadas/kvim3/firmware/acs.bin $FIPDIR_ML/
cp $UBOOTDIR/build/board/mixtile/edge/firmware/acs.bin $FIPDIR_ML/
cp $FIPDIR/g12b/bl2.bin $FIPDIR_ML/
cp $FIPDIR/g12b/bl30.bin $FIPDIR_ML/
cp $FIPDIR/g12b/bl31.img $FIPDIR_ML/
cp $FIPDIR/g12b/ddr3_1d.fw $FIPDIR_ML/
cp $FIPDIR/g12b/ddr4_1d.fw $FIPDIR_ML/
cp $FIPDIR/g12b/ddr4_2d.fw $FIPDIR_ML/
cp $FIPDIR/g12b/diag_lpddr4.fw $FIPDIR_ML/
cp $FIPDIR/g12b/lpddr3_1d.fw $FIPDIR_ML/
cp $FIPDIR/g12b/lpddr4_1d.fw $FIPDIR_ML/
cp $FIPDIR/g12b/lpddr4_2d.fw $FIPDIR_ML/
cp $FIPDIR/g12b/piei.fw $FIPDIR_ML/
cp $FIPDIR/g12b/aml_ddr.fw $FIPDIR_ML/
cp u-boot.bin $FIPDIR_ML/bl33.bin

$ROOTDIR/blx_fix.sh \
	$FIPDIR_ML/bl30.bin \
	$FIPDIR_ML/zero_tmp \
	$FIPDIR_ML/bl30_zero.bin \
	$FIPDIR_ML/bl301.bin \
	$FIPDIR_ML/bl301_zero.bin \
	$FIPDIR_ML/bl30_new.bin \
	bl30

$ROOTDIR/blx_fix.sh \
	$FIPDIR_ML/bl2.bin \
	$FIPDIR_ML/zero_tmp \
	$FIPDIR_ML/bl2_zero.bin \
	$FIPDIR_ML/acs.bin \
	$FIPDIR_ML/bl21_zero.bin \
	$FIPDIR_ML/bl2_new.bin \
	bl2

$UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input $FIPDIR_ML/bl30_new.bin \
					--output $FIPDIR_ML/bl30_new.bin.g12a.enc \
					--level v3
$UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input $FIPDIR_ML/bl30_new.bin.g12a.enc \
					--output $FIPDIR_ML/bl30_new.bin.enc \
					--level v3 --type bl30
 $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input $FIPDIR_ML/bl31.img \
					--output $FIPDIR_ML/bl31.img.enc \
					--level v3 --type bl31
$UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input $FIPDIR_ML/bl33.bin --compress lz4 \
					--output $FIPDIR_ML/bl33.bin.enc \
					--level v3 --type bl33 --compress lz4
 $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input $FIPDIR_ML/bl2_new.bin \
					--output $FIPDIR_ML/bl2.n.bin.sig

 $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
		--output $FIPDIR_ML/u-boot.bin \
		--bl2 $FIPDIR_ML/bl2.n.bin.sig \
		--bl30 $FIPDIR_ML/bl30_new.bin.enc \
		--bl31 $FIPDIR_ML/bl31.img.enc \
		--bl33 $FIPDIR_ML/bl33.bin.enc \
		--ddrfw1 $FIPDIR_ML/ddr4_1d.fw \
		--ddrfw2 $FIPDIR_ML/ddr4_2d.fw \
		--ddrfw3 $FIPDIR_ML/ddr3_1d.fw \
		--ddrfw4 $FIPDIR_ML/piei.fw \
		--ddrfw5 $FIPDIR_ML/lpddr4_1d.fw \
		--ddrfw6 $FIPDIR_ML/lpddr4_2d.fw \
		--ddrfw7 $FIPDIR_ML/diag_lpddr4.fw \
		--ddrfw8 $FIPDIR_ML/aml_ddr.fw \
		--ddrfw9 $FIPDIR_ML/lpddr3_1d.fw \
		--level v3

