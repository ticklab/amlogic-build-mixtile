#ifndef _AD85030_H
#define _AD85030_H

#define MVOL                             0x03
#define C1VOL                            0x04


#define CFADDR                           0x1d
#define A1CF1                            0x1e
#define A1CF2                            0x1f
#define A1CF3                            0x20
#define CFUD                             0x2d

#define AD85030_REGISTER_COUNT		 			 156
#define AD85030_RAM_TABLE_COUNT          180

#define I2C_RETRY_DELAY 5 /* ms */  
#define I2C_RETRIES 3
struct ad85030_platform_data {
	//int reset_pin;
};

#endif
