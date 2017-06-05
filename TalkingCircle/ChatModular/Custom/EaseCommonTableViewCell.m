//
//  CommonTableViewCell.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/20.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "EaseCommonTableViewCell.h"

@implementation EaseCommonTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat mScale = 0.9;
    CGRect frame = self.bounds;
    
    CGRect imageViewRect = self.imageView.frame;
    
    imageViewRect.origin.y =(frame.size.height *(1-mScale))/2;
    imageViewRect.size = CGSizeMake(frame.size.height *mScale, frame.size.height *mScale);
    
    self.imageView.frame = imageViewRect;
    
    self.textLabel.font = [UIFont systemFontOfSize:17];
    self.detailTextLabel.textColor =[UIColor colorWithHexString:@"555"];
    self.detailTextLabel.font = [UIFont systemFontOfSize:15];
    
    //textlabel
    CGRect textLabelRect = self.textLabel.frame;
    textLabelRect.origin.x -=5;
    textLabelRect.origin.y -=4;
    self.textLabel.frame = textLabelRect;
    
    //detailTextLabel
    CGRect detailLabelRect = self.detailTextLabel.frame;
    detailLabelRect.origin.x -=5;
    detailLabelRect.origin.y +=4;
    detailLabelRect.size.width = WIDTH_SCREEN -detailLabelRect.origin.x;
    self.detailTextLabel.frame = detailLabelRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
