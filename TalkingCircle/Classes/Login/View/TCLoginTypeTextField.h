//
//  TCLoginTypeTextField.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/15.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCLoginTypeTextField : UIView

@property (nonatomic, strong) UITextField *actionTextField;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *actionBtn;
@property (nonatomic, strong) UIView *bottomLineView;

- (instancetype)initWithTitle:(NSString*)title
            actionButtonTitle:(NSString*)actionButtonTitle
                        frame:(CGRect)frame;

- (instancetype)initWithTitle:(NSString*)title
        actionButtonImageName:(NSString*)actionButtonImageName
                        frame:(CGRect)frame;

- (instancetype)initWithTitle:(NSString*)title
                        frame:(CGRect)frame;

- (void)setActionBtnTitle:(NSString*)title;

- (void)setActionTextFieldPlaceholder:(NSString*)placeholder color:(UIColor*)color;

@end
