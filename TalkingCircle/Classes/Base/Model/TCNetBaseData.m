//
//  TCNetBaseData.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/29.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCNetBaseData.h"
#include "tc_aes_crypt.h"
#import "TCAesCryptTool.h"

@interface TCNetBaseData ()

@end

@implementation TCNetBaseData

+ (TCNetBaseData*)initWithJsonDic:(NSDictionary*)responseDic
{
    if (![responseDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    TCNetBaseData *baseData = [[TCNetBaseData alloc] init];
    baseData.status = [[responseDic objectForKey:@"status"] integerValue];;
    baseData.message = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"message"]];
    
    baseData.randomString = [responseDic objectForKey:@"random_string"];
    
    if (baseData.status == ServiceNetStatusCode_OK) {
        baseData.success = YES;
    }else{
        baseData.success = NO;
    }
    
    return baseData;
}

- (NSString*)aesKeyWithRandomAESKey:(NSString*)randomAESKey
{
//    unsigned int length = 0;
//    unsigned char *aesData = NULL;
//    
//  
//    NSData *decode64Data = [[NSData alloc]
//     initWithBase64EncodedString:self.randomString options:0];
//    
//    NSString *decodeString =  [[NSString alloc]initWithData:decode64Data encoding:NSUTF8StringEncoding];
////    NSString *str = [[NSString alloc] initWithData:nsdataDecoded encoding:NSUTF8StringEncoding];
//    NSLog(@"decodeString==:%@",decodeString);
//    NSData *keyData = [randomAESKey dataUsingEncoding:NSUTF8StringEncoding];
//    
//    if (0 != tc_aes_cbc_decrypt((const unsigned char*)keyData.bytes, (unsigned int)[keyData length], (const unsigned char*)([decode64Data bytes]), (unsigned int)decode64Data.length, &aesData, &length))
//    {
//        NSLog(@"decode  data failed");
//        return nil;
//    }
//    
//    NSData *resultData = [[NSData alloc]initWithBytes:aesData length:length];
//    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    NSString *key =  @"a";
    NSData *enString = [TCAesCryptTool aesEncodeWithKey:key encodeString:@"nihao"];
    NSData *deString = [TCAesCryptTool aesDecodeWithKey:key decodeData:enString];
    
    NSString *rr = [[NSString alloc] initWithData:deString encoding:NSUTF8StringEncoding];
    
    [self checkAesWithKey:key string:[[[NSData alloc]initWithBytes:[enString bytes] length:[enString length]] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    return rr;
}

- (void)checkAesWithKey:(NSString*)key string:(NSString*)string
{
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_AesTest;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:2];
        [param safeSetObject:key forKey:@"key"];
        [param safeSetObject:@"lZPUs8wflprN6WDg5RxuHQ==" forKey:@"string"];
        
        maker.cgiWrap.param = param;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        
    }];
}

@end
