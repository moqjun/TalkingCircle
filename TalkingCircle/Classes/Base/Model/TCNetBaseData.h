//
//  TCNetBaseData.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/29.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCNetBaseData : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, copy) NSString *randomString;

+ (TCNetBaseData*)initWithJsonDic:(NSDictionary*)responseDic;

- (NSString*)aesKeyWithRandomAESKey:(NSString*)randomAESKey;


@end
