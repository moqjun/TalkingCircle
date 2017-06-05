//
//  BaseSelectCell.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/24.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "BaseSelectCell.h"
#import "PersonModel.h"

@interface BaseSelectCell()

@property (nonatomic,weak) UIImageView *headImageView;

@end

@implementation BaseSelectCell

+(instancetype) baseSelectWithTableView:(UITableView *) tableView
{
    static NSString *identifer = @"selectCell";
    BaseSelectCell *cell =[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell = [[BaseSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        
    }
    return cell;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageView.image = [UIImage imageNamed:@"check"];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        self.headImageView = imageV;
        
        [self.contentView addSubview:imageV];
        
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    
    CGRect textLabelRect =self.textLabel.frame;
    
    self.headImageView.frame = CGRectMake(self.imageView.x+self.imageView.width+5, self.height * 0.1, self.height * 0.8, self.height * 0.8);
    
    textLabelRect.origin.x =self.headImageView.x +self.headImageView.width + 5;
    self.textLabel.frame = textLabelRect;
}

-(void) setPersonModel:(PersonModel *)personModel
{
    _personModel = personModel;
    
    if (personModel.readOnly)
    {
        self.imageView.image = [UIImage imageNamed:@"close"];
    }
    else
    {
        if (personModel.checked)
        {
            self.imageView.image = [UIImage imageNamed:@"checked"];
        }
        else
        {
            self.imageView.image = [UIImage imageNamed:@"check"];
        }

    }
    
    
    
    self.textLabel.text = personModel.userName;
    self.headImageView.image = personModel.txicon;
    
}



@end
