//
//  EMClientUserLoginRequest.h
//  TalkingCircle
//
//  Created by 赵远 on 17/4/20.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMClientUserLoginRequest : NSObject

+(EMClientUserLoginRequest*)shareInstance;

//环信登录
- (void)loginWithUsername:(NSString *)username password:(NSString *)password callBack:(NetServiceCallBack)callBack;

@end
