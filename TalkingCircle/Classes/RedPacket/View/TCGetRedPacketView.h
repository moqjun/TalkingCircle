//
//  TCGetRedPacketView.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/23.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCGetRedPacketView : UIView

- (void)setRedpacketInfo:(NSString*)sendNickName
                userIconUrl:(NSString*)iconUrl
                userIconImage:(UIImage*)iconImage
                 message:(NSString*)message
                 orderId:(NSString*)orderId;

- (void)show;

@end
