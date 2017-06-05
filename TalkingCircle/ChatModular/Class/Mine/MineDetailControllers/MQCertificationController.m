//
//  MQCertificationController.m
//  TalkingCircle
//
//  Created by iMac on 2017/5/4.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQCertificationController.h"

@interface MQCertificationController ()
@property (nonatomic,weak) UITextField *nameField;
@property (nonatomic,weak) UITextField *idCardField;

@end

@implementation MQCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    self.view.backgroundColor = [UIColor colorWithUInt:0xefeff4];
    
    [self initCustomGroupView];
}
-(void) initCustomGroupView
{
    
    
    CGFloat yy = 20;
    //bgView
    UIView *bgView =[[UIView alloc] initWithFrame:CGRectMake(0, yy, WIDTH_SCREEN, 68)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    yy+=3;
    //field
    self.nameField = [self createCustomViewGroup:@"姓名" field:@"请输入姓名" point:yy];
    self.idCardField = [self createCustomViewGroup:@"身份证" field:@"请输入身份证号" point:yy+35];
    
    
    CGFloat distance = 15;
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(distance, yy+100, WIDTH_SCREEN-distance*2, 30)];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:DEFAULT_MAIN_COLOR];
    commitBtn.layer.cornerRadius = 5;
    [commitBtn addTarget:self action:@selector(onCommitEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:commitBtn];
    
    //tip提示信息
    UILabel *tipTitleLabel =[[UILabel alloc] initWithFrame:CGRectMake(distance, commitBtn.y+50, WIDTH_SCREEN-2*distance, 20)];
    tipTitleLabel.text =@"注意事项:";
    tipTitleLabel.font =[UIFont systemFontOfSize:13];
    tipTitleLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:tipTitleLabel];
    
    UITextView *tipTextView =[[UITextView alloc] initWithFrame:CGRectMake(distance-2, tipTitleLabel.y+20, WIDTH_SCREEN-distance, 70)];
    tipTextView.text = @"1.认证成功后身份证信息将不能更改,请务必确认信息准确\n2.您的信息我们将严格保管，请放心";
    tipTextView.font = [UIFont systemFontOfSize:13];
    tipTextView.textColor = [UIColor lightGrayColor];
    tipTextView.backgroundColor = [UIColor clearColor];
    tipTextView.editable = NO;
    tipTextView.selectable = NO;
    [self.view addSubview:tipTextView];
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
