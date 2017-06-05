//
//  MQVipMoneyCell.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/20.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQVipMoneyCell.h"

@interface MQImageLabelView()

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) UILabel *textLabel;

@end

@implementation MQImageLabelView

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        self.imageView = imageV;
        
        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
        label.font = [UIFont systemFontOfSize:15];
        
        self.textLabel = label;
        
        [self addSubview:imageV];
        [self addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapEvent:)];
        tap.numberOfTouchesRequired = 1;
        
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    CGSize size =[self.labelTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGFloat width = 25+5+size.width;
    CGFloat xx =(self.frame.size.width -width)/2;
    CGFloat yy =(self.frame.size.height - 25)/2;
    self.imageView.frame = CGRectMake(xx, yy, 25, 25);
    self.textLabel.frame = CGRectMake(xx+30, yy, size.width, 25);
    
}

-(void) setImageName:(NSString *)imageName title:(NSString *)labelTitle
{
    _labelTitle = labelTitle;
    self.imageView.image =[UIImage imageNamed:imageName];
    self.textLabel.text = labelTitle;
}

-(void) setLabelTitle:(NSString *)labelTitle
{
    _labelTitle = labelTitle;
    self.textLabel.text = labelTitle;
}

-(void) onTapEvent:(UITapGestureRecognizer *) tapGest
{
    if ([self.delegate respondsToSelector:@selector(handleCurrentViewClickEvent:)])
    {
        [self.delegate handleCurrentViewClickEvent:self.tag];
    }
}


@end

@interface MQVipMoneyCell()<MQImageLabelViewDelegate>

@property (nonatomic,weak) MQImageLabelView *moneyView;

@property (nonatomic,weak) MQImageLabelView *vipView;

@end

@implementation MQVipMoneyCell

+(instancetype) vipMoneyWithTableView:(UITableView *) tableView
{
    static NSString *identifer = @"vipMoneyCell";
    MQVipMoneyCell *cell =[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell =[[MQVipMoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        MQImageLabelView *mView = [[MQImageLabelView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN/2, self.bounds.size.height)];
        [mView setImageName:@"balance" title:@"¥1080"];
        mView.delegate = self;
        self.moneyView = mView;
        
         MQImageLabelView *vView = [[MQImageLabelView alloc] initWithFrame:CGRectMake(WIDTH_SCREEN/2, 0, WIDTH_SCREEN/2, self.bounds.size.height)];
        [vView setImageName:@"rank" title:@"VIP3"];
        vView.tag = 1;
        vView.delegate = self;
        self.vipView = vView;
        
        CGFloat height = self.bounds.size.height;
        UILabel *line =[[UILabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN/2, height*0.2, 1, height*0.6)];
        line.backgroundColor =[UIColor colorWithHexString:@"e2e2e2"];
        
        [self.contentView addSubview:mView];
        [self.contentView addSubview:vView];
        [self.contentView addSubview:line];
    }
    
    return self;
}

-(void) setMoney:(NSString *)money
{
    _money = money;
    if (money == nil || !money.length)
    {
        money = @"¥0";
    }
    else
    {
        money = [@"¥" stringByAppendingString:money];
    }
    [self.moneyView setLabelTitle:money];
}

#pragma mark MQImageLabelViewDelegate

-(void) handleCurrentViewClickEvent:(NSInteger)currentViewTag
{
    
    if ([self.delegate respondsToSelector:@selector(handleContentViewClickEvent:)])
    {
        [self.delegate handleContentViewClickEvent:currentViewTag];
    }
}

@end
