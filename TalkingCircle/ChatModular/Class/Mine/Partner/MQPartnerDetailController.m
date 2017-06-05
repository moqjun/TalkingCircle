//
//  MQPartnerDetailController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQPartnerDetailController.h"
#import "MQPartnerDetailView.h"

#import "MQPartnerModel.h"

#define CUSTOM_VIEW_HEIGHT 230

@interface MQPartnerDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation MQPartnerDetailController

-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, CUSTOM_VIEW_HEIGHT, WIDTH_SCREEN, HEIGHT_SCREEN-CUSTOM_VIEW_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    
    return _tableView;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:DEFAULT_MAIN_COLOR]
                forBarPosition:UIBarPositionAny
                    barMetrics:UIBarMetricsDefault];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"明细";
    [self doCreateCustomView];
}

-(void) doCreateCustomView
{
    MQPartnerDetailView *view =[[MQPartnerDetailView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, CUSTOM_VIEW_HEIGHT)];
    view.partnerModel = self.partnerModel;
    
    [self.view addSubview:view];
    
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDelegate 

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"partnerDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"2017-3-28 08:00";
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    label.text = @"+30";
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:15];
    cell.accessoryView =label;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 29)];
    label.backgroundColor = [UIColor clearColor];
    [label setText:[NSString stringWithFormat:@"%ld月",section+1]];
    [contentView addSubview:label];
    return contentView;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
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
