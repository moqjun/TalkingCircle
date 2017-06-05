//
//  NSString+URL.m
//  PADRP
//
//  Created by 赵远(平安科技集团运营管理部智能运营平台组) on 17/3/23.
//  Copyright © 2017年 容灾规划支持组. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString *)URLEncodedString
{
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodeUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    return encodeUrl;
}

@end