//
//  MQAccountSafeViewController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQAccountSafeViewController.h"
#import "MQUIHelper.h"

#import "MQEditPhoneController.h"
#import "MQEditPasswordController.h"
#import "MQBindEmailController.h"

@interface MQAccountSafeViewController ()

@end

@implementation MQAccountSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"账号安全"];
    
    self.data = [MQUIHelper getAccountSafeVCItems];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MQSettingGrounp *group = [self.data objectAtIndex:indexPath.section];
    MQSettingItem *item = [group itemAtIndex: indexPath.row];
    id controller = nil;
    if ([item.title isEqualToString:@"修改手机号"])
    {
        controller= [[MQEditPhoneController alloc] init];
    }
    else if ([item.title isEqualToString:@"修改密码"])
    {
        controller= [[MQEditPasswordController alloc] init];
    }
    else if ([item.title isEqualToString:@"绑定邮箱"])
    {
        controller= [[MQBindEmailController alloc] init];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
