//
//  MQAddNewAddressCell.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQAddNewAddressCell.h"
#import "MQAddressModel.h"

@interface MQAddNewAddressCell()<UITextFieldDelegate>

@property (nonatomic,weak) UILabel *titleLable;

@property (nonatomic,weak) UITextField *textfield;

@end

@implementation MQAddNewAddressCell

+(instancetype) addNewAddressWithTableView:(UITableView *) tableView
{
    static NSString *identifer =@"";
    MQAddNewAddressCell *cell =[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell = [[MQAddNewAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *label =[[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        self.titleLable = label;
        
        UITextField *field =[[UITextField alloc] init];
        field.font =[UIFont systemFontOfSize:15];
        field.textAlignment =NSTextAlignmentRight;
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.delegate = self;
        self.textfield = field;
        
        [self.contentView addSubview:label];
        [self.contentView addSubview:field];
    }
    return self ;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height =self.frame.size.height;
    if(height>44.0f)
    {
        height = 44.0f;
        
    }
    CGFloat width = 80;
    CGFloat xx = 15.0;
    self.titleLable.frame = CGRectMake(xx, 0, width, height);
    
    self.textfield.frame = CGRectMake(xx+width+5, 0, WIDTH_SCREEN-(xx+width+15), height);
}

-(void) setAddressModel:(MQAddressModel *)addressModel
{
    _addressModel = addressModel;
    
    self.titleLable.text = addressModel.title;
    self.textfield.placeholder = addressModel.placeholder;
    
}

#pragma mark UITextFieldDelegate

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    self.addressModel.fieldText = textField.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
