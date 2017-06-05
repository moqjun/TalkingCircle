//
//  MQMineViewController.m
//  iOSAppTemplate
//
//  Created by h1r0 on 15/9/18.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "MQMineViewController.h"
#import "MQMineDetailViewController.h"

#import "MQSettingViewController.h"
#import "MQPartnerViewController.h"
#import "MQBillViewController.h"
#import "MQTaoPayController.h"
#import "UserProfileManager.h"

#import "MQUserInformationModel.h"

#import "MQUserDetailCell.h"
#import "MQVipMoneyCell.h"
#import "MQUserHelper.h"
#import "MQUIHelper.h"

@interface MQMineViewController ()<MQVipMoneyCellDelegate>

@property (nonatomic,strong) MQUserInformationModel *currentUserInfo;

@end

@implementation MQMineViewController

#pragma mark - Life Cycle
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setHidesBottomBarWhenPushed:NO];
    
    [self.tableView registerClass:[MQUserDetailCell class] forCellReuseIdentifier:@"UserDetailCell"];
    
    [self initTestData];
}


- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data ? self.data.count + 1 : 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    MQSettingGrounp *group = [self.data objectAtIndex:section - 1];
    return group.itemsCount;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
        {
            MQUserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailCell"];
            
            [cell setUser:_user];
            [cell setCellType:UserDetailCellTypeMine];
            [cell setBackgroundColor:[UIColor whiteColor]];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setTopLineStyle:CellLineStyleFill];
            [cell setBottomLineStyle:CellLineStyleFill];
            
            return cell;
        }
        else
        {
            MQVipMoneyCell *cell =[MQVipMoneyCell vipMoneyWithTableView:tableView];
            cell.money = self.currentUserInfo.money;
            cell.delegate = self;
            return cell;
        }
       
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]];
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0)
        {
            return 90.0f;
        }
        return 50.0f;
    }
    return [super tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
         return [super tableView:tableView heightForFooterInSection:0];
    }
    return [super tableView:tableView heightForFooterInSection:section - 1];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id vc = nil;
    if (indexPath.section == 0 && indexPath.row == 0) {     // 个人信息
        MQMineDetailViewController* mineDetailVC = [[MQMineDetailViewController alloc] init];
        mineDetailVC.userModel = self.currentUserInfo;
        
        vc = mineDetailVC;
    }
    else if (indexPath.section != 0){
        MQSettingGrounp *group = [self.data objectAtIndex:indexPath.section - 1];
        MQSettingItem *item = [group itemAtIndex: indexPath.row];
        if ([item.title isEqualToString:@"账单"]) {
//            vc = [[MQExpressionViewController alloc] init];
             vc = [[MQBillViewController alloc] init];
        }else if ([item.title isEqualToString:@"淘支付"]) {
            vc = [[MQTaoPayController alloc] init];
        }
        else if ([item.title isEqualToString:@"我的合伙人"]) {
            vc = [[MQPartnerViewController alloc] init];
        }
        else if ([item.title isEqualToString:@"设置"]) {
            vc = [[MQSettingViewController alloc] init];
        }
    }
    if (vc != nil) {
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Private Methods
- (void) initTestData
{
    [self doGetUserInformation];
    
    self.data = [MQUIHelper getMineVCItems];
    
    _user = [MQUserHelper sharedUserHelper].user;
    UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:[[EMClient sharedClient] currentUsername]];
    if(profileEntity == nil)
    {
        _user.username = [[EMClient sharedClient] currentUsername];

    }
    else
    {
        _user.username = profileEntity.username;
        _user.userID = profileEntity.objectId;
        _user.avatarURL = profileEntity.imageUrl;

    }
    
    [self.tableView reloadData];
}

-(void) doGetUserInformation
{
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_UserInformation;
 
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        
        if (!err)
        {
            NSString *userStr =[responseData objectForKey:@"data"];
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            
            NSDictionary *dict = [jsonParser objectWithString:userStr];
            MQUserInformationModel *userModel =[MQUserInformationModel userInfoWithDictionary:dict];
            self.currentUserInfo = userModel;
            
            [EaseCommonUserDefault setObjectModel:[userModel dictionaryWithInit] forKey:EASE_USER_INFORMATION];
            
            NSLog(@"dict:%@",dict);
        }
    }];
}

#pragma mark MQVipMoneyCellDelegate

-(void) handleContentViewClickEvent:(NSInteger)clickViewTag
{
    NSLog(@"clickViewTag:%ld",clickViewTag);
}

@end
