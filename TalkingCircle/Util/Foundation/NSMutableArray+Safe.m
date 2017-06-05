//
//  NSMutableArray+Safe.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/22.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "NSMutableArray+Safe.h"

@implementation NSMutableArray (Safe)

-(void) safeAddObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

-(void) safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    }
}

-(void) safeRemoveObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

-(void) safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < self.count && anObject) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

-(id) firstObject {
    if (self.count > 0) {
        return [self objectAtIndex:0];
    }
    return nil;
}

-(void) removeFirstObject {
    [self safeRemoveObjectAtIndex:0];
}

-(id) safeObjectAtIndex:(NSInteger)index{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}


@end
