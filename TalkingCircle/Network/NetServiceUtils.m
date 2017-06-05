//
//  NetServiceUtils.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "NetServiceUtils.h"
#import "NetCGIService.h"

@interface NetServiceMaker ()

@end

@implementation NetServiceMaker

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cgiWrap = [[NetCGIWrap alloc] init];
    }
    return self;
    
}


@end

@implementation NetServiceUtils

+ (instancetype)shareInstance
{
    static NetServiceUtils *netServiceUtils = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        netServiceUtils = [[NetServiceUtils alloc] init];
    });
    return netServiceUtils;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (uint32_t)tcMakeRequestWithBuilder:(NetServiceBuilder)builder callBack:(NetServiceCallBack)callBack
{
    if (builder == nil) {
        return kInvalidSessionId;
    }
    NetServiceMaker *maker = [[NetServiceMaker alloc] init];
    builder(maker);
    
    NetCGIService *cgiService = [NetCGIService shareInstance];
    if (maker.isCheckCgiIsRunning && [cgiService IsCGIRunning:maker.cgiWrap.m_functionId]) {
        NSLog(@"wait for get resource cgi return");
        return kInvalidSessionId;
    }
    
    UInt32 m_cgiSessionId = [cgiService requestCGI:maker.cgiWrap callBack:callBack];
    if (m_cgiSessionId == kInvalidSessionId)
    {
        NSLog(@"batchget 失败");
    }
    NSLog(@"start get resource request");
   
    return m_cgiSessionId;
}


@end
