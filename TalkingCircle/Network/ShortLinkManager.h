//
//  ShortLinkManager.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "NetCGI.h"

@interface ShortLinkManager : AFHTTPSessionManager

+ (void)shortLinkRequestStart:(NetCGI*)cgi;

@end
