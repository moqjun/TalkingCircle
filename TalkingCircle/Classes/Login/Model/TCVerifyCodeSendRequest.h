//
//  TCVerifyCodeSendRequest.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/16.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VerifyCodeSendType)  {
    VerifyCodeSendType_Login = 0,
    VerifyCodeSendType_Register = 1,
    VerifyCodeSendType_ForgetPassword = 2
};

@interface TCVerifyCodeSendRequest : NSObject

- (void)sendVerifyCodeWithPhoneNum:(NSString*)phoneNum sendType:(VerifyCodeSendType)sendType callBack:(NetServiceCallBack)callBack;


@end
