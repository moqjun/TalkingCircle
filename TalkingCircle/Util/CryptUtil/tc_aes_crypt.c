//
//  tc_aes_crypt.c
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/29.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#include "tc_aes_crypt.h"
#include "polarssl/aes.h"

#include <stdlib.h>
#include <string.h>

#define TC_AES_KEY_LEN 16
#define TC_AES_KEY_BITSET_LEN 128

int tc_aes_cbc_encrypt(const unsigned char* pKey, unsigned int uiKeyLen
                       , const unsigned char* pInput, unsigned int uiInputLen
                       , unsigned char** ppOutput, unsigned int* pOutputLen)
{
    unsigned char keyBuf[TC_AES_KEY_LEN] = {0};
    unsigned char iv[TC_AES_KEY_LEN];
    
    aes_context aes;
    int ret;
    
    unsigned int uiPaddingLen;
    unsigned int uiTotalLen;
    unsigned char* pData;
    
    if(pKey == NULL || uiKeyLen == 0 || pInput == NULL || uiInputLen == 0
       || pOutputLen == NULL || ppOutput == NULL)
        return -1;
    
    memcpy(keyBuf, pKey, (uiKeyLen > TC_AES_KEY_LEN) ? TC_AES_KEY_LEN : uiKeyLen);
    memcpy(iv, keyBuf, TC_AES_KEY_LEN);
    
    ret = aes_setkey_enc(&aes, keyBuf, TC_AES_KEY_BITSET_LEN);
    if(ret != 0) return -1;
    
    uiPaddingLen = TC_AES_KEY_LEN - (uiInputLen % TC_AES_KEY_LEN);
    uiTotalLen = uiInputLen + uiPaddingLen;
    pData = malloc(uiTotalLen);
    memcpy(pData, pInput, uiInputLen);
    
    if(uiPaddingLen > 0) memset(pData+uiInputLen, uiPaddingLen, uiPaddingLen);
    
    *pOutputLen = uiTotalLen;
    *ppOutput = malloc(uiTotalLen);
    memset(*ppOutput, 0, uiTotalLen);
    
    ret = aes_crypt_cbc(&aes, AES_ENCRYPT, uiTotalLen, iv, (const unsigned char *)pData, *ppOutput);
    
    free(pData);
    return 0;
}

int tc_aes_cbc_decrypt(const unsigned char* pKey, unsigned int uiKeyLen
                       , const unsigned char* pInput, unsigned int uiInputLen
                       , unsigned char** ppOutput, unsigned int* pOutputLen)
{
    
    unsigned char keyBuf[TC_AES_KEY_LEN] = {0};
    unsigned char iv[TC_AES_KEY_LEN];
    
    aes_context aes;
    int ret;
    int uiPaddingLen;
    
    if(pKey == NULL || uiKeyLen == 0 || pInput == NULL || uiInputLen == 0 || pOutputLen == NULL
       || (uiInputLen%TC_AES_KEY_LEN) != 0 || ppOutput == NULL)
        return -1;
    
    memcpy(keyBuf, pKey, (uiKeyLen > TC_AES_KEY_LEN) ? TC_AES_KEY_LEN : uiKeyLen);
    memcpy(iv, keyBuf, TC_AES_KEY_LEN);
    
    ret = aes_setkey_dec(&aes, keyBuf, TC_AES_KEY_BITSET_LEN);
    if(ret != 0) { return -1; }
    
    *ppOutput = malloc(uiInputLen);
    memset(*ppOutput, 0, uiInputLen);
    
    ret = aes_crypt_cbc(&aes, AES_DECRYPT, uiInputLen, iv, (const unsigned char *)pInput, *ppOutput);
    
    uiPaddingLen = (*ppOutput)[uiInputLen - 1];
    if(uiPaddingLen > TC_AES_KEY_LEN || uiPaddingLen <= 0) {
        free(*ppOutput);
        ppOutput = NULL;
        return -1;
    }
    
    *pOutputLen = uiInputLen - uiPaddingLen;
    
    return 0;
}
