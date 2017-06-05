//
//  ShortLinkManager.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "ShortLinkManager.h"
#import "NetCGIService.h"
#import "TCHTTPRequestSerializer.h"

@implementation ShortLinkManager

- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.requestSerializer = [TCHTTPRequestSerializer serializer];
    return self;
}

+ (void)shortLinkRequestStart:(NetCGI*)cgi
{
    
    if (cgi.m_cgiWrap.requestMethod == NetRequestMethod_GET) {
        [[ShortLinkManager manager] GET:cgi.m_item.requestUrl parameters:cgi.m_cgiWrap.param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSString *responseData = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            if (cgi.m_cgiWrap.responseDataType == NetResponseDataType_JSON) {
                NSDictionary *responseDic = [responseData JSONDictionary];
                if ([[responseDic objectForKey:@"status"] integerValue] == ServiceNetStatusCode_noLogin) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationNoLogin object:nil]; 
                    });
                    
                }
              cgi.callBack(nil,responseDic,cgi.m_cgiWrap.ext);
            }else{
              cgi.callBack(nil,responseData,cgi.m_cgiWrap.ext);
            }
            
            [[NetCGIService shareInstance] eraseCGI:cgi.m_sessionId];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            cgi.callBack(error,nil,cgi.m_cgiWrap.ext);
            [[NetCGIService shareInstance] eraseCGI:cgi.m_sessionId];
        }];
    }else if (cgi.m_cgiWrap.requestMethod == NetRequestMethod_POST)
    {
        if (cgi.m_item.requestEncryptType == NetCGI_ENCRYPT_DECRYPT_TYPE_RSA) {
           [[ShortLinkManager manager] POST:cgi.m_item.requestUrl httpBody:[cgi.m_cgiWrap rsaRequestData] progress:nil success:^(NSURLSessionDataTask *  _Nonnull task, id _Nonnull responseObject) {
               
               NSString *responseData = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
               if (cgi.m_cgiWrap.responseDataType == NetResponseDataType_JSON) {
                   NSDictionary *responseDic = [responseData JSONDictionary];
                   cgi.callBack(nil,responseDic,cgi.m_cgiWrap.ext);
               }else{
                   cgi.callBack(nil,responseData,cgi.m_cgiWrap.ext);
               }
               
               [[NetCGIService shareInstance] eraseCGI:cgi.m_sessionId];
               
           } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
               
               cgi.callBack(error,nil,cgi.m_cgiWrap.ext);
               [[NetCGIService shareInstance] eraseCGI:cgi.m_sessionId];
               
           }];
        }else{
            [[ShortLinkManager manager] POST:cgi.m_item.requestUrl parameters:cgi.m_cgiWrap.param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *responseData = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                if (cgi.m_cgiWrap.responseDataType == NetResponseDataType_JSON) {
                    NSDictionary *responseDic = [responseData JSONDictionary];
                    cgi.callBack(nil,responseDic,cgi.m_cgiWrap.ext);
                }else{
                    cgi.callBack(nil,responseData,cgi.m_cgiWrap.ext);
                }
                
                [[NetCGIService shareInstance] eraseCGI:cgi.m_sessionId];
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                cgi.callBack(error,nil,cgi.m_cgiWrap.ext);
                [[NetCGIService shareInstance] eraseCGI:cgi.m_sessionId];
            }];
        }
        
    }
    
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                      httpBody:(NSData*)body
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST" URLString:URLString httpBody:body uploadProgress:uploadProgress downloadProgress:nil success:success failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}


- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                        httpBody:(NSData*)body
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
    mutableRequest.HTTPMethod = method;
    
//    if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
//        [mutableRequest setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
//        [mutableRequest setValue:@"*/*" forHTTPHeaderField:@"Accept"];
//        [mutableRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
//        [mutableRequest setValue:[NSString stringWithFormat:@"%zd",body.length] forHTTPHeaderField:@"Content-Length"];
//    }
    
    [mutableRequest setTimeoutInterval:30];
    [mutableRequest setHTTPBody:body];
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:mutableRequest
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (error) {
                               if (failure) {
                                   failure(dataTask, error);
                               }
                           } else {
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                       }];
    
    return dataTask;
}


@end
