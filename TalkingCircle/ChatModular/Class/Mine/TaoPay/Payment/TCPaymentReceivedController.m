//
//  TCPaymentReceivedController.m
//  TalkingCircle
//
//  Created by iMac on 2017/5/5.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCPaymentReceivedController.h"
#import "UIButton+Extend.h"
@interface TCPaymentReceivedController ()

@property (nonatomic,strong) UITextField *wayTextField;
@property (nonatomic,strong) UITextField *payTextField;
@end

@implementation TCPaymentReceivedController

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
    self.title = @"收付款";
    self.view.backgroundColor =[UIColor redColor];
    [self initWithCustomView];
}

-(void) initWithCustomView
{
    
    WEAK_SELF(self, weakSelf);
    //UIImageView
    UIImageView *imageView =[[UIImageView alloc] init];
    imageView.image =[UIImage imageNamed:@"qr-code"];
    imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH_SCREEN-20, WIDTH_SCREEN+20));
        make.centerX.equalTo(weakSelf.view);
        make.top.with.offset(HEIGHT_NAVBAR+20);
    }];
    imageView.backgroundColor =[UIColor whiteColor];
    imageView.layer.cornerRadius = 5.0;
    
    
    //payTextField
    UITextField *textField =[[UITextField alloc] init];
//    textField.backgroundColor = [UIColor whiteColor];
    textField.font =[UIFont systemFontOfSize:13];
    // leftView
    UIImageView *tLeftImgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    tLeftImgView.contentMode = UIViewContentModeCenter;
    tLeftImgView.image = [UIImage imageNamed:@"change-icon"];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = tLeftImgView;
    
    //rightView
    UIButton *btn =[[TCImageRightTextRightButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [btn setTitle:@"更换" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btn setImage:[UIImage imageNamed:@"arrow-yellow"] forState:UIControlStateNormal];
    btn.contentMode = UIViewContentModeScaleToFill;
    
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightView = btn;
    
    textField.textColor = [UIColor whiteColor];
    textField.text = @"零钱";
    [textField setEnabled:NO];
    textField.selected = NO;
    self.wayTextField = textField;
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(120, 20));
        make.centerX.equalTo(imageView);
         make.top.equalTo(imageView.mas_bottom).with.offset(20);
    }];
    

    
    //我要收款按钮
    
    TCImageLeftTextRightButton *arrowBtn =[[TCImageLeftTextRightButton alloc] init];
    arrowBtn.imageToLeftSpace = 15.0f;
    arrowBtn.imageAndTextSpace = 10.0f;
    [arrowBtn setTitle:@"我要收款" forState:UIControlStateNormal];
   
    [arrowBtn setTitleColor:[UIColor colorWithHexString:@"c1b21c"] forState:UIControlStateNormal];
    [arrowBtn setTitleColor:[UIColor colorWithHexString:@"c1b21c" alpha:0.5] forState:UIControlStateHighlighted];
    [arrowBtn setImage:[UIImage imageNamed:@"gathering"] forState:UIControlStateNormal];
    [arrowBtn setBackgroundColor:[UIColor whiteColor]];
    arrowBtn.layer.cornerRadius = 3.0;
    [arrowBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:arrowBtn];
    
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(WIDTH_SCREEN-60, 40));
        make.centerX.equalTo(weakSelf.view);
        make.top.with.offset(HEIGHT_SCREEN-50);
    }];
    
}

-(void)clickEvent:(UIButton*) btn
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
