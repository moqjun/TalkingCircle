//
//  MQPartnerDetailView.m
//  TalkingCircle
//
//  Created by iMac on 2017/5/2.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQPartnerDetailView.h"
#import "MQPartnerModel.h"

@interface MQEarningsView()

@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UILabel *contentLabel;

@end

@implementation MQEarningsView

-(id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel *tLabel =[MQPartnerDetailView creatLabel:@"总收益" fontSize:13 textColor:[UIColor colorWithUInt:0xf4f4f4] rect:CGRectMake(0, 7, frame.size.width, 17)];
        self.titleLabel = tLabel;
        
        UILabel *cLabel =[MQPartnerDetailView creatLabel:@"4800" fontSize:15 textColor:[UIColor whiteColor] rect:CGRectMake(0, 26, frame.size.width, 20)];
        self.contentLabel = cLabel;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        
        self.backgroundColor =[UIColor colorWithUInt:0xffffff alpha:0.3];
        
    }
    return self;
}

-(void) setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

-(void) setContent:(NSString *)content
{
    _content = content;
    
    self.contentLabel.text = content;
}


@end

@interface MQPartnerDetailView()

@property (nonatomic,weak) UIImageView *imageView; //显示头像
@property (nonatomic,weak) UILabel *nameLabel; //显示名称
@property (nonatomic,weak) UILabel *noLabel;   //显示圈号
@property (nonatomic,weak) MQEarningsView *totalView;
@property (nonatomic,weak) MQEarningsView *detailView;

@end

@implementation MQPartnerDetailView

-(id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //用于显示标题
        
//        UILabel *titleLabel =[MQPartnerDetailView creatLabel:@"明细" fontSize:18 textColor:nil rect:CGRectMake(0, 32, WIDTH_SCREEN, 20)];
//        
//        [self addSubview:titleLabel];
        
        //
        CGFloat width = 65;
        CGFloat yy = 60;
        CGFloat xx = (WIDTH_SCREEN-width)/2;
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(xx, yy, width, width)];
        imageView.layer.cornerRadius = width/2;
        self.imageView = imageView;
        [self addSubview:imageView];
        
        //
        UILabel *nameLabel =[MQPartnerDetailView creatLabel:@"" fontSize:14 textColor:nil rect:CGRectMake(0, yy+width+5, WIDTH_SCREEN, 20)];
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        UILabel *noLabel =[MQPartnerDetailView creatLabel:@"" fontSize:14 textColor:[UIColor colorWithHexString:@"f5f5f5"] rect:CGRectMake(0, yy+width+30, WIDTH_SCREEN, 20)];
        self.noLabel = noLabel;
        [self addSubview:noLabel];
        
        //
        CGFloat viewY = yy+width+55;
        MQEarningsView *tView = [[MQEarningsView alloc] initWithFrame:CGRectMake(0, viewY, WIDTH_SCREEN/2, 50)];
        self.totalView = tView;
        [self addSubview:tView];
        
        //
        MQEarningsView *dView =[[MQEarningsView alloc] initWithFrame:CGRectMake(WIDTH_SCREEN/2, viewY, WIDTH_SCREEN/2, 50)];
        dView.title = @"近30天(元)";
        self.detailView = dView;
        [self addSubview:dView];
        
        self.backgroundColor = DEFAULT_MAIN_COLOR;
        
        
    }
    return self;
}

-(void) setPartnerModel:(MQPartnerModel *)partnerModel
{
    _partnerModel = partnerModel;
    
    self.imageView.image = [UIImage imageNamed:partnerModel.headIcon];
    self.nameLabel.text =partnerModel.name;
    self.noLabel.text = [NSString stringWithFormat:@"圈号：%@",partnerModel.circleNo];
}

+(UILabel *) creatLabel:(NSString*) text fontSize:(CGFloat)fontSize textColor:(UIColor*)color rect:(CGRect) rect
{
    UILabel *label =[[UILabel alloc] initWithFrame:rect];
    label.text = text;
    if (color == nil)
    {
        color = [UIColor whiteColor];
    }
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
