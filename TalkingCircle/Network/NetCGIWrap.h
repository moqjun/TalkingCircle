//
//  NetCGIWrap.h
//  PADRP
//  
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetCGIDefine.h"

@interface NetCGIWrap : NSObject

@property(nonatomic, assign) NetRequestMethod requestMethod; //默认GET

@property (nonatomic, assign) NetResponseDataType responseDataType; // 返回数据格式类型
@property (nonatomic, assign) NetCGIChannelType  m_channelType;// 连接方式类型：短连接，长连接等
@property (atomic, assign) int m_functionId;// CGI的功能号

@property (atomic, strong) NSData *m_requestPb; // 请求对象
@property (atomic, strong) NSData *m_responsePb;// 返回对象

@property (atomic, assign) int  m_retryCount;// 重试次数
@property (atomic, assign) int  m_timeout;// 超时时间，单位秒

@property(nonatomic, strong) NSDictionary *param;  //参数dic
@property(nonatomic, strong) NSDictionary *ext;  //额外信息dic

- (void)reuse;

- (NSData*)rsaRequestData;

@end
