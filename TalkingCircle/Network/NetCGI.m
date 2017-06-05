//
//  NetCGI.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "NetCGI.h"

@interface NetCGI ()

@property (nonatomic, assign) unsigned int  m_sessionId;

@end

@implementation NetCGI

+ (unsigned int)genSessionId
{
    static unsigned int sid = 0U;
    
    @synchronized(@"NetCGI_GEN_SESSION_ID")
    {
        ++sid;
        if (kInvalidSessionId == sid) {
            ++sid;
        }
        return sid;
    }
}

- (id)initWithItem:(NetCGIItem*)item {
    self = [super init];
    if (self) {
        self.m_sessionId = [NetCGI genSessionId];
        
        assert(item != NULL);
        self.m_item = item;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.m_sessionId = [NetCGI genSessionId];
    }
    return self;
}


@end
