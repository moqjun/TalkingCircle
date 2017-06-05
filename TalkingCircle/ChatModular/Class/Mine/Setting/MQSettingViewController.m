//
//  MQSettingViewController.m
//  iOSAppTemplate
//
//  Created by 莫强军 on 15/9/30.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "MQSettingViewController.h"
#import "MQNewsNotiViewController.h"
#import "MQPrivacyViewController.h"
#import "MQAccountSafeViewController.h"

#import "MQUIHelper.h"

@implementation MQSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"设置"];
    
    self.data = [MQUIHelper getSettingVCItems];
}


#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MQSettingGrounp *group = [self.data objectAtIndex:indexPath.section];
    MQSettingItem *item = [group itemAtIndex: indexPath.row];
    
    if ([item.title isEqualToString:@"新消息提醒"]) {
        MQNewsNotiViewController *newsNotiVC = [[MQNewsNotiViewController alloc] init];
        [self.navigationController pushViewController:newsNotiVC animated:YES];
    }
    else if ([item.title isEqualToString:@"隐私"])
    {
        MQPrivacyViewController *newsNotiVC = [[MQPrivacyViewController alloc] init];
        [self.navigationController pushViewController:newsNotiVC animated:YES];
    }
    else if ([item.title isEqualToString:@"账号安全"])
    {
        MQAccountSafeViewController *newsNotiVC = [[MQAccountSafeViewController alloc] init];
        [self.navigationController pushViewController:newsNotiVC animated:YES];
    }
    else if ([item.title isEqualToString:@"清空聊天记录"])
    {
        UIAlertController *alertController =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"点击取消按钮");
        }];
        
        UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
           NSLog(@"点击确定按钮");
        }];
        [okAction setValue:DEFAULT_MAIN_COLOR forKey:@"titleTextColor"];
        [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([item.title isEqualToString:@"退出"])
    {
        UIAlertController *alertController =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"点击取消按钮");
        }];
        
        UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"点击确定按钮");
            __weak MQSettingViewController *weakSelf = self;
            [self showHudInView:self.view hint:@"退出..."];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = [[EMClient sharedClient] logout:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf hideHud];
                    if (error != nil) {
                        [weakSelf showHint:error.errorDescription];
                    }
                    else{
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                    }
                });
            });

        }];
       
        [okAction setValue:DEFAULT_MAIN_COLOR forKey:@"titleTextColor"];
        [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
