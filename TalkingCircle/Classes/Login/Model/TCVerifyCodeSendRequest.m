//
//  TCVerifyCodeSendRequest.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/16.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCVerifyCodeSendRequest.h"

@implementation TCVerifyCodeSendRequest

- (void)sendVerifyCodeWithPhoneNum:(NSString*)phoneNum sendType:(VerifyCodeSendType)sendType callBack:(NetServiceCallBack)callBack
{
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_SendVerifyCode;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic safeSetObject:phoneNum forKey:@"mobile"];
        if (sendType == VerifyCodeSendType_Login) {
            [dic safeSetObject:@"login" forKey:@"scenes"];
        }else if (sendType == VerifyCodeSendType_Register){
            [dic safeSetObject:@"register" forKey:@"scenes"];
        }else if (sendType == VerifyCodeSendType_ForgetPassword){
            [dic safeSetObject:@"forgot" forKey:@"scenes"];
        }
        
        maker.cgiWrap.param = dic;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        if (callBack) {
            callBack(err, responseData, ext);
        }
    }];
}

@end
