//
//  MQAddNewAddressController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQAddNewAddressController.h"

#import "EaseCommonTableViewCell.h"
#import "MQAddNewAddressCell.h"

#import "MQAddressModel.h"
#import "ZmjPickView.h"

@interface MQAddNewAddressController ()<UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableArray *addressLists;

@end

@implementation MQAddNewAddressController

-(NSMutableArray *)addressLists
{
    if (_addressLists == nil)
    {
        _addressLists = [NSMutableArray array];
        NSArray *titles =@[@"联系人",@"手机号码",@"选择地区",@"详细地址",@"邮政编码"];
        NSArray *placeholders =@[@"姓名",@"11位手机号码",@"地区信息",@"街道门牌信息",@"邮政编码"];
        if (self.isEditAddress)
        {
            placeholders =@[_addressModel.name,_addressModel.phone,_addressModel.address,_addressModel.detailAddress,_addressModel.code];
        }
        for (NSInteger i =0; i<titles.count; i++)
        {
            MQAddressModel *model =[[MQAddressModel alloc] init];
            model.title = titles[i];
            model.placeholder = placeholders[i];
            [_addressLists addObject:model];
        }
    }
    return _addressLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.title = @"我的地址";
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.tableView.tableFooterView =[[UIView alloc] init];
    
    [self initCustomRightBarItem];
}

-(void) initCustomRightBarItem
{
    NSString *rightItemTitle =@"确定";
    
    if(self.isEditAddress)
    {
        rightItemTitle = @"保存";
        
        UIButton *cancelBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(onCancelEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
        self.navigationItem.leftBarButtonItem = item;
    }

    UIButton *okBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    
    [okBtn setTitle:rightItemTitle forState:UIControlStateNormal];
    
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(onConfirm:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:okBtn];
    
    self.navigationItem.rightBarButtonItem = item;
}

-(void)onCancelEvent:(UIButton *) btn
{
    UIAlertView *aletView =[[UIAlertView alloc] initWithTitle:@"" message:@"确定要放弃此次编辑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aletView show];
   
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
         [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 保存新增地址信息
-(void)onConfirm:(UIButton *) btn
{
    [self.view endEditing:YES];
    
    MQAddressModel *model =self.addressLists[0];
    NSString *contact = self.isEditAddress? model.placeholder:model.fieldText;
    if (!contact.length)
    {
        return ;
    }
    
    model =self.addressLists[1];
    NSString *phone = self.isEditAddress? model.placeholder:model.fieldText;
    model =self.addressLists[2];
    NSString *selectCity = self.isEditAddress? model.placeholder:model.placeholder;
    model =self.addressLists[3];
    NSString *detailAddress = self.isEditAddress? model.placeholder:model.fieldText;
    model =self.addressLists[4];
    NSString *code = self.isEditAddress? model.placeholder:model.fieldText;
    if (!code.length) {
        code = @"";
    }
   
    if (selectCity && contact)
    {
        MQAddressModel *tempModel =[[MQAddressModel alloc] init];
        tempModel.name = contact;
        tempModel.phone = phone;
        tempModel.address = selectCity;
        tempModel.detailAddress = detailAddress;
        tempModel.code = code;
        
        self.addressBlock(tempModel);
        self.addressBlock = nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.addressLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MQAddressModel *model =self.addressLists[indexPath.row];
   
    if (indexPath.row ==2)
    {
        NSString *identifer =@"cityCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font =[UIFont systemFontOfSize:15];
            cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
            cell.detailTextLabel.textColor =[UIColor colorWithHexString:@"e2e2e2"];
        }
       
        cell.textLabel.text = model.title;
        cell.detailTextLabel.text = model.placeholder;
        return cell;
    }
    else
    {
         MQAddNewAddressCell *cell = [MQAddNewAddressCell addNewAddressWithTableView:tableView];
         cell.addressModel = model;
        return cell;
    }
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3)
    {
        return 64.0f;
    }
    return 44.0f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==2)
    {
       
        ZmjPickView *pickView =[[ZmjPickView alloc] init];
        [pickView show];
        WEAK_SELF(self, weakSelf)
        pickView.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName){
           
            MQAddressModel *model =weakSelf.addressLists[indexPath.row];
            model.placeholder = [NSString stringWithFormat:@"%@%@%@",shengName,shiName,xianName];
            [weakSelf.tableView reloadData];
        };

    }
//    [tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
