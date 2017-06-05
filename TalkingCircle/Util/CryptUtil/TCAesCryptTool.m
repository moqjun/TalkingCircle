//
//  TCAesCryptTool.m
//  TalkingCircle
//
//  Created by 赵远 on 17/5/2.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCAesCryptTool.h"
#include "tc_aes_crypt.h"

@implementation TCAesCryptTool

+ (NSData*)aesEncodeWithKey:(NSString*)key encodeString:(NSString*)encodeString
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encodeData = [encodeString dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned int length = 0;
    unsigned char *aesData = NULL;
    if (0 != tc_aes_cbc_encrypt((const unsigned char*)keyData.bytes, (unsigned int)[keyData length], (const unsigned char*)([encodeData bytes]), (unsigned int)encodeData.length, &aesData, &length))
    {
        NSLog(@"encode  data failed");
        return nil;
    }

    
    NSData *resultData = [[NSData alloc]initWithBytes:aesData length:length];
    return resultData;
}

+ (NSData*)aesDecodeWithKey:(NSString*)key decodeData:(NSData*)decodeData
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned int length = 0;
    unsigned char *aesData = NULL;
    if (0 != tc_aes_cbc_decrypt((const unsigned char*)keyData.bytes, (unsigned int)[keyData length], (const unsigned char*)([decodeData bytes]), (unsigned int)decodeData.length, &aesData, &length))
    {
        NSLog(@"decode  data failed");
        return nil;
    }
    
    NSData *resultData = [[NSData alloc]initWithBytes:aesData length:length];
    return resultData;
}


@end
