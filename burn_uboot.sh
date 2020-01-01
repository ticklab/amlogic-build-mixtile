FLASH_DISK=/dev/sdc
UBOOT_ML=aml-uboot

dd if=${UBOOT_ML}/fip/u-boot.bin.sd.bin of=${FLASH_DISK} conv=fsync,notrunc bs=512 skip=1 seek=1
dd if=${UBOOT_ML}/fip/u-boot.bin.sd.bin of=${FLASH_DISK} conv=fsync,notrunc bs=1 count=444
