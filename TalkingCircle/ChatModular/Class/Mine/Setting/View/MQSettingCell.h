//
//  MQSettingCell.h
//  iOSAppTemplate
//
//  Created by libokun on 15/11/22.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "MQSetting.h"

@interface MQSettingCell : CommonTableViewCell

@property (nonatomic, strong) MQSettingItem *item;

+ (CGFloat) getHeightForText:(MQSettingItem *)item;

@end
