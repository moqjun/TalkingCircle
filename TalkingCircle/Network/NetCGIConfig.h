//
//  NetCGIConfig.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetCGIItem.h"

@interface NetCGIConfig : NSObject

+ (NetCGIItem *)findItemWithFunc:(const int)funcId;

@end
