//
//  tc_rsa_crypt.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/29.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#ifndef tc_rsa_crypt_h
#define tc_rsa_crypt_h

#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    int tc_rsa_public_encrypt(const unsigned char* pInput, unsigned int uiInputLen
                              , unsigned char** ppOutput, unsigned int* uiOutputLen
                              , const char* pPublicKeyN, const char* pPublicKeyE);
#ifdef __cplusplus
}
#endif

#endif /* tc_rsa_crypt_h */
