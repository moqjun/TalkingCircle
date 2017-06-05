//
//  NSString+Extend.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/15.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

- (NSString *)clearMarginSpace;

- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font text:(NSString *)text;

- (BOOL)isPhoneNum;

+(NSString *)ret128bitString;

@end
