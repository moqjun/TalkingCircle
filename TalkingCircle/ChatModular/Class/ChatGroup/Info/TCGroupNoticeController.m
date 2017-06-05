//
//  TCGroupNoticeController.m
//  TalkingCircle
//
//  Created by iMac on 2017/5/5.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCGroupNoticeController.h"

#import "UITextView+Placeholder.h"

@interface TCGroupNoticeController ()

@property (nonatomic,strong) UITextView *textView;

@end

@implementation TCGroupNoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"群公告";
     self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
}

-(void)addCustomViewAndItem
{
    //field
    UITextView *textView =[[UITextView alloc] initWithFrame:CGRectMake(10, 30, WIDTH_SCREEN-10, 60)];
    textView.font = [UIFont systemFontOfSize:14];
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder =@"请输入群公告";
    self.textView = textView;
    
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 30, WIDTH_SCREEN-10, 60)];
    imageView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:imageView];
    [self.view addSubview:textView];
    
    
    
    //barItem
    
    UIButton *saveBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveNickName:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark 保存修改的数据
-(void)saveNickName:(UIButton *) btn
{
    NSString *nickName = self.textView.text;
    NSLog(@"nickname:%@",nickName);
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
