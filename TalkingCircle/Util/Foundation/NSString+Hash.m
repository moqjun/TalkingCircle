//
//  NSString+Hash.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/29.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "NSString+Hash.h"
#include "tcMd5.h"

@implementation NSString (Hash)


- (NSString*)md5String
{
    if (self.length < 1) {
        return nil;
    }
    
    unsigned char buf[16];
    tc_md5((const unsigned char *)[self UTF8String],
           (unsigned int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], buf);
    
    char outHexStr[33] = {0};
    tc_md5_sig16_to_hex_string((const char*)buf, outHexStr, sizeof(outHexStr));
    
//    NSLog(@"md5====:%@",[NSString stringWithFormat:@"%s", outHexStr]);
    
    return [NSString stringWithFormat:@"%s", outHexStr];
}

@end
