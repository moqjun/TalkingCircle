//
//  TCLoginTypeTextField.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/15.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCLoginTypeTextField.h"

#define titleAndActionFieldSpace 5

@implementation TCLoginTypeTextField


- (instancetype)initWithTitle:(NSString*)title
            actionButtonTitle:(NSString*)actionButtonTitle
                        frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize labSize = [title boundingRectWithSize:CGSizeMake(self.width, self.height) font:[UIFont systemFontOfSize:16] text:title];
        
        CGSize buttonSize = [actionButtonTitle boundingRectWithSize:CGSizeMake(self.width, self.height) font:[UIFont systemFontOfSize:16] text:actionButtonTitle];
        
        if (labSize.width < 65) {
            labSize.width = 65;
        }
        self.titleLab.frame = CGRectMake(0, 0, labSize.width, self.height);
        self.actionTextField.frame = CGRectMake(self.titleLab.right + titleAndActionFieldSpace, 0, self.width - self.titleLab.width - buttonSize.width - 8 - titleAndActionFieldSpace, self.height);
        self.actionBtn.frame = CGRectMake(self.actionTextField.right, 0, buttonSize.width + 8, self.height);
        self.titleLab.text = title;
        [self.actionBtn setTitle:actionButtonTitle forState:UIControlStateNormal];
        [self addSubview:self.titleLab];
        [self addSubview:self.actionTextField];
        [self addSubview:self.actionBtn];
        [self addSubview:self.bottomLineView];
    }
    
    return self;
}


- (instancetype)initWithTitle:(NSString*)title
            actionButtonImageName:(NSString*)actionButtonImageName
                        frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize labSize = [title boundingRectWithSize:CGSizeMake(self.width, self.height) font:[UIFont systemFontOfSize:16] text:title];
        
        UIImage *buttonImage = [UIImage imageNamed:actionButtonImageName];
        
        if (labSize.width < 65) {
            labSize.width = 65;
        }
        self.titleLab.frame = CGRectMake(0, 0, labSize.width, self.height);
        self.actionTextField.frame = CGRectMake(self.titleLab.right + titleAndActionFieldSpace, 0, self.width - self.titleLab.width - buttonImage.size.width - titleAndActionFieldSpace, self.height);
        self.actionBtn.frame = CGRectMake(self.actionTextField.right, 0, buttonImage.size.width, self.height);
        self.titleLab.text = title;
        
        [self.actionBtn setImage:[UIImage imageNamed:actionButtonImageName] forState:UIControlStateNormal];
        
        [self addSubview:self.titleLab];
        [self addSubview:self.actionTextField];
        [self addSubview:self.actionBtn];
        [self addSubview:self.bottomLineView];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString*)title
                        frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize labSize = [title boundingRectWithSize:CGSizeMake(self.width, self.height) font:[UIFont systemFontOfSize:16] text:title];
        
        if (labSize.width < 65) {
            labSize.width = 65;
        }
        self.titleLab.frame = CGRectMake(0, 0, labSize.width, self.height);
        self.actionTextField.frame = CGRectMake(self.titleLab.right + titleAndActionFieldSpace, 0, self.width - self.titleLab.width - titleAndActionFieldSpace, self.height);
        self.titleLab.text = title;
        [self addSubview:self.titleLab];
        [self addSubview:self.actionTextField];
        [self addSubview:self.bottomLineView];
    }
    
    return self;
}

- (void)setActionBtnTitle:(NSString*)title
{
    [self.actionBtn setTitle:title forState:UIControlStateNormal];
    
    CGSize buttonSize = [title boundingRectWithSize:CGSizeMake(self.width, self.height) font:[UIFont systemFontOfSize:16] text:title];
    
    self.actionTextField.frame = CGRectMake(self.actionTextField.x, self.actionTextField.y, self.width - self.titleLab.width - buttonSize.width - 8 - titleAndActionFieldSpace, self.height);
    self.actionBtn.frame = CGRectMake(self.actionTextField.right, 0, buttonSize.width + 8, self.height);
}

- (void)setActionTextFieldPlaceholder:(NSString*)placeholder color:(UIColor*)color
{
    if (color) {
       self.actionTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: color}];
    }else{
        self.actionTextField.placeholder =  placeholder;
    }
    
}
#pragma mark - UI Setter and Getter

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:16];
    }
    
    return _titleLab;
}

- (UITextField *)actionTextField
{
    if (!_actionTextField) {
        _actionTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _actionTextField;
}

- (UIButton *)actionBtn
{
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _actionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_actionBtn setTitleColor:[UIColor colorWithUInt:0xc2c2c2] forState:UIControlStateNormal];
    }
    return _actionBtn;
}


- (UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 0.5)];
        _bottomLineView.backgroundColor = [UIColor colorWithUInt:0xc2c2c2];
    }
    return _bottomLineView;
}

@end
