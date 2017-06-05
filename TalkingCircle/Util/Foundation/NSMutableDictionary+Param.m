//
//  NSMutableDictionary+Param.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/5/1.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "NSMutableDictionary+Param.h"

@implementation NSMutableDictionary (Param)

- (NSString*)paramToString
{
    if (self.allKeys.count == 0) {
        return nil;
    }else{
        NSMutableString *resultString = [NSMutableString string];
        for (NSString *sKey in self.allKeys) {
            [resultString appendString:[NSString stringWithFormat:@"%@=%@&",sKey,[self objectForKey:sKey]]];
        }
        return resultString;
    }
        
}

@end

@implementation NSDictionary (Param)

- (NSString*)paramToString
{
    if (self.allKeys.count == 0) {
        return nil;
    }else{
        NSMutableString *resultString = [NSMutableString string];
        for (NSString *sKey in self.allKeys) {
            [resultString appendString:[NSString stringWithFormat:@"%@=%@&",sKey,[self objectForKey:sKey]]];
        }
        return resultString;
    }
    
}

@end
