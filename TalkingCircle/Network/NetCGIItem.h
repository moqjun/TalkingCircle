//
//  NetCGIItem.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetCGIDefine.h"

@interface NetCGIItem : NSObject

@property(nonatomic, assign) int functionId;

@property(nonatomic, strong) NSString *cgiName;

@property(nonatomic, strong) NSString *cgiUrl;

@property(nonatomic, assign) NetCGIEncryptDecryptType requestEncryptType;

@property(nonatomic, assign) NetCGIChannelType channelType;


- (instancetype)initWithFuncId:(int)functionId
                       cgiName:(NSString*)cgiName
                       cgiUrl:(NSString*)cgiUrl
                   decryptType:(NetCGIEncryptDecryptType)requestEncryptType
                   channelType:(NetCGIChannelType)channelType;


- (NSString*)requestUrl;

@end
