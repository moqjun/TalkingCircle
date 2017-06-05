//
//  MQPartnerViewController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQPartnerViewController.h"
#import "EaseCommonTableViewCell.h"
#import "MQPartnerDetailController.h"

#import "MQPartnerModel.h"

@interface MQPartnerViewController ()

@property (nonatomic,strong) NSMutableArray *partners;

@end

@implementation MQPartnerViewController

-(NSMutableArray *)partners
{
    if (_partners == nil)
    {
        _partners = [NSMutableArray array];
        
    }
    
    return _partners;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"合伙人";
    
    [self getPartnerData];
}

-(void) getPartnerData
{
    NSArray *names =@[@"阿丽",@"辰东",@"三楼",@"思路",@"青龙",@"麒麟",@"青狼",@"龙牙",@"罗刹",@"龙岩",@"苍穹"];
    
    for (NSString *name in names)
    {
        MQPartnerModel *model =[[MQPartnerModel alloc] init];
        model.headIcon = @"ic_head";
        model.name = name;
        model.circleNo = [NSString stringWithFormat:@"%u",arc4random()%6553589];
        [self.partners addObject:model];
    }
    
    [self.tableView reloadData];
}

#pragma mark UITableViewDelegate 代理方法

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.partners.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = @"partnerCell";

    EaseCommonTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell = [[EaseCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
    }
    MQPartnerModel *model = self.partners[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:@"ic_head"];
    cell.textLabel.text = model.name;
    
    cell.detailTextLabel.text =[NSString stringWithFormat:@"圈号：%@",model.circleNo];
    
    return cell;
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

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MQPartnerModel *model = self.partners[indexPath.row];
    
    MQPartnerDetailController *pdVC =[[MQPartnerDetailController alloc] init];
    
    pdVC.partnerModel = model;
    
//    [self presentViewController:pdVC animated:YES completion:nil];
    [self.navigationController pushViewController:pdVC animated:YES];
    
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
