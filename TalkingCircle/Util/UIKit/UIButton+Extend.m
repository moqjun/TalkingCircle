//
//  UIButton+Extend.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/23.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "UIButton+Extend.h"

@implementation UIButton (Extend)


@end


///上下结构按钮：图片在上，文在在下
@implementation TCUpDownButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(imageViewFrame)) / 2;
    
    [self.titleLabel sizeToFit];
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(titleFrame)) / 2;
    
    CGFloat space = (CGRectGetHeight(self.bounds) - CGRectGetHeight(titleFrame) - CGRectGetHeight(imageViewFrame)) / 4;
    imageViewFrame.origin.y = space * 2;
    self.imageView.frame = imageViewFrame;
    
    titleFrame.origin.y = CGRectGetMaxY(imageViewFrame) + space + self.imageAndTextSpace;
    self.titleLabel.frame = titleFrame;
}

@end


@implementation TCImageLeftTextRightButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.origin.x = self.imageToLeftSpace+0;
    
    CGFloat space = self.imageAndTextSpace;
    
    [self.titleLabel sizeToFit];
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = CGRectGetWidth(imageViewFrame) + imageViewFrame.origin.x + space;
    
    self.imageView.frame = imageViewFrame;
    self.titleLabel.frame = titleFrame;
}

@end

@implementation TCImageRightTextRightButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = 0;
    [self.titleLabel sizeToFit];
    
    CGFloat space = self.imageAndTextSpace;
    
    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.origin.x = CGRectGetWidth(titleFrame) + titleFrame.origin.x + space;
    
    self.imageView.frame = imageViewFrame;
    self.titleLabel.frame = titleFrame;
}

@end
