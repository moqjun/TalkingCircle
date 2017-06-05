//
//  NSString+Extend.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/15.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

- (NSString *)clearMarginSpace
{
    NSCharacterSet *spaceCharateSet = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:spaceCharateSet];
}

- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font text:(NSString *)text
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

- (BOOL)isPhoneNum
{
    if (self.length != 11 || ![[self substringToIndex:1] isEqualToString:@"1"]) {
        return NO;
    }else{
        return YES;
    }
    
}

+(NSString *)ret128bitString
{
    
    char data[128];
    
    for (int x=0;x<128;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:128 encoding:NSUTF8StringEncoding];
    
}

@end
