//
//  NetCGIService.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "NetCGIService.h"
#import "NetCGIConfig.h"
#import "NetManager.h"
#import "NetCGI.h"

@interface NetCGIService ()

@property(nonatomic, strong) NSLock *m_lock;
@property(nonatomic, strong) NSMutableDictionary *m_cgiDic;

@end

@implementation NetCGIService


+ (instancetype)shareInstance
{
    static NetCGIService *netService = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        netService = [[NetCGIService alloc] init];
    });
    return netService;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.m_lock = [[NSLock alloc] init];
        self.m_cgiDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}


- (unsigned int)requestCGI:(NetCGIWrap *)cgiWrap callBack:(NetServiceCallBack)callBack
{
    if (nil == cgiWrap) {
        NSLog(@"ReqestCGI, invalid parameter!");
        return kInvalidSessionId;
    }
    
    
    const int functionId = cgiWrap.m_functionId;
    NetCGIItem *item = [NetCGIConfig findItemWithFunc:functionId];
    if (NULL == item) {
        NSLog(@"RequestCGI, no CGI config item! funcId=%d", functionId);
        return kInvalidSessionId;
    }
    
    
    NetCGI *cgi = [[NetCGI alloc] initWithItem:item];
    cgi.m_cgiWrap = cgiWrap;
    cgi.callBack = callBack;
    
    const unsigned int sessionId = cgi.m_sessionId;
    
    [self addCGI:cgi];
    [[NetManager shareInstance] startTask:cgi];
    
    return sessionId;
}


- (BOOL)IsCGIRunning:(UInt32) uiFuncID
{
    return [self findCGIByFuncID:uiFuncID];
}

- (void)addCGI:(NetCGI *)cgi
{
    if (!cgi) {
        return;
    }
    
    [self.m_lock lock];
    
    [_m_cgiDic setObject:cgi forKey:[NSNumber numberWithInt:cgi.m_sessionId]];
    
    [self.m_lock unlock];
}

- (NetCGI *)findCGI:(unsigned int)sessionId
{
    NetCGI *cgi = nil;
    [self.m_lock lock];
    
    cgi = [_m_cgiDic objectForKey:[NSNumber numberWithInt:sessionId]];
    
    [self.m_lock unlock];
    
    return cgi;
}

- (BOOL)findCGIByFuncID:(int)uiFuncID
{
    [self.m_lock lock];
    
    for (int i = 0; i < _m_cgiDic.allKeys.count; i ++) {
        NetCGI *cgi = [_m_cgiDic objectForKey:[_m_cgiDic.allKeys objectAtIndex:i]];
        if (cgi.m_cgiWrap.m_functionId == uiFuncID) {
            return YES;
        }
    }
    [self.m_lock unlock];
    return NO;
}

- (void)eraseCGI:(unsigned int)sessionId
{
    [self.m_lock lock];
    
    [_m_cgiDic removeObjectForKey:[NSNumber numberWithInt:sessionId]];
    
    [self.m_lock unlock];
}


@end
