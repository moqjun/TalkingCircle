//
//  UIButton+Extend.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/23.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extend)

@end

///上下结构按钮：图片在上，文在在下
@interface TCUpDownButton : UIButton

@property(nonatomic, assign) float imageAndTextSpace;

@end

//左右结构按钮：图片在左，文在右
@interface TCImageLeftTextRightButton : UIButton

@property(nonatomic, assign) float imageToLeftSpace;//图片距离左边的距离
@property(nonatomic, assign) float imageAndTextSpace;

@end

//左右结构按钮：图片在右，文在左
@interface TCImageRightTextRightButton : UIButton

@property(nonatomic, assign) float imageAndTextSpace;

@end
