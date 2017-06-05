//
//  EaseCommonUserDefault.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//  用于保存用户的基本信息

#import <Foundation/Foundation.h>

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define EASE_USER_INFORMATION @"EASE_USER_INFORMATION"

@interface EaseCommonUserDefault : NSObject


+(void) setObjectModel:(id) object forKey:(NSString *) key;

+(id) objectModelForKey:(NSString *)key;

/*设置保存用户信息，如只单独保存nickname address*/
+(void) setUserInformation:(id) object forKey:(NSString *) key;
/*设置获取用户信息，如只单独获取nickname address*/
+(id) getUserInformationForKey:(NSString *) key;
@end
