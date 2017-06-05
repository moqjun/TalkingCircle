//
//  NetCGIWrap.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "NetCGIWrap.h"
#import "NSMutableDictionary+Param.h"
#include "tc_rsa_crypt.h"

#define RSA_PUBLIC_KEYE_CLI "010001"

#define RSA_PUBLIC_KEYN_CLI  "D5FA592CAFD1209FB1809299DA59890D86421075C13800AF6DB16802390F83AD065016E2946A7880852A7C3C5CDFBECBFD50E1447E6F4434692266FA0132AEBF05C3C4DC121EF896261A737E0E31EB8A09624F6D6F0ECA86AEB1082084EA26276395F9872FCC6DC025735F29B89DD4FF136753954BE40DEBEBC1985B4F0B2425"



@implementation NetCGIWrap


- (id)init
{
    self = [super init];
    if (self) {
        self.m_channelType = NetCGI_CHANNEL_TYPE_NONE;
        self.m_retryCount = -1; // 重试次数为-1，表示使用网络组件配置的默认重试次数
        self.m_timeout = 0;
        self.requestMethod = NetRequestMethod_GET;
        self.responseDataType = NetResponseDataType_JSON;
    }
    return self;
}

- (void)reuse
{
    self.m_responsePb = nil;
}

- (NSData*)rsaRequestData
{
    NSString *paramString = [self.param paramToString];
    
    NSData *paramData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    
    const char *rsaKeyn = RSA_PUBLIC_KEYN_CLI;
    const char *rsaKeye = RSA_PUBLIC_KEYE_CLI;
    unsigned char* pOutput = NULL;
    unsigned int outputLen = 0;
    
    tc_rsa_public_encrypt([paramData bytes], (unsigned int)[paramData length]
                          , &pOutput, &outputLen
                          , rsaKeyn, rsaKeye);
    
    NSString *base64Encoded = [[[NSData alloc]initWithBytes:pOutput length:outputLen] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [base64Encoded dataUsingEncoding:NSUTF8StringEncoding];
}

@end
