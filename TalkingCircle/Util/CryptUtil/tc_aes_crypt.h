//
//  tc_aes_crypt.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/29.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#ifndef tc_aes_crypt_h
#define tc_aes_crypt_h

#ifdef __cplusplus
extern "C" {
#endif
    int tc_aes_cbc_encrypt(const unsigned char* pKey, unsigned int uiKeyLen
                           , const unsigned char* pInput, unsigned int uiInputLen
                           , unsigned char** ppOutput, unsigned int* pOutputLen);
    
    int tc_aes_cbc_decrypt(const unsigned char* pKey, unsigned int uiKeyLen
                           , const unsigned char* pInput, unsigned int uiInputLen
                           , unsigned char** ppOutput, unsigned int* pOutputLen);
#ifdef __cplusplus
}
#endif

#endif /* tc_aes_crypt_h */
