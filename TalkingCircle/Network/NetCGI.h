//
//  NetCGI.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetCGIItem.h"
#import "NetCGIWrap.h"


typedef void(^NetServiceCallBack)(NSError *err, id responseData, NSDictionary *ext);


@interface NetCGI : NSObject


@property (nonatomic, assign) NetCGIItem  *m_item;

@property (nonatomic, strong) NetCGIWrap  *m_cgiWrap;

@property (nonatomic, assign, readonly) unsigned int m_sessionId;

@property (nonatomic, copy) NetServiceCallBack callBack;

- (id)init;

- (id)initWithItem:(NetCGIItem*)item;

@end
