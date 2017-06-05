//
//  TCRedpacketAboutRequest.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/5/1.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCRedpacketAboutRequest : NSObject

- (void)sendGroupRedpacketWithNum:(NSString*)num amount:(NSString*)amount callBack:(NetServiceCallBack)callBack;
- (void)sendPersonalRedpacketWithUserId:(NSString*)userId amount:(NSString*)amount callBack:(NetServiceCallBack)callBack;
- (void)openRedpacketWithId:(NSString*)orderId callBack:(NetServiceCallBack)callBack;
- (void)redpacketStatusWithId:(NSString*)orderId callBack:(NetServiceCallBack)callBack;

@end
