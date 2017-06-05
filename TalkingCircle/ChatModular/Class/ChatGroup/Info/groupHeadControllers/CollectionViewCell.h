//
//  CollectionViewCell.h
//  testTX
//
//  Created by hackxhj on 15/9/7.
//  Copyright (c) 2015年 hackxhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewCellDelagate <NSObject>

-(void)clickImg:(UITapGestureRecognizer *)recognizer;
-(void)delclick:(id)sender;

@end
@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (assign, nonatomic) CGFloat  imageViewCornerRadius;

@property(nonatomic,weak)id<CollectionViewCellDelagate>delagate;
@end
