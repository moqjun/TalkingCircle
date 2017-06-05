//
//  MQUserHelper.h
//  iOSAppTemplate
//
//  Created by 莫强军 on 15/10/19.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQUser.h"

@interface MQUserHelper : NSObject

@property (nonatomic, strong) MQUser *user;

+ (MQUserHelper *)sharedUserHelper;

@end
