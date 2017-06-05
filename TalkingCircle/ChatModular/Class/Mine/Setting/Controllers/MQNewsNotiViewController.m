//
//  MQNewsNotiViewController.m
//  iOSAppTemplate
//
//  Created by libokun on 15/9/30.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "MQNewsNotiViewController.h"
#import "MQUIHelper.h"


@implementation MQNewsNotiViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"新消息提醒"];
     self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    self.data = [MQUIHelper getNewNotiVCItems];
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MQSettingGrounp *group = [_data objectAtIndex:indexPath.section];
//    MQSettingItem *item = [group itemAtIndex: indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
