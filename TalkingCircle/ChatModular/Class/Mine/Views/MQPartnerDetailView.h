//
//  MQPartnerDetailView.h
//  TalkingCircle
//
//  Created by iMac on 2017/5/2.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQPartnerModel;

@interface MQEarningsView : UIView

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;

@end

@interface MQPartnerDetailView : UIView

@property (nonatomic,strong) MQPartnerModel *partnerModel;

+(UILabel *) creatLabel:(NSString*) text fontSize:(CGFloat)fontSize textColor:(UIColor*)color rect:(CGRect) rect;
@end
