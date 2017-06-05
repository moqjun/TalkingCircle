//
//  NSMutableDictionary+Safe.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/22.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

-(void) safeSetObject:(id)anObject forKey:(id)aKey {
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }
}

-(void) safeRemoveObjectForKey:(id)aKey {
    if (aKey) {
        [self removeObjectForKey:aKey];
    }
}

-(void) dBSafeSetObject:(id)anObject forKey:(id)aKey {
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
    else{
        if ([anObject isKindOfClass:[NSString class]]) {
            [self setObject:@"" forKey:aKey];
        }else if ([anObject isKindOfClass:[NSData class]]){
            NSData* dtValue = [[NSData alloc] init];
            [self setObject:dtValue forKey:aKey];
        }else{
            [self setObject:[NSNull null] forKey:aKey];
        }
    }
    
}
@end
