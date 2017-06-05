//
//  CollectionViewCell.m
//  testTX
//
//  Created by hackxhj on 15/9/7.
//  Copyright (c) 2015年 hackxhj. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * nibs=[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:self options:nil];
        for (id obj in nibs) {
            if ([obj isKindOfClass:[CollectionViewCell class]]) {
                self =(CollectionViewCell *)obj;
            }
        }
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    _imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickIMG:)];
    [_imageView addGestureRecognizer:gesture];
    
    _imageView.clipsToBounds=YES;
}

-(void) setImageViewCornerRadius:(CGFloat)imageViewCornerRadius
{
    _imageViewCornerRadius = imageViewCornerRadius;
    _imageView.layer.cornerRadius = imageViewCornerRadius;
}

-(void)clickIMG:(id)sender
{

    if ([self.delagate respondsToSelector:@selector(clickImg:)])
    {
         [self.delagate clickImg:sender];
    }
   
}


@end
