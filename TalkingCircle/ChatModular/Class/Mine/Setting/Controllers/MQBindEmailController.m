//
//  MQBindEmailController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/21.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQBindEmailController.h"

@interface MQBindEmailController ()
@property (nonatomic,weak) UITextField *emailField;
@end

@implementation MQBindEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"绑定邮箱";
    
    [self initCustomGroupView];
}

-(void) initCustomGroupView
{
    CGFloat yy = 30;
    self.emailField = [self createCustomViewGroup:@"邮箱号" field:@"请输入您的邮箱" point:yy];
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, yy+100, WIDTH_SCREEN-20, 30)];
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
    CGFloat labelWidth = 60;
    CGFloat fieldWidth =WIDTH_SCREEN -labelx-labelWidth;
    CGFloat height = 25;
    
    //label
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(labelx, pointY, labelWidth, height)];
    label.text = labelTitle;
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:15];
    
    //field
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(labelx+labelWidth+5, pointY, fieldWidth, height)];
    field.placeholder =placeholder;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.font = [UIFont systemFontOfSize:15];
    
    //line
    UILabel *line1 =[[UILabel alloc] initWithFrame:CGRectMake(5, pointY-5, WIDTH_SCREEN-10, 0.5)];
    line1.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    
    UILabel *line2 =[[UILabel alloc] initWithFrame:CGRectMake(5, pointY+height+5, WIDTH_SCREEN-10, 0.5)];
    line2.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    
    //提示label
    UILabel *tipLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, pointY+height+10, WIDTH_SCREEN-30, 20)];
    tipLabel.text = @"绑定激活的邮箱后，可以使用邮箱号登录";
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:label];
    [self.view addSubview:field];
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:tipLabel];
    
    return field;
}


#pragma mark 提交
-(void) onCommitEvent:(UIButton *) btn
{
    NSString *email =self.emailField.text;
    if (![self checkEmailInput:email])
    {
        [self showHint:@"输入的邮箱格式错误"];
        return ;
    }
}

-(BOOL) checkEmailInput:(NSString *) email
{
    if (!email.length)
    {
        return YES;
    }
    NSString *regex = @"[A-Z0-9a_z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL valued = [predicate evaluateWithObject:email];
    
    return valued;
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
