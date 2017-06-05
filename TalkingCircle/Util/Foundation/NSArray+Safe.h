//
//  NSArray+Safe.h
//  PADRP
//
//  Created by 赵远(平安科技集团运营管理部智能运营平台组) on 17/3/23.
//  Copyright © 2017年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

-(id) safeObjectAtIndex:(NSInteger)index;

@end
