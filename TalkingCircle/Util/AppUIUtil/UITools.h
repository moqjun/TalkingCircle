//
//  UITools.h
//  PADRP
//
//  Created by zhaoYuan on 17/1/22.
//  Copyright © 2017年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UINavigationController.h>

@interface UITools : NSObject

+(CGFloat) screenWidthCurOri;

+(CGFloat) screenHeightCurOri;

+(CGFloat) screenHeight;

+ (CGFloat) screenHeight:(UIInterfaceOrientation)orientation;

+ (CGFloat)screenWidthOfPortrait;

+ (CGFloat)screenHeightOfPortrait;

@end
