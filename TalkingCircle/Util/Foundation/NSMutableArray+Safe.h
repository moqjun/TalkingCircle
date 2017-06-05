//
//  NSMutableArray+Safe.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/22.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)

-(void) safeAddObject:(id)anObject;
-(void) safeInsertObject:(id)anObject atIndex:(NSUInteger)index;
-(void) safeRemoveObjectAtIndex:(NSUInteger)index;
-(void) safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
-(id) firstObject;
-(void) removeFirstObject;
-(id) safeObjectAtIndex:(NSInteger)index;

@end
