//
//  ADGlobalUiAppearance.m
//  PADRP
//
//  Created by zhaoYuan on 17/1/22.
//  Copyright © 2017年 容灾规划支持组. All rights reserved.
//

#import "TCGlobalUiAppearance.h"


@implementation TCGlobalUiAppearance

///初始化整体UI外观
+ (void)initMainUiAppearance
{
    [TCGlobalUiAppearance tabbarItemAppStyle];
}

///tabbar风格
+ (void)tabbarItemAppStyle
{
    UIColor *normalColor = [UIColor colorWithHexString:@"c0c0c0"];
    UIColor *selectColor = [UIColor colorWithHexString:@"f5f5f9"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:normalColor, NSForegroundColorAttributeName,nil];
    NSDictionary *selectedDict = [NSDictionary dictionaryWithObjectsAndKeys:selectColor, NSForegroundColorAttributeName,nil];
    UITabBarItem *tabbarItem = [UITabBarItem appearance];
    [tabbarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [tabbarItem setTitleTextAttributes:selectedDict forState:UIControlStateHighlighted];
    [tabbarItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
}


@end
