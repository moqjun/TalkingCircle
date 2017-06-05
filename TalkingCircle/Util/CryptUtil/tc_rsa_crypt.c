//
//  tc_rsa_crypt.c
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/29.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#include "tc_rsa_crypt.h"
#include <string.h>
#include <stdlib.h>

#include "polarssl/rsa.h"
#include "polarssl/entropy.h"
#include "polarssl/ctr_drbg.h"

int tc_rsa_public_encrypt(const unsigned char* pInput, unsigned int uiInputLen
                          , unsigned char** ppOutput, unsigned int* uiOutputLen
                          , const char* pPublicKeyN, const char* pPublicKeyE)
{
    
    int finalLen = 0;
    int i = 0;
    int ret;
    int rsa_len;
    if(pInput == NULL || uiOutputLen == NULL
       || pPublicKeyN == NULL || pPublicKeyE == NULL
       || uiInputLen == 0 || ppOutput == NULL)
        return -1;
    
    rsa_context rsa;
    entropy_context entropy;
    ctr_drbg_context ctr_drbg;
    
    const char *pers = "rsa_encrypt";
    
    entropy_init( &entropy );
    if( ( ret = ctr_drbg_init( &ctr_drbg, entropy_func, &entropy,
                              (const unsigned char *) pers,
                              strlen( pers ) ) ) != 0 )
    {
        return ret;
    }
    
    rsa_init( &rsa, RSA_PKCS_V15, RSA_PKCS_V21 );
    
    if( ( ret = mpi_read_string(&rsa.N , 16, pPublicKeyN)) != 0 ||
       ( ret = mpi_read_string(&rsa.E , 16, pPublicKeyE) ) != 0 )
    {
        return ret;
    }
    
    rsa.len = ( mpi_msb( &rsa.N ) + 7 ) >> 3;
    
    rsa_len = rsa.len;
    
    //rsa 加密数据长度最多只能是rsa.len - 11,加密的数据大于这个数值，需要分组加密
    if((int)uiInputLen >= rsa_len - 11)
    {
        int blockCnt = (uiInputLen / (rsa_len - 11)) + (((uiInputLen % (rsa_len - 11)) == 0) ? 0 : 1);
        finalLen = blockCnt * rsa_len;
        *ppOutput = (unsigned char*)calloc(finalLen, sizeof(unsigned char));
        if(*ppOutput == NULL)
        {
            ret = -1;
            goto END;
        }
        
        
        for(; i < blockCnt; ++i)
        {
            int blockSize = rsa_len - 11;
            if(i == blockCnt - 1) blockSize = uiInputLen - i * blockSize;
            
            if( ( ret = rsa_pkcs1_encrypt( &rsa, ctr_drbg_random, &ctr_drbg,
                                          RSA_PUBLIC, blockSize, (const unsigned char*)(pInput + i * (rsa_len - 11)), (*ppOutput + i * rsa_len) ) ) != 0 )
            {
                goto END;
            }
            
        }
        *uiOutputLen = finalLen;
    }
    else
    {
        *ppOutput = (unsigned char*)calloc(rsa_len, sizeof(unsigned char));
        if (*ppOutput == NULL)
        {
            ret = -1;
            goto END;
        }
        
        if( ( ret = rsa_pkcs1_encrypt( &rsa, ctr_drbg_random, &ctr_drbg,
                                      RSA_PUBLIC, uiInputLen, (const unsigned char*)pInput, *ppOutput ) ) != 0 )
        {
            goto END;
        }
        *uiOutputLen = rsa_len;
    }
    
END:
    if(0 != ret)
    {
        if(*ppOutput != NULL)
        {
            free(*ppOutput);
            ppOutput = NULL;
        }
    }
    return ret;
    
}
