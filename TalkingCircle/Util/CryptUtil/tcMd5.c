//
//  tcMd5.c
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/29.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#include "tcMd5.h"
#include "polarssl/md5.h"

#define HEX_STRING	"0123456789abcdef"

void tc_md5( const unsigned char *input, size_t ilen, unsigned char output[16] )
{
    md5(input, ilen, output);
}

void tc_md5_sig16_to_hex_string(const char* sig, char* outBuf, unsigned int outBufLen)
{
    unsigned char	*sig_p;
    char		*str_p, *max_p;
    unsigned int	high, low;
    
    str_p = outBuf;
    max_p = outBuf + outBufLen;
    
    for (sig_p = (unsigned char *)sig;
         sig_p < (unsigned char *)sig + 16;
         sig_p++) {
        high = *sig_p / 16;
        low = *sig_p % 16;
        /* account for 2 chars */
        if (str_p + 1 >= max_p) {
            break;
        }
        *str_p++ = HEX_STRING[high];
        *str_p++ = HEX_STRING[low];
    }
    /* account for 2 chars */
    if (str_p < max_p) {
        *str_p++ = '\0';
    }
}
