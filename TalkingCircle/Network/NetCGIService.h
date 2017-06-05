//
//  NetCGIService.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetCGI.h"

@interface NetCGIService : NSObject

+ (instancetype)shareInstance;

- (unsigned int)requestCGI:(NetCGIWrap *)cgiWrap callBack:(NetServiceCallBack)callBack;

- (BOOL)IsCGIRunning:(UInt32)uiFuncID;

- (void)addCGI:(NetCGI *)cgi;

- (NetCGI *)findCGI:(unsigned int)sessionId;

- (BOOL)findCGIByFuncID:(int)uiFuncID;

- (void)eraseCGI:(unsigned int)sessionId;

@end
