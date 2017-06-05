//
//  MQEditPhoneController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/21.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQEditPhoneController.h"

@interface MQEditPhoneController ()
@property (nonatomic,weak) UITextField *phoneField;
@property (nonatomic,weak) UITextField *verifyField;
@end

@implementation MQEditPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改手机号";
    
    [self initCustomGroupView];
}

-(void) initCustomGroupView
{
    //imageView
    CGFloat imageViewWidth = 60;
    CGFloat imageViewX =(WIDTH_SCREEN - imageViewWidth)/2;
    
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 20, imageViewWidth, imageViewWidth)];
    imageView.image = [UIImage imageNamed:@"setting-phone"];
//    imageView.backgroundColor = [UIColor colorWithHexString:@"f8b348"];
    [self.view addSubview:imageView];
    
    //field
    CGFloat yy = imageView.y+imageView.height+20;
    self.phoneField = [self createCustomViewGroup:@"+86" field:@"请输入新的手机号" point:yy];
    self.verifyField = [self createCustomViewGroup:@"验证码" field:@"请输入您的验证码" point:yy+35];
    self.verifyField.frameWidth =WIDTH_SCREEN-self.verifyField.x-100;
    
    //label
    UILabel *line =[[UILabel alloc] initWithFrame:CGRectMake(self.verifyField.x+self.verifyField.frameWidth, yy+40, 1, 15)];
    line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    [self.view addSubview:line];
    
    //button
    UIButton *verifyBtn =[[UIButton alloc] initWithFrame:CGRectMake(line.x, yy+35, 100, 25)];
    [verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [verifyBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [verifyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [verifyBtn addTarget:self action:@selector(sendVerify:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:verifyBtn];
    
    
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
    CGFloat labelx =10.0;
    CGFloat labelWidth = 60;
    CGFloat fieldWidth =WIDTH_SCREEN -labelx-labelWidth;
    CGFloat height = 25;
    
    //label
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(labelx, pointY, labelWidth, height)];
    label.text = labelTitle;
//    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:15];
    
    //field
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(labelx+labelWidth+5, pointY, fieldWidth, height)];
    field.placeholder =placeholder;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.font = [UIFont systemFontOfSize:15];
    
    //line
    UILabel *line2 =[[UILabel alloc] initWithFrame:CGRectMake(5, pointY+height+5, WIDTH_SCREEN-10, 0.5)];
    line2.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    
    [self.view addSubview:label];
    [self.view addSubview:field];
    [self.view addSubview:line2];
    
    return field;
}

#pragma mark 发送验证码
-(void)sendVerify:(UIButton *) btn
{
    
}

#pragma mark 提交
-(void) onCommitEvent:(UIButton *) btn
{
    
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
