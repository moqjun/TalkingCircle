
//
//  MQMineDetailViewController.m
//  iOSAppTemplate
//
//  Created by 莫强军 on 15/9/30.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "MQMineDetailViewController.h"

#import "MQCertificationController.h"
#import "MQNicknameViewController.h"
#import "MQMyAddressController.h"
#import "MQCodeViewController.h"
#import "MQSexViewController.h"

#import "MQUserInformationModel.h"
#import "UserProfileManager.h"
#import "MQUIHelper.h"


@interface MQMineDetailViewController()<UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end

@implementation MQMineDetailViewController

- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.modalPresentationStyle= UIModalPresentationOverFullScreen;
        _imagePicker.allowsEditing = YES;
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"个人信息"];
    
//    self.data = [MQUIHelper getMineDetailVCItems];
    [self getMineDetailVCItems];
}

-(void) getMineDetailVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    MQSettingItem *avatar = [MQSettingItem createWithImageName:nil title:@"个人头像" subTitle:nil rightImageName:@"ic_head"];
    avatar.accessoryType = UITableViewCellAccessoryNone;
    MQSettingItem *name = [MQSettingItem createWithTitle:@"昵称" subTitle:self.userModel.nickname];
    MQSettingItem *num = [MQSettingItem createWithTitle:@"圈友账号" subTitle:@"g5d3fe34342fdf56"];
    num.accessoryType = UITableViewCellAccessoryNone;
    
    MQSettingItem *code = [MQSettingItem createWithImageName:nil title:@"二维码" subTitle:nil rightImageName:@"ic_head"];
    MQSettingItem *address = [MQSettingItem createWithTitle:@"我的地址" subTitle:self.userModel.address];
    MQSettingGrounp *frist = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:avatar, name, num, code, address, nil];
    [items addObject:frist];
    
    MQSettingItem *sex = [MQSettingItem createWithTitle:@"性别" subTitle:@"男"];
    sex.accessoryType = UITableViewCellAccessoryNone;
    MQSettingItem *pos = [MQSettingItem createWithTitle:@"地区" subTitle:@"广东 深圳"];
    
    MQSettingGrounp *second = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:sex, pos, nil];
    [items addObject:second];
    
    MQSettingItem *confirm = [MQSettingItem createWithTitle:@"实名认证" subTitle:@"未认证"];
    
    MQSettingGrounp *third = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:confirm, nil];
    [items addObject:third];

    self.data = items;
}


#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80.0f;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0)
    {
        MQSettingGrounp *itemGroup =self.data[indexPath.section];
        MQSettingItem *item = itemGroup.items[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                [self doSelectImageToEditUserHeadImage];
                 break;
            }
            case 1:
            {
                WEAK_SELF(self, weakSelf)
                MQNicknameViewController *nickNameVC =[[MQNicknameViewController alloc] init];
                nickNameVC.block=^(NSString *nickName){
                    
                    item.subTitle = nickName;
                    weakSelf.userModel.nickname = nickName;
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    [weakSelf.tableView reloadData];
                };
                [self.navigationController pushViewController:nickNameVC animated:YES];
                break ;
            }
            case 2:
            {
                break ;
            }
            case 3:
            {
                MQCodeViewController *codeVC =[[MQCodeViewController alloc] init];
                [self.navigationController pushViewController:codeVC animated:YES];
                break ;
            }
            case 4:
            {
                MQMyAddressController *addVC =[[MQMyAddressController alloc] init];
                [self.navigationController pushViewController:addVC animated:YES];
                break ;
            }
        }
    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row ==0)
        {
            MQSexViewController *sexVC =[[MQSexViewController alloc] init];
            
            [self.navigationController pushViewController:sexVC animated:YES];
        }
        else
        {
            
        }
    }
    else
    {
        MQCertificationController *cerVC =[[MQCertificationController alloc] init];
        
        [self.navigationController pushViewController:cerVC animated:YES];
    }
    
}


-(void) doSelectImageToEditUserHeadImage
{
    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"点击取消按钮");
    }];
    
    WEAK_SELF(self, weakSelf)
    UIAlertAction *cameraAction =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [weakSelf clickedButtonAtIndex:0];
    }];
    
    UIAlertAction *pictureAction =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [weakSelf clickedButtonAtIndex:1];
    }];
    
    [cameraAction setValue:DEFAULT_MAIN_COLOR forKey:@"titleTextColor"];
    [pictureAction setValue:DEFAULT_MAIN_COLOR forKey:@"titleTextColor"];
    [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alertController addAction:cameraAction];
     [alertController addAction:pictureAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self hideHud];
    [self showHudInView:self.view hint:NSLocalizedString(@"setting.uploading", @"uploading...")];
    
    __weak typeof(self) weakSelf = self;
    UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (orgImage) {
        [[UserProfileManager sharedInstance] uploadUserHeadImageProfileInBackground:orgImage completion:^(BOOL success, NSError *error) {
            [weakSelf hideHud];
            if (success) {
                UserProfileEntity *user = [[UserProfileManager sharedInstance] getCurUserProfile];
               
                NSLog(@"user image:%@",user.imageUrl);
                [self showHint:NSLocalizedString(@"setting.uploadSuccess", @"uploaded successfully")];
            } else {
                [self showHint:NSLocalizedString(@"setting.uploadFail", @"uploaded failed")];
            }
        }];
    } else {
        [self hideHud];
        [self showHint:NSLocalizedString(@"setting.uploadFail", @"uploaded failed")];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}


- (void)clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
#if TARGET_IPHONE_SIMULATOR
        [self showHint:NSLocalizedString(@"message.simulatorNotSupportCamera", @"simulator does not support taking picture")];
#elif TARGET_OS_IPHONE
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
            [self presentViewController:self.imagePicker animated:YES completion:NULL];
        } else {
            
        }
#endif
    } else if (buttonIndex == 1) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        [self presentViewController:self.imagePicker animated:YES completion:NULL];
        
    }
}



@end
