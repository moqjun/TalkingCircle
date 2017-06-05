//
//  MQEditPasswordController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/21.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQEditPasswordController.h"

@interface MQEditPasswordController ()

@property (nonatomic,weak) UITextField *oPwdField;
@property (nonatomic,weak) UITextField *nPwdField;
@property (nonatomic,weak) UITextField *retryPwdField;


@end

@implementation MQEditPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改密码";
    
    [self initCustomGroupView];
}

-(void) initCustomGroupView
{
    CGFloat yy = 30;
    self.oPwdField = [self createCustomViewGroup:@"旧密码" field:@"请输入旧密码" point:yy];
    self.oPwdField = [self createCustomViewGroup:@"新密码" field:@"请输入新密码" point:yy+35];
    self.oPwdField = [self createCustomViewGroup:@"确认密码" field:@"请再一次输入新密码" point:yy+70];
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, yy+150, WIDTH_SCREEN-20, 30)];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:DEFAULT_MAIN_COLOR];
    commitBtn.layer.cornerRadius = 5;
    [commitBtn addTarget:self action:@selector(onCommitEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:commitBtn];
}


-(UITextField *) createCustomViewGroup:(NSString *) labelTitle field:(NSString *) placeholder
                                point:(CGFloat) pointY
{
    CGFloat labelx =0;
    CGFloat labelWidth = 70;
    CGFloat fieldWidth =WIDTH_SCREEN -labelx-labelWidth;
    CGFloat height = 25;
    
    //label
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(labelx, pointY, labelWidth, height)];
    label.text = labelTitle;
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:15];
    
    //field
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(labelx+labelWidth+5, pointY, fieldWidth, height)];
    field.font = [UIFont systemFontOfSize:15];
    field.placeholder =placeholder;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //line
    UILabel *line =[[UILabel alloc] initWithFrame:CGRectMake(5, pointY+height+1, WIDTH_SCREEN-10, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [self.view addSubview:label];
    [self.view addSubview:field];
    [self.view addSubview:line];
    return field;
}

#pragma mark 提交
-(void) onCommitEvent:(UIButton *) btn
{
    
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
