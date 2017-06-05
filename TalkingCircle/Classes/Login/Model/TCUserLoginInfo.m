//
//  TCUserLoginInfo.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/16.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCUserLoginInfo.h"

#define APPTokenKey "APPTokenKey"
#define APPUserNameKey "APPUserNameKey"
#define APPPasswordMd5Key "APPPasswordMd5Key"
#define APPAesKey "APPAesKey"


@interface TCUserLoginInfo ()


@end

@implementation TCUserLoginInfo

+ (instancetype)shareInstance
{
    static TCUserLoginInfo *loginInfo;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginInfo = [[TCUserLoginInfo alloc] init];
    });
    
    return loginInfo;
}

- (NSString *)token
{
   return [[NSUserDefaults standardUserDefaults] objectForKey:@APPTokenKey];
}

- (void)updateToken:(NSString*)token
{
    if (token.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@APPTokenKey];
}

- (NSString *)userName
{
   return [[NSUserDefaults standardUserDefaults] objectForKey:@APPUserNameKey];
}

- (void)updateUserName:(NSString*)userName
{
    if (userName.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@APPUserNameKey];
}


- (NSString *)passwordMd5
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@APPPasswordMd5Key];
}

- (void)updatePasswordMd5:(NSString*)passwordMd5
{
    if (passwordMd5.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:passwordMd5 forKey:@APPPasswordMd5Key];
}

- (NSString *)aesKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@APPAesKey];
}

- (void)updateAesKey:(NSString*)newAesKey
{
    if (newAesKey.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:newAesKey forKey:@APPPasswordMd5Key];
}
@end
