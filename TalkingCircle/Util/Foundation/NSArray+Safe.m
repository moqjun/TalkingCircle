//
//  NSArray+Safe.m
//  PADRP
//
//  Created by 赵远(平安科技集团运营管理部智能运营平台组) on 17/3/23.
//  Copyright © 2017年 容灾规划支持组. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

-(id) safeObjectAtIndex:(NSInteger)index{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}

@end
