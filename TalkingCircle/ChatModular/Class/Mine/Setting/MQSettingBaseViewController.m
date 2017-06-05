//
//  MQSettingBaseViewController.h.m
//  iOSAppTemplate
//
//  Created by libokun on 15/11/22.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "MQSettingBaseViewController.h"
#import "MQSettingCell.h"
#import "MQSettingHeaderFooteFView.h"

@implementation MQSettingBaseViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)]];

    [self.tableView registerClass:[MQSettingCell class] forCellReuseIdentifier:@"MQSettingCell"];
    [self.tableView registerClass:[MQSettingHeaderFooteFView class] forHeaderFooterViewReuseIdentifier:@"MQSettingHeaderFooteFView"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MQSettingGrounp *group = [_data objectAtIndex:section];
    return group.itemsCount;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQSettingGrounp *group = [_data objectAtIndex:indexPath.section];
    MQSettingItem *item = [group itemAtIndex:indexPath.row];
    MQSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MQSettingCell"];
    [cell setItem:item];
    
    // cell分割线
    if (item.type != MQSettingItemTypeButton) {
        indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleFill] : [cell setTopLineStyle:CellLineStyleNone];
        indexPath.row == group.itemsCount - 1 ? [cell setBottomLineStyle:CellLineStyleFill] : [cell setBottomLineStyle:CellLineStyleDefault];
    }
    else {
        [cell setTopLineStyle:CellLineStyleNone];
        [cell setBottomLineStyle:CellLineStyleNone];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MQSettingHeaderFooteFView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MQSettingHeaderFooteFView"];
    if (_data && _data.count > section) {
        MQSettingGrounp *group = [_data objectAtIndex:section];
        [view setText:group.headerTitle];
    }
    return view;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MQSettingHeaderFooteFView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MQSettingHeaderFooteFView"];
    if (_data && _data.count > section) {
        MQSettingGrounp *group = [_data objectAtIndex:section];
        [view setText:group.footerTitle];
    }
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_data && _data.count > indexPath.section) {
        MQSettingGrounp *group = [_data objectAtIndex:indexPath.section];
        MQSettingItem *item = [group itemAtIndex:indexPath.row];
        return [MQSettingCell getHeightForText:item];
    }
    return 0.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_data && _data.count > section) {
        MQSettingGrounp *group = [_data objectAtIndex:section];
        if (group.headerTitle == nil) {
            return section == 0 ? 15.0f : 10.0f;
        }
        return [MQSettingHeaderFooteFView getHeightForText:group.headerTitle];
    }
    return 10.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_data && _data.count > section) {
        MQSettingGrounp *group = [_data objectAtIndex:section];
        if (group.footerTitle == nil) {
            return section == _data.count - 1 ? 30.0f : 10.0f;
        }
        return [MQSettingHeaderFooteFView getHeightForText:group.footerTitle];
    }
    return 10.0f;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
}


@end
