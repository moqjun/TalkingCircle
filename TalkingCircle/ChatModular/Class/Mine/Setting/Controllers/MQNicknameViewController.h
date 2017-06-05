//
//  MQNicknameViewController.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NickNameBlock)(NSString *nickName);

@interface MQNicknameViewController : UIViewController

@property(nonatomic,strong) NickNameBlock block;

@end
