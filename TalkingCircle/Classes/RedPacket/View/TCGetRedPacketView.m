//
//  TCGetRedPacketView.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/23.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCGetRedPacketView.h"
#import "TCRedpacketAboutRequest.h"

@interface TCGetRedPacketView ()
{
    NSString *redOrderId;
    TCRedpacketAboutRequest *redpacketRequest;
    
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *userIconImgView;
@property (nonatomic, strong) UIButton *openBtn;
@property (nonatomic, strong) UILabel *nickNameLab;
@property (nonatomic, strong) UILabel *messageLab;

@end

@implementation TCGetRedPacketView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithUInt:0x000000 alpha:0.25];
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.closeBtn];
        [self.contentView addSubview:self.userIconImgView];
        [self.contentView addSubview:self.nickNameLab];
        [self.contentView addSubview:self.messageLab];
        [self.contentView addSubview:self.openBtn];
        
        redpacketRequest = [[TCRedpacketAboutRequest alloc] init];
    }
    
    return self;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)setRedpacketInfo:(NSString*)sendNickName
             userIconUrl:(NSString*)iconUrl
           userIconImage:(UIImage*)iconImage
                 message:(NSString*)message
                 orderId:(NSString*)orderId
{
    redOrderId = orderId;
    self.nickNameLab.text = sendNickName;
    self.messageLab.text = message;
    if (iconImage) {
      self.userIconImgView.image = iconImage;
    }else{
        
    }
    
}

- (void)closePageAction
{
    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)openRedpacketAction
{
    [redpacketRequest openRedpacketWithId:redOrderId callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        if (!err) {
            TCNetBaseData *baseData = [TCNetBaseData initWithJsonDic:responseData];
            if (baseData.success) {
                
            }else
            {
                TCAlert(baseData.message);
            }
        }else
        {
            
        }
    }];
}

#pragma mark - UI 

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(ViewObjectInMiddleOriginX(281), floorf((BOUND_HEIGHT - 350)/2), 281, 350)];
        _contentView.backgroundColor = [UIColor colorWithUInt:0xd91817];
        _contentView.layer.cornerRadius = 8.0f;
    }
    return _contentView;
}


- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 27, 27)];
        [_closeBtn setImage:[UIImage imageNamed:@"reward-close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closePageAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeBtn;
}


- (UIImageView *)userIconImgView
{
    if (!_userIconImgView) {
        _userIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(floorf((self.contentView.width - 71)/2), 46, 71, 71)];
        _userIconImgView.layer.cornerRadius = (71/2);
        [_userIconImgView setClipsToBounds:YES];
    }
    return _userIconImgView;
}

- (UILabel *)nickNameLab
{
    if (!_nickNameLab) {
        _nickNameLab = [[UILabel alloc] initWithFrame:CGRectMake(20, self.userIconImgView.bottom + 20, self.contentView.width - 40, 20)];
        _nickNameLab.textAlignment = NSTextAlignmentCenter;
        _nickNameLab.font = [UIFont systemFontOfSize:16];
        _nickNameLab.textColor = [UIColor whiteColor];
    }
    return _nickNameLab;
}

- (UILabel *)messageLab
{
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] initWithFrame:CGRectMake(20, self.nickNameLab.bottom + 20, self.contentView.width - 40, 20)];
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.font = [UIFont systemFontOfSize:16];
        _messageLab.textColor = [UIColor colorWithUInt:0xfbdeb0];
    }
    return _messageLab;
}

- (UIButton *)openBtn
{
    if (!_openBtn) {
        _openBtn = [[UIButton alloc] initWithFrame:CGRectMake(floorf((self.contentView.width - 60)/2), self.contentView.height - 52 - 60, 60, 60)];
        [_openBtn setImage:[UIImage imageNamed:@"reward-open"] forState:UIControlStateNormal];
        [_openBtn addTarget:self action:@selector(openRedpacketAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}

@end
