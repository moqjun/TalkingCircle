//
//  NSMutableDictionary+Safe.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/22.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safe)

-(void) safeSetObject:(id)anObject forKey:(id)aKey;

-(void) safeRemoveObjectForKey:(id)aKey;

-(void) dBSafeSetObject:(id)anObject forKey:(id)aKey;

@end
