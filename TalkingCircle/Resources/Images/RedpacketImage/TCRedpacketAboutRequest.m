//
//  TCRedpacketAboutRequest.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/5/1.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCRedpacketAboutRequest.h"

@implementation TCRedpacketAboutRequest


- (void)sendPersonalRedpacketWithUserId:(NSString*)userId amount:(NSString*)amount callBack:(NetServiceCallBack)callBack
{
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_SendRedpacket;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic safeSetObject:userId forKey:@"to_user"];
        [dic safeSetObject:amount forKey:@"amount"];
        maker.cgiWrap.param = dic;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        if (callBack) {
            callBack(err, responseData, ext);
        }
    }];
}

- (void)sendGroupRedpacketWithNum:(NSString*)num amount:(NSString*)amount callBack:(NetServiceCallBack)callBack
{
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_SendRedpacket;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic safeSetObject:num forKey:@"num"];
        [dic safeSetObject:amount forKey:@"amount"];
        maker.cgiWrap.param = dic;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        if (callBack) {
            callBack(err, responseData, ext);
        }
    }];
}


- (void)openRedpacketWithId:(NSString*)orderId callBack:(NetServiceCallBack)callBack
{
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_ReceiveRedpacket;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic safeSetObject:orderId forKey:@"order_id"];
        maker.cgiWrap.param = dic;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        if (callBack) {
            callBack(err, responseData, ext);
        }
    }];
}


- (void)redpacketStatusWithId:(NSString*)orderId callBack:(NetServiceCallBack)callBack
{
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_RedpacketStatus;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic safeSetObject:orderId forKey:@"order_id"];
        maker.cgiWrap.param = dic;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        if (callBack) {
            callBack(err, responseData, ext);
        }
    }];
}

@end
