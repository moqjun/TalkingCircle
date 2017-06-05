//
//  UIColor+Extend.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/22.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extend)

///根据十六进制rgb值获取颜色
+ (UIColor *)colorWithUInt:(NSUInteger)rgbHex;

+ (UIColor *)colorWithUInt:(NSUInteger)rgbHex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
