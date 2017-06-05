//
//  MQUserHelper.m
//  iOSAppTemplate
//
//  Created by 莫强军 on 15/10/19.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "MQUserHelper.h"

static MQUserHelper *userHelper = nil;

@implementation MQUserHelper

+ (MQUserHelper *)sharedUserHelper
{
    if (userHelper == nil) {
        userHelper = [[MQUserHelper alloc] init];
    }
    return userHelper;
}

- (MQUser *) user
{
    if (_user == nil) {
        _user = [[MQUser alloc] init];
        _user.username = @"用户名";
        _user.userID = @"b4398fhuih34";
        _user.avatarURL = @"0.jpg";
    }
    return _user;
}

@end
