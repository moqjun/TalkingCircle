//
//  MQNewFriendCell.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQNewFriendCell.h"
#import "InvitationManager.h"

@interface MQNewFriendCell()



@end

@implementation MQNewFriendCell

-(UIButton *)arrowBtn
{
    if (_arrowBtn == nil)
    {
        _arrowBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
        _arrowBtn.layer.cornerRadius = 3.0;
        [_arrowBtn setTitle:@"接受" forState:UIControlStateNormal];
        [_arrowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_arrowBtn setBackgroundColor:[UIColor colorWithHexString:@"2087fc"]];
        [_arrowBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}

-(UILabel *)arrowLabel
{
    if (_arrowLabel == nil)
    {
        _arrowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        _arrowLabel.text = @"已添加";
        _arrowLabel.textColor = [UIColor lightGrayColor];
        _arrowLabel.textAlignment = NSTextAlignmentCenter;
        _arrowLabel.font = [UIFont systemFontOfSize:13];
    }
    return _arrowLabel;
}

+(instancetype) newFriendWithTableView:(UITableView *)tableView
{
    static NSString *identifer =@"newFriend";
    MQNewFriendCell *cell =[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell = [[MQNewFriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    return cell;
}

-(void) setEntityObject:(ApplyEntity *)entityObject
{
    _entityObject = entityObject;
    
    self.textLabel.text = entityObject.applicantUsername;
    self.imageView.image = [UIImage imageNamed:@"ic_head"];
    
    self.detailTextLabel.text = entityObject.reason;
    if (entityObject.hasAccept)
    {
        self.accessoryView = self.arrowLabel;
    }
    else
    {
        self.accessoryView = self.arrowBtn;
    }
    
}

-(void) clickEvent:(UIButton *) btn
{
   
    if ([self.delegate respondsToSelector:@selector(friendCellAcceptFriendAtIndexPath:)]) {
        
        [self.delegate friendCellAcceptFriendAtIndexPath:self.indexPath];
    }
    
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
