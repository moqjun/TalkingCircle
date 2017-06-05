//
//  NetCGIItem.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "NetCGIItem.h"

@implementation NetCGIItem

- (instancetype)initWithFuncId:(int)functionId
                       cgiName:(NSString*)cgiName
                        cgiUrl:(NSString*)cgiUrl
                   decryptType:(NetCGIEncryptDecryptType)requestEncryptType
                   channelType:(NetCGIChannelType)channelType
{
    self = [super init];
    if (self) {
        self.functionId = functionId;
        self.cgiName = cgiName;
        self.cgiUrl = cgiUrl;
        self.requestEncryptType = requestEncryptType;
        self.channelType = channelType;
    }
    return self;
}

- (NSString*)requestUrl
{
   
  return [NSString stringWithFormat:@"%@%@",self.cgiUrl,self.cgiName ? self.cgiName : @""];
    
}

@end
