//
//  MQUIHelper.h
//  iOSAppTemplate
//
//  Created by 莫强军 on 15/9/24.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQSetting.h"

@interface MQUIHelper : NSObject

+ (MQSettingGrounp *) getFriensListItemsGroup;
/* */
+ (NSMutableArray *) getDiscoverItems;
/* */
+ (NSMutableArray *) getMineVCItems;
/* */
+ (NSMutableArray *) getDetailVCItems;
/* */
+ (NSMutableArray *) getDetailSettingVCItems;

/*获取个人详情的数据*/
+ (NSMutableArray *) getMineDetailVCItems;

/*获取设置界面的数据*/
+ (NSMutableArray *) getSettingVCItems;

/* 获取新消息提醒的数据*/
+ (NSMutableArray *) getNewNotiVCItems;

/* 获取隐私的数据*/
+ (NSMutableArray *) getPrivacyVCItems;

/* 获取账号安全的数据*/
+ (NSMutableArray *) getAccountSafeVCItems;

@end
