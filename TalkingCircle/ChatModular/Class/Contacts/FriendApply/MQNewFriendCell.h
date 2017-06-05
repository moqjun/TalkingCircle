//
//  MQNewFriendCell.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "EaseCommonTableViewCell.h"
@class ApplyEntity;

@protocol MQNewFriendCellDelegate <NSObject>
/* 添加朋友*/
- (void)friendCellAddFriendAtIndexPath:(NSIndexPath *)indexPath;

/* 接受添加朋友申请*/
- (void)friendCellAcceptFriendAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MQNewFriendCell : EaseCommonTableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) ApplyEntity *entityObject;
@property (nonatomic,strong) UILabel *arrowLabel;
@property (nonatomic,strong) UIButton *arrowBtn;

@property (nonatomic,assign) id<MQNewFriendCellDelegate> delegate;

+(instancetype) newFriendWithTableView:(UITableView *) tableView;

@end
