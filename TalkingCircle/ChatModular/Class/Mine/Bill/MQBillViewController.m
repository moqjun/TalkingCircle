//
//  MQBillViewController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/20.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQBillViewController.h"

#import "ZYLPickerView.h"

@interface MQBillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ZYLPickerView *pickerView;

@end

@implementation MQBillViewController

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView =[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账单";
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
    
    [self addCustomRightItem];
}

-(void) addCustomRightItem
{
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn setTitle:@"筛选" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(filtrateEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

-(void) filtrateEvent:(UIButton*) btn
{
    if (self.pickerView.isShowed)
    {
        [self.pickerView removeFromSuperview];
        self.pickerView = nil;
    }
    
    self.pickerView = [[ZYLPickerView alloc] initWithFrame:CGRectMake(0,HEIGHT_SCREEN - 240, WIDTH_SCREEN, 180)];
    
    for (NSInteger i =2000; i<=2999; i++)
    {
        NSString *year =[NSString stringWithFormat:@"%ld",i];
        [self.pickerView.firstArray addObject:year];
    }
    self.pickerView.secondArray =[NSMutableArray arrayWithArray: @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",
                                @"8",@"9",@"10",@"11",@"12"]];
    [self.pickerView didSelectRow:0 inComponent:0];
    [self.view addSubview:self.pickerView];
    
//    __weak __typeof(self) weakself = self;
    
    self.pickerView.SelectBlock = ^(NSString *yearMonth){
        
        if (yearMonth != nil) {
            
            NSLog(@"yearMonth:%@",yearMonth);
        }
    };

}

#pragma mark UITableViewDelegate 代理方法

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = @"billCell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    cell.textLabel.text = @"个人红包";
    cell.detailTextLabel.text =[NSString stringWithFormat:@"201%ld年3月15日 08:47",indexPath.section] ;
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    label.text = @"+800";
    label.font = [UIFont systemFontOfSize:18];
    cell.accessoryView = label ;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 29)];
    label.backgroundColor = [UIColor clearColor];
    [label setText:[NSString stringWithFormat:@"%ld月",section]];
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
