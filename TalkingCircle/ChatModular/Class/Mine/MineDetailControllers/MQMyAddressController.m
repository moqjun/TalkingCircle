//
//  MQMyAddressController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQMyAddressController.h"

#import "MQAddNewAddressController.h"
#import "EaseCommonTableViewCell.h"

#import "UserProfileManager.h"
#import "MQAddressModel.h"

@interface MQMyAddressController ()

@property (nonatomic,strong) NSMutableArray *addressLists;

@end

@implementation MQMyAddressController

-(NSMutableArray *)addressLists
{
    if (_addressLists == nil)
    {
        _addressLists =[NSMutableArray array];
        
    }
    return _addressLists;
}

-(instancetype) init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的地址";
     self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.tableView.tableFooterView =[[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSMutableArray *array =[[UserProfileManager sharedInstance] getCurrentUserAddress];
    if (array)
    {
        [self.addressLists addObjectsFromArray:array];
        
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0)
    {
        return self.addressLists.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifer =@"addressTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"555"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    
    if (indexPath.section == 0)
    {
        MQAddressModel *addressModel =self.addressLists[indexPath.row];
        cell.textLabel.text = addressModel.name;
        NSString *address =[addressModel.address stringByAppendingFormat:@"%@ %@",addressModel.detailAddress,addressModel.code];
        cell.detailTextLabel.text = address;
    }
    else
    {
        cell.textLabel.text = @"新增地址";
        cell.detailTextLabel.text = nil;
    }
   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 60.0f;
    }
    
    return 44.0f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1f;
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



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section)
    {
        WEAK_SELF(self, weakSelf)
        MQAddNewAddressController *addVC =[[MQAddNewAddressController alloc] init];
        addVC.addressBlock =^(MQAddressModel *addressModel)
        {
            [weakSelf.addressLists addObject:addressModel];
            [weakSelf.tableView reloadData];
            [[UserProfileManager sharedInstance] saveCurrentUserAddress:weakSelf.addressLists];
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [self.navigationController pushViewController:addVC animated:YES];
    }
    else
    {
        WEAK_SELF(self, weakSelf)
       
        MQAddNewAddressController *addVC =[[MQAddNewAddressController alloc] init];
        addVC.isEditAddress = YES;
        addVC.addressModel = self.addressLists[indexPath.row];
        addVC.addressBlock =^(MQAddressModel *addressModel)
        {
            MQAddressModel *model =weakSelf.addressLists[indexPath.row];
            model = addressModel;
            
            [weakSelf.tableView reloadData];
            
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        UINavigationController *naVC =[[UINavigationController alloc] initWithRootViewController:addVC];
        
        [self presentViewController:naVC animated:YES completion:nil];
    }
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
