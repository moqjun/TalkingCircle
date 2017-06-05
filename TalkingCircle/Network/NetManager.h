//
//  NetManager.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetCGI.h"

@interface NetManager : NSObject

+ (instancetype)shareInstance;

- (void)startTask:(NetCGI*)cgi;

@end
