//
//  BaseSelectCell.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/24.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonModel;

@interface BaseSelectCell : UITableViewCell

+(instancetype) baseSelectWithTableView:(UITableView *) tableView;

@property (nonatomic,strong) PersonModel *personModel;
@end
