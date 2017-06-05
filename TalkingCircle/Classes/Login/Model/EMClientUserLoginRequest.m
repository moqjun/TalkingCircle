//
//  EMClientUserLoginRequest.m
//  TalkingCircle
//
//  Created by 赵远 on 17/4/20.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "EMClientUserLoginRequest.h"
#import "ChatDemoHelper.h"

@implementation EMClientUserLoginRequest

+(EMClientUserLoginRequest*)shareInstance
{
    static EMClientUserLoginRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EMClientUserLoginRequest alloc] init];
    });
    
    return instance;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password callBack:(NetServiceCallBack)callBack
{

    //异步登陆账号
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                //获取数据库中数据
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[EMClient sharedClient] migrateDatabaseToLatestSDK];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ChatDemoHelper shareHelper] asyncGroupFromServer];
                        [[ChatDemoHelper shareHelper] asyncConversationFromDB];
                        [[ChatDemoHelper shareHelper] asyncPushOptions];
                    
                        if (callBack) {
                            callBack(nil,nil,nil);
                        }
                        //发送自动登陆状态通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];
                    });
                });
            } else {
                
                if (callBack) {
                    NSError *err = [NSError errorWithDomain:@"" code:1 userInfo:nil];
                    callBack(err,nil,nil);
                }
                
                switch (error.code)
                {
                    case EMErrorUserNotFound:
                        TCAlertNoTitle(NSLocalizedString(@"error.usernotExist", @"User not exist!"));
                        break;
                    case EMErrorNetworkUnavailable:
                        TCAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                        break;
                    case EMErrorServerNotReachable:
                        TCAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                        break;
                    case EMErrorUserAuthenticationFailed:
                        TCAlertNoTitle(error.errorDescription);
                        break;
                    case EMErrorServerTimeout:
                        TCAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                        break;
                    case EMErrorServerServingForbidden:
                        TCAlertNoTitle(NSLocalizedString(@"servingIsBanned", @"Serving is banned"));
                        break;
                    default:
                        TCAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                        break;
                }
            }
        });
    });
}

@end
