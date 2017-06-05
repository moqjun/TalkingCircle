//
//  MQVipMoneyCell.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/20.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MQImageLabelViewDelegate <NSObject>

-(void) handleCurrentViewClickEvent:(NSInteger) currentViewTag;

@end

@interface MQImageLabelView : UIView
@property (nonatomic,strong) NSString *labelTitle;

@property (nonatomic,assign) id<MQImageLabelViewDelegate> delegate;

-(void)setImageName:(NSString *) imageName title:(NSString *) labelTitle;

@end


@protocol MQVipMoneyCellDelegate <NSObject>

-(void) handleContentViewClickEvent:(NSInteger) clickViewTag;

@end

@interface MQVipMoneyCell : UITableViewCell

@property (nonatomic,assign) id<MQVipMoneyCellDelegate> delegate;

@property (nonatomic,strong) NSString *money;

+(instancetype) vipMoneyWithTableView:(UITableView *) tableView;

@end
