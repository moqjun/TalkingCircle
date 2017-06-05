/*
 Copyright (C) 2009 Stig Brautaset. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
   to endorse or promote products derived from this software without specific
   prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "NSObject+SBJSON.h"
#import "SBJsonWriter.h"

@implementation NSObject (NSObject_SBJSON)

- (NSString *)JSONFragment {
    SBJsonWriter *jsonWriter = [SBJsonWriter new];
    NSString *json = [jsonWriter stringWithFragment:self];    
    if (!json)
        NSLog(@"-JSONFragment failed. Error trace is: %@", [jsonWriter errorTrace]);
//    [jsonWriter release];
    return json;
}

- (NSString *)JSONRepresentation {
    SBJsonWriter *jsonWriter = [SBJsonWriter new];    
    NSString *json = [jsonWriter stringWithObject:self];
    if (!json)
        NSLog(@"-JSONRepresentation failed. Error trace is: %@", [jsonWriter errorTrace]);
//    [jsonWriter release];
    return json;
}

@end

@implementation NSDictionary (NSDictionary_SafeJSON)
- (NSString *)stringForKey:(NSString *)key
{
    NSString* obj = [self objectForKey:key];
    if (![obj isKindOfClass:[NSString class]]) {
        return nil;
    }
    return obj;
}
- (NSArray *)arrayForKey:(NSString *)key
{
    NSArray* obj = [self objectForKey:key];
    if (![obj isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return obj;
}
- (NSDictionary *)dictionaryForKey:(NSString *)key
{
    NSDictionary* obj = [self objectForKey:key];
    if (![obj isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return obj;
}
- (NSInteger)integerForKey:(NSString *)key
{
    NSObject* o = [self objectForKey:key];
    if ([o isKindOfClass:[NSNumber class]]) {
        return [((NSNumber*)o) integerValue];
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [((NSString*)o) integerValue];
    }
    return 0;
}
- (float)floatForKey:(NSString *)key
{
    NSObject* o = [self objectForKey:key];
    if ([o isKindOfClass:[NSNumber class]]) {
        return [((NSNumber*)o) floatValue];
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [((NSString*)o) floatValue];
    }
    return 0;
}
- (double)doubleForKey:(NSString *)key
{
    NSObject* o = [self objectForKey:key];
    if ([o isKindOfClass:[NSNumber class]]) {
        return [((NSNumber*)o) doubleValue];
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [((NSString*)o) doubleValue];
    }
    return 0;
}
@end

@implementation NSArray (NSArray_SafeJSON)
-(NSObject*) mm_safe_objectAtIndex:(NSInteger)index
{
    if (0<=index && index<self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

/*- (id)firstObject {
	if(self.count>0) {
		return [self objectAtIndex:0];
	}
	return nil;
}*/

- (NSString *)stringAtIndex:(NSUInteger)index
{
    NSString* obj = (NSString*)[self mm_safe_objectAtIndex:index];
    if (![obj isKindOfClass:[NSString class]]) {
        return nil;
    }
    return obj;
}
- (NSArray *)arrayAtIndex:(NSUInteger)index
{
    NSArray* obj = (NSArray*)[self mm_safe_objectAtIndex:index];
    if (![obj isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return obj;
}
- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index
{
    NSDictionary* obj = (NSDictionary*)[self mm_safe_objectAtIndex:index];
    if (![obj isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return obj;
}
- (NSInteger)integerAtIndex:(NSUInteger)index
{
    NSObject* o = [self mm_safe_objectAtIndex:index];
    if ([o isKindOfClass:[NSNumber class]]) {
        return [((NSNumber*)o) integerValue];
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [((NSString*)o) integerValue];
    }
    return 0;
}
- (float)floatAtIndex:(NSUInteger)index
{
    NSObject* o = [self mm_safe_objectAtIndex:index];
    if ([o isKindOfClass:[NSNumber class]]) {
        return [((NSNumber*)o) floatValue];
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [((NSString*)o) floatValue];
    }
    return 0;
}
- (double)doubleAtIndex:(NSUInteger)index
{
    NSObject* o = [self mm_safe_objectAtIndex:index];
    if ([o isKindOfClass:[NSNumber class]]) {
        return [((NSNumber*)o) doubleValue];
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [((NSString*)o) doubleValue];
    }
    return 0;
}
@end
