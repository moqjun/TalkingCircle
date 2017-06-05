//
//  MQAddNewAddressController.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQAddressModel.h"

typedef void(^AddNewAddressBlock)(MQAddressModel *addressModel);


@interface MQAddNewAddressController : UITableViewController

@property (nonatomic,assign) BOOL isEditAddress;

@property (nonatomic,strong) MQAddressModel *addressModel;

@property (nonatomic,strong) AddNewAddressBlock addressBlock;

@end
