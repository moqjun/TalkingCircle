//
//  TCJSONRequestSerializer.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/16.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCHTTPRequestSerializer.h"
#import "TCUserLoginInfo.h"

@implementation TCHTTPRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error
{
    NSMutableURLRequest *request = [super requestWithMethod:method URLString:URLString parameters:parameters error:error];
    
    [request addValue:[TCUserLoginInfo shareInstance].token forHTTPHeaderField:@"token"];
    
    return request;
}
@end
