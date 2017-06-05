//
//  MQUser.m
//  iOSAppTemplate
//
//  Created by 莫强军 on 15/9/16.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "MQUser.h"

@implementation MQUser

- (void) setUsername:(NSString *)username
{
    _username = username;
    _pinyin = username.pinyin;
    _initial = username.pinyinInitial;
}

@end
