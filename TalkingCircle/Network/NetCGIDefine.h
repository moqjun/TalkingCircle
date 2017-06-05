//
//  NetCGIDefine.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#ifndef NetCGIDefine_h
#define NetCGIDefine_h

static const unsigned int kInvalidSessionId = 0U;

typedef NS_ENUM(NSInteger, NetCGIEncryptDecryptType)  {
    NetCGI_ENCRYPT_DECRYPT_TYPE_NONE = 0,
    NetCGI_ENCRYPT_DECRYPT_TYPE_AES = 1,
    NetCGI_ENCRYPT_DECRYPT_TYPE_RSA = 2
};

typedef NS_ENUM(NSInteger, NetCGIFlowLimit) {
    NetCGI_FLOW_LIMIT_NO = 0,
    NetCGI_FLOW_LIMIT_YES = 1
};

typedef NS_ENUM(NSInteger, NetCGIChannelType) {
    NetCGI_CHANNEL_TYPE_NONE = 0,
    NetCGI_CHANNEL_TYPE_LONG = 1,   //使用长链
    NetCGI_CHANNEL_TYPE_SHORT = 2,  //使用短链
    NetCGI_CHANNEL_TYPE_LONG_OR_SHORT = 3,   //使用长链或短链
    NetCGI_CHANNEL_TYPE_URL = 4,
    NetCGI_CHANNEL_TYPE_CDN = 5,
    NetCGI_CHANNEL_TYPE_USB = 6,
};

typedef NS_ENUM(NSInteger, NetRequestMethod) {
    NetRequestMethod_GET = 0,
    NetRequestMethod_POST = 1,
};

typedef NS_ENUM(NSInteger, NetResponseDataType) {
    NetResponseDataType_NONE = 0,
    NetResponseDataType_JSON = 1,
};

#endif /* NetCGIDefine_h */
