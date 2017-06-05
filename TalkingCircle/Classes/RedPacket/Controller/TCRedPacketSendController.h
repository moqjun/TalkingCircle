//
//  TCRedPacketController.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/23.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "BaseViewController.h"
#import "TCRedpacketSendDelgate.h"

@interface TCRedPacketSendController : BaseViewController

@property(nonatomic, weak) id <TCRedpacketSendDelgate> delegate;
@property(nonatomic, copy) NSString *userId;

@end
