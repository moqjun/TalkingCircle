//
//  UIUtil.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/23.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#ifndef UIUtil_h
#define UIUtil_h

#import "UITools.h"

#define BOUND_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define BOUND_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

#define TC_NAV_HEIGHT 64

#define TAB_HEIGHT 50

#define KXMENU_FRAME_X CGRectGetWidth([UIScreen mainScreen].bounds) - 40
#define KXMENU_FRAME_Y 0
#define KXMENU_FRAME_W 30
#define KXMENU_FRAME_H 0

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].applicationFrame)

#define SCREEN_WIDTH_Portrait [UITools screenWidthOfPortrait]        //竖屏时的宽度
#define SCREEN_HEIGHT_Portrait [UITools screenWidthOfPortrait]       //竖屏时的高度

#define TCScreenHeightOri(ori)  [UITools screenHeight:ori]

#define ViewObjectInMiddleOriginX(viewObjectWidth) floorf((BOUND_WIDTH - viewObjectWidth)/2)

#endif /* UIUtil_h */
