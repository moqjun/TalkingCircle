//
//  EaseCommonUserDefault.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "EaseCommonUserDefault.h"

@implementation EaseCommonUserDefault

+(void) setObjectModel:(id) object forKey:(NSString *) key
{
    [USER_DEFAULT setObject:object forKey:key];
    [USER_DEFAULT synchronize];
}

+(id) objectModelForKey:(NSString *)key
{
    return [USER_DEFAULT objectForKey:key];
}

+(void) setUserInformation:(id) object forKey:(NSString *) key
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:
                                 [USER_DEFAULT objectForKey:EASE_USER_INFORMATION]];
    
    [dict setObject:object forKey:key];
    NSDictionary *tempDict =[NSDictionary dictionaryWithDictionary:dict];
    [self setObjectModel:tempDict forKey:EASE_USER_INFORMATION];
}

+(id) getUserInformationForKey:(NSString *)key
{
    NSMutableDictionary *dict = [USER_DEFAULT objectForKey:key];
    
    return [dict objectForKey:key];
}

@end
