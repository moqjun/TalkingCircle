//
//  TCUserLoginInfo.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/16.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCUserLoginInfo : NSObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passwordMd5;
@property (nonatomic, copy) NSString *aesKey;

@property (nonatomic, copy) NSString *huanxinUserName;
@property (nonatomic, copy) NSString *huanxinPassword;



+ (instancetype)shareInstance;

- (void)updateToken:(NSString*)token;


- (void)updateUserName:(NSString*)userName;

- (void)updatePasswordMd5:(NSString*)passwordMd5;

- (void)updateAesKey:(NSString*)newAesKey;

@end
