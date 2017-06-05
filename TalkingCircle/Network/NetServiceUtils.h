//
//  NetServiceUtils.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetCGI.h"
#import "NetFuncid.h"
/**
 *  请求载体类 用于配置
 */

@interface NetServiceMaker : NSObject

@property(nonatomic, strong) NetCGIWrap *cgiWrap;
@property(nonatomic, assign) BOOL isCheckCgiIsRunning;

@end

typedef void(^NetServiceBuilder)(NetServiceMaker *maker);

@interface NetServiceUtils : NSObject

+ (instancetype)shareInstance;

- (uint32_t)tcMakeRequestWithBuilder:(NetServiceBuilder)builder callBack:(NetServiceCallBack)callBack;

@end
