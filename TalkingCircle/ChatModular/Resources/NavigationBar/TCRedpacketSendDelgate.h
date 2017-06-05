//
//  TCRedpacketSendDelgate.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/30.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TCRedpacketSendDelgate <NSObject>

- (void)personalRedpacketSendWithRedpacketInfo:(NSMutableDictionary*)redpacketInfoDic;

@end
