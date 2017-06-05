//
//  UITools.m
//  PADRP
//
//  Created by zhaoYuan on 17/1/22.
//  Copyright © 2017年 容灾规划支持组. All rights reserved.
//

#import "UITools.h"
#import "DeviceInfo.h"

BOOL g_isTaskBarHidden = YES;
BOOL g_isStatusBarLandscape = NO;
UIStatusBarStyle g_currentStatusBarStyle;
CGSize g_screenSize;


@implementation UITools

#pragma mark - UI Parameter

CGFloat g_statusBarHeight = 20;

+(CGFloat) statusBarHeight {
    return [UITools statusBarHeight:[UIApplication sharedApplication].statusBarOrientation];
}

+(CGFloat) statusBarHeight:(UIInterfaceOrientation)orientation {
    // iOS8上的状态栏高度已改成设备方向相关
    CGFloat statusBarHeight = 0;
    if ([DeviceInfo isiOS8plus]) {
        if (![UIApplication sharedApplication].statusBarHidden) {
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
        else {
            // ios8上当statusBar隐藏时，statusBarFrame的宽高为零，取出上一次的结果作为返回值
            statusBarHeight = g_statusBarHeight;
        }
    }
    else {
        if(UIInterfaceOrientationIsLandscape(orientation)) {
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.width;
        }
        else {
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    g_statusBarHeight = statusBarHeight;
    return statusBarHeight;
}

+(CGFloat) navigationBarHeight {
    return 44;
}

+(CGFloat) screenHeight {
    if ([DeviceInfo isiOS8plus]) {
        if (CGSizeEqualToSize(g_screenSize, CGSizeZero)) {
            return [[UIScreen mainScreen] bounds].size.height;
        }
        else {
            return g_screenSize.height;
        }
    }
    else {
        return [[UIScreen mainScreen] bounds].size.height;
    }
}

+(CGFloat) screenHeightCurOri {
    return [UITools screenHeight:[UIApplication sharedApplication].statusBarOrientation];
}

+ (CGFloat) screenHeight:(UIInterfaceOrientation)orientation {
    // iOS8上的屏幕大小已改成设备方向相关
    if ([DeviceInfo isiOS8plus]) {
        if (CGSizeEqualToSize(g_screenSize, CGSizeZero)) {
            // 横竖屏方向不一致，取width作为height
            if((UIInterfaceOrientationIsPortrait(orientation) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
               || (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) && UIInterfaceOrientationIsLandscape(orientation))) {
                return [[UIScreen mainScreen] bounds].size.width;
            }
            return [[UIScreen mainScreen] bounds].size.height;
        }
        else {
            return g_screenSize.height;
        }
    }
    else {
        if(UIInterfaceOrientationIsLandscape(orientation)) {
            return [[UIScreen mainScreen] bounds].size.width;
        }
        return [[UIScreen mainScreen] bounds].size.height;
    }
}

+(CGFloat) screenWidth {
    if ([DeviceInfo isiOS8plus]) {
        if (CGSizeEqualToSize(g_screenSize, CGSizeZero)) {
            return [[UIScreen mainScreen] bounds].size.height;
        }
        else {
            return g_screenSize.height;
        }
    }
    else {
        return [[UIScreen mainScreen] bounds].size.width;
    }
}

+(CGFloat) screenWidthCurOri {
    return [UITools screenWidth:[UIApplication sharedApplication].statusBarOrientation];
}

+(CGFloat) screenWidth:(UIInterfaceOrientation)orientation
{
    // iOS8上的屏幕大小已改成设备方向相关
    if ([DeviceInfo isiOS8plus]) {
        if (CGSizeEqualToSize(g_screenSize, CGSizeZero)) {
            // 横竖屏方向不一致，取height作为width
            if((UIInterfaceOrientationIsPortrait(orientation) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
               || (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) && UIInterfaceOrientationIsLandscape(orientation))) {
                return [[UIScreen mainScreen] bounds].size.height;
            }
            return [[UIScreen mainScreen] bounds].size.width;
        }
        else {
            return g_screenSize.width;
        }
    }
    else {
        if(UIInterfaceOrientationIsLandscape(orientation)) {
            return [[UIScreen mainScreen] bounds].size.height;
        }
        return [[UIScreen mainScreen] bounds].size.width;
    }
}

+ (CGFloat)screenWidthOfPortrait
{
    if ([[UIScreen mainScreen] bounds].size.width > [[UIScreen mainScreen] bounds].size.height) {
        return [[UIScreen mainScreen] bounds].size.height;
    }else
    {
        return [[UIScreen mainScreen] bounds].size.width;
    }
}

+ (CGFloat)screenHeightOfPortrait
{
    if ([[UIScreen mainScreen] bounds].size.width > [[UIScreen mainScreen] bounds].size.height) {
        return [[UIScreen mainScreen] bounds].size.width;
    }else
    {
        return [[UIScreen mainScreen] bounds].size.height;
    }
}

+(CGFloat) mainScreenWidth
{
    if ([DeviceInfo isiPhone])
    {
        return [[UIScreen mainScreen] bounds].size.height > [[UIScreen mainScreen] bounds].size.width ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height;
    }
    else
    {
        return [UITools screenWidthCurOri];
    }
}

+ (void)setScreenSize:(CGSize)screenSize
{
    g_screenSize = screenSize;
}


+ (UIWindow*)getTopVisibleWindow
{
    NSArray* windows = [[UIApplication sharedApplication] windows];
    UIWindowLevel topWindowLevel = FLT_MIN;
    UIWindow* topWindow = nil;
    for (UIWindow* window in windows) {
        if (!window.hidden && topWindowLevel <= window.windowLevel) {
            topWindowLevel = window.windowLevel;
            topWindow = window;
        }
    }
    return topWindow;
}

#pragma mark - StatusBar

+ (void)OnSystemStatusBarOrientationChange:(UIInterfaceOrientation)orientation
{
    g_isStatusBarLandscape = !UIInterfaceOrientationIsPortrait(orientation);
}


+ (BOOL)isStatusBarHidden {
    
    //    if ([DeviceInfo isiOS7plus]) {
    //        return g_isStatusBarHidden;
    //    }
    
    return [UIApplication sharedApplication].statusBarHidden;
}

+ (BOOL)isStatusBarLandscape {
    return g_isStatusBarLandscape;
}


+ (UIInterfaceOrientation)getRotatedOrientation
{
    return [UITools isStatusBarLandscape] ? UIInterfaceOrientationLandscapeLeft : UIInterfaceOrientationPortrait;
}


#pragma mark - status bar & navigation bar style

+ (void)setStatusBarFontWhite
{
    if([DeviceInfo isiOS7plus])
    {
        [UITools setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

+ (void)setStatusBarFontBlack
{
    [UITools setStatusBarStyle:UIStatusBarStyleDefault];
}

// 恢复上次设置的状态栏样式。调用时机：taskBar消失时。
+ (void)refreshStatusBarStyle
{
    [UITools setStatusBarStyle:g_currentStatusBarStyle];
}

+ (void)setStatusBarStyle : (UIStatusBarStyle)style
{
    if(![DeviceInfo isiOS7plus]) return;
    
    g_currentStatusBarStyle = style;
    [[UIApplication sharedApplication] setStatusBarStyle:style];
}

@end
