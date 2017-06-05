//
//  MQSexViewController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQSexViewController.h"

@interface MQSexViewController ()

@property (nonatomic,strong) NSArray *sexArray;

@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation MQSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"性别";
     self.view.backgroundColor = [UIColor whiteColor];
    self.sexArray = @[@"男",@"女"];

    self.tableView.tableFooterView = [[UIView alloc] init];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer =@"sexCell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = self.sexArray[indexPath.row];
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    NSString *icon =@"check";
    if (self.currentIndex == indexPath.row)
    {
        icon = @"checked";
    }
    
    imageView.image = [UIImage imageNamed:icon];
    cell.accessoryView = imageView;
    return cell ;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.currentIndex = indexPath.row;
    
    [tableView reloadData];
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
