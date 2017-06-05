//
//  NetManager.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "NetManager.h"
#import "ShortLinkManager.h"

@implementation NetManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static NetManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc]init];
    });
    return instance;
}

- (void)startTask:(NetCGI*)cgi
{
//    if (cgi.m_item.channelType == NetCGI_CHANNEL_TYPE_LONG) {
//        
//    }
    
    //现在只支持短链
    [ShortLinkManager shortLinkRequestStart:cgi];
}

@end
