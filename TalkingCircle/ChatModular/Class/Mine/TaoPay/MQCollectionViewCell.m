//
//  CollectionViewCell.m
//  collectionView
//
//  Created by shikee_app05 on 14-12-10.
//  Copyright (c) 2014年 shikee_app05. All rights reserved.
//

#import "MQCollectionViewCell.h"

@implementation MQCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 38)];
        self.imgView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imgView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 20)];
        self.text.backgroundColor = [UIColor clearColor];
        self.text.font = [UIFont systemFontOfSize:14];
        self.text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.text];
        
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect imageViewRect = self.imgView.frame;
    CGRect textRect = self.text.frame;
    
    CGFloat xx = (self.width-imageViewRect.size.width)/2;
    CGFloat yy = (self.height-imageViewRect.size.width-30)/2;
    
    imageViewRect.origin.x = xx;
    imageViewRect.origin.y = yy;
    
    textRect.origin.y = yy+imageViewRect.size.height+10;
    
    self.imgView.frame = imageViewRect;
    self.text.frame = textRect;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
