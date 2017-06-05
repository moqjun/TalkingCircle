//
//  tcMd5.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/29.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#ifndef tcMd5_h
#define tcMd5_h

#ifdef __cplusplus
extern "C" {
#endif
    
#include <stdio.h>
    
    void tc_md5( const unsigned char *input, size_t ilen, unsigned char output[16] );
    void tc_md5_sig16_to_hex_string(const char* sig, char* outBuf, unsigned int outBufLen);
    
#ifdef __cplusplus
}
#endif

#endif /* tcMd5_h */
