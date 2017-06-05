//
//  MQAddNewAddressCell.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQAddressModel;

@interface MQAddNewAddressCell : UITableViewCell

@property (nonatomic,strong) MQAddressModel *addressModel;

+(instancetype) addNewAddressWithTableView:(UITableView *) tableView;

@end
