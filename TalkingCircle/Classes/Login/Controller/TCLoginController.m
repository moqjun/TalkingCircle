//
//  TCLoginController.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/11.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCLoginController.h"
#import "TCForgetPasswordController.h"
#import "TCUserRegisterController.h"
#import "TCLoginTypeTextField.h"
#import "HWWeakTimer.h"
#import "EMClientUserLoginRequest.h"
#import "TCUserLoginInfo.h"
#import "TCVerifyCodeSendRequest.h"


@interface TCLoginController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetPasswordBtn;
@property (nonatomic, strong) UIButton *smsLoginBtn;
@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UIImageView *logoImgView;

@property (nonatomic, strong) UIImageView *userNameLeftView;
@property (nonatomic, strong) UIImageView *passwordLeftView;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;

@property (nonatomic, strong) UIButton *showPasswordBtn;

@property (nonatomic, assign) BOOL isSmsLogin; //是否是短信登录

@property (nonatomic, strong) TCLoginTypeTextField *phoneNumField;
@property (nonatomic, strong) TCLoginTypeTextField *verifyCodeField;

@property (nonatomic, assign) CGRect loginBtnInWindowFrame;

@property (nonatomic, strong) NSTimer *weakTimer;
@property (nonatomic, assign) int repeatCount;
@property (nonatomic, strong) TCVerifyCodeSendRequest *verifyCodeSender;

@end

@implementation TCLoginController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.weakTimer invalidate];
    self.weakTimer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView
{
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.registerBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.logoImgView];
    [self.bgView addSubview:self.userNameTextField];
    [self.bgView addSubview:self.passwordTextField];
    
    [self.bgView addSubview:self.phoneNumField];
    [self.bgView addSubview:self.verifyCodeField];
    
    self.phoneNumField.hidden = YES;
    self.verifyCodeField.hidden = YES;
    
    [self.bgView addSubview:self.loginBtn];
    
    self.userNameTextField.leftView = self.userNameLeftView;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.passwordTextField.leftView = self.passwordLeftView;
    self.passwordTextField.rightView = self.showPasswordBtn;
    self.passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.bgView addSubview:self.lineView1];
    [self.bgView addSubview:self.lineView2];
    
    [self.bgView addSubview:self.forgetPasswordBtn];
    [self.bgView addSubview:self.smsLoginBtn];
}


- (void)initData
{
    self.title = @"登录";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.repeatCount = verifyCodeEffectiveTime;
    
    self.verifyCodeSender = [[TCVerifyCodeSendRequest alloc] init];
    
}

#pragma mark - pubulic Method

#pragma mark - Business Method


- (void)accountLogin
{
    WEAK_SELF(self, weakSelf);
    NSString *randomString = [NSString ret128bitString];
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_Login;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
        [params safeSetObject:weakSelf.userNameTextField.text forKey:@"mobile"];
        [params safeSetObject:[weakSelf.passwordTextField.text md5String] forKey:@"password"];
        [params safeSetObject:randomString forKey:@"random_string"];
        
        maker.cgiWrap.param = params;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        
         TCNetBaseData *baseData = [TCNetBaseData initWithJsonDic:responseData];
        
        if (!err) {
            
            if (baseData.success) {
    
                [[TCUserLoginInfo shareInstance] updateToken:[responseData objectForKey:@"token"]];
                [[TCUserLoginInfo shareInstance] updateUserName:weakSelf.userNameTextField.text];
                [[TCUserLoginInfo shareInstance] updatePasswordMd5:[weakSelf.passwordTextField.text md5String]];
                 [[TCUserLoginInfo shareInstance] updateAesKey:[baseData aesKeyWithRandomAESKey:randomString]];
                
                [[EMClientUserLoginRequest shareInstance] loginWithUsername:[TCUserLoginInfo shareInstance].userName password:[TCUserLoginInfo shareInstance].passwordMd5 callBack:^(NSError *err, id responseData, NSDictionary *ext) {
                    
                    [weakSelf hideHud];
                    
                }];
                
            }else{
                
                TCAlertNoTitle(baseData.message);
               [weakSelf hideHud];
            }
            
        }else{
         [weakSelf hideHud];
         TCAlertNoTitle(NSLocalizedString(@"TC.net.alertMessage.netCommonError", nil));
            
        }
    }];
}

- (void)smsLogin
{
    WEAK_SELF(self, weakSelf);
    
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        
        maker.cgiWrap.m_functionId = NetFunc_VerifyCodeLogin;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
        [params safeSetObject:weakSelf.phoneNumField.actionTextField.text forKey:@"mobile"];
        [params safeSetObject:weakSelf.verifyCodeField.actionTextField.text forKey:@"mobile_code"];
        [params safeSetObject:[NSString ret128bitString] forKey:@"random_key"];
        maker.cgiWrap.param = params;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        
         TCNetBaseData *baseData = [TCNetBaseData initWithJsonDic:responseData];
        
        if (!err) {
            if (baseData.success) {
                
                [[TCUserLoginInfo shareInstance] updateToken:[responseData objectForKey:@"token"]];
                [[TCUserLoginInfo shareInstance] updatePasswordMd5:[responseData objectForKey:@"huanxin_login"]];
                [[EMClientUserLoginRequest shareInstance] loginWithUsername:weakSelf.phoneNumField.actionTextField.text password:[TCUserLoginInfo shareInstance].passwordMd5 callBack:^(NSError *err, id responseData, NSDictionary *ext) {
                  
                     [weakSelf hideHud];
                    
                }];
            }else{
                TCAlertNoTitle(baseData.message);
                [weakSelf hideHud];
            }
            
        }else{
          TCAlertNoTitle(NSLocalizedString(@"TC.net.alertMessage.netCommonError", nil));
          [weakSelf hideHud];
        }
    }];
}


- (BOOL)accountLoginCheck
{
    NSString *account = [self.userNameTextField.text clearMarginSpace];
    NSString *password = [self.passwordTextField.text clearMarginSpace];
    
 
    if (account.length <= 0 || ![account isPhoneNum]) {
        TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.phoneNumError", nil));
        return NO;
    }
    if (password.length <= 0) {
        TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.passwordError", nil));
        return NO;
    }
    
    return YES;

}


- (BOOL)smsLoginCheck
{
    NSString *phoneNum = [self.phoneNumField.actionTextField.text clearMarginSpace];
    NSString *verifyCode = [self.verifyCodeField.actionTextField.text clearMarginSpace];
    
  
    if (phoneNum.length <= 0 || ![phoneNum isPhoneNum]) {
        TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.phoneNumError", nil));
        return NO;
    }
    if (verifyCode.length <= 0) {
         TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.verifyCodeError", nil));
        return NO;
    }
    
    return YES;
}

#pragma mark - private Method

- (void)keyboardWillShow:(NSNotification *)notif {
    CGFloat duration = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect      = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (self.loginBtnInWindowFrame.origin.y == 0) {
        self.loginBtnInWindowFrame = [self.bgView convertRect:self.loginBtn.frame toView:self.view.window];
    }
    
//    CGRect frame = [self.bgView convertRect:self.loginBtn.frame toView:self.view.window];
    CGFloat space = CGRectGetMinY(rect) - CGRectGetMinY(self.loginBtnInWindowFrame);
    if (space < 50) {
        
        [UIView animateWithDuration:duration animations:^{
            CGFloat distance = 50 - space;
           
            self.bgView.y = - distance;
           
        }];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notif
{
    CGFloat duration = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.bgView.y = 0.0;
    }];
}

//注册
- (void)registerAction
{
    TCUserRegisterController *controller = [[TCUserRegisterController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

//登录
- (void)beginLoginAction
{
    if(self.isSmsLogin)
    {
        if (![self smsLoginCheck]) {
            return;
        }
        [self showHudInView:self.bgView hint:NSLocalizedString(@"TC.login.alertMessage.logining", nil)];
        [self smsLogin];
        [self resignTextFieldFirstResponderAction];
    }else{
        
        if (![self accountLoginCheck]) {
            return;
        }
         [self showHudInView:self.bgView hint:NSLocalizedString(@"TC.login.alertMessage.logining", nil)];
        [self accountLogin];
        [self resignTextFieldFirstResponderAction];
    }
    
}

//短信登录
- (void)smsLoginAction
{
    if (!self.isSmsLogin) {
        self.isSmsLogin = YES;
        self.phoneNumField.hidden = NO;
        self.verifyCodeField.hidden = NO;
        self.userNameTextField.hidden = YES;
        self.passwordTextField.hidden = YES;
        self.lineView1.hidden = YES;
        self.lineView2.hidden = YES;
        [self.smsLoginBtn setTitle:@"使用账号登录" forState:UIControlStateNormal];
    }else{
        self.isSmsLogin = NO;
        self.phoneNumField.hidden = YES;
        self.verifyCodeField.hidden = YES;
        self.userNameTextField.hidden = NO;
        self.passwordTextField.hidden = NO;
        self.lineView1.hidden = NO;
        self.lineView2.hidden = NO;
        [self.smsLoginBtn setTitle:@"使用短信验证登录" forState:UIControlStateNormal];
    }
    
    
}

//忘记密码
- (void)forgetPasswordAction
{
    TCForgetPasswordController *contoller = [[TCForgetPasswordController alloc] init];
    [self.navigationController pushViewController:contoller animated:YES];
}

//显示密码
- (void)showPasswordAction:(UIButton*)sender
{
    if (sender.selected)
    {
        self.passwordTextField.secureTextEntry = YES;
    }else
    {
        self.passwordTextField.secureTextEntry = NO;
    }
    
    sender.selected = !sender.selected;
}

- (void)resignTextFieldFirstResponderAction
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.phoneNumField.actionTextField resignFirstResponder];
    [self.verifyCodeField.actionTextField resignFirstResponder];
}

//发验证码
- (void)sendVerifyCodeAction
{
    if (![self.phoneNumField.actionTextField.text isPhoneNum]) {
        TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.phoneNumError", nil));
        return;
    }
    
     WEAK_SELF(self, weakSelf);
    if (!self.weakTimer) {
       
        self.weakTimer = [HWWeakTimer scheduledTimerWithTimeInterval:1.0 block:^(id userInfo) {
            if (weakSelf.repeatCount <= 0) {
                [self.weakTimer invalidate];
                self.weakTimer = nil;
                weakSelf.repeatCount = verifyCodeEffectiveTime;
                [weakSelf.verifyCodeField setActionBtnTitle:@"发送验证码"];
                weakSelf.verifyCodeField.actionBtn.enabled = YES;
            }else
            {
                [weakSelf.verifyCodeField setActionBtnTitle:[NSString stringWithFormat:@"%ds后重发验证码",weakSelf.repeatCount]];
                weakSelf.repeatCount --;
                weakSelf.verifyCodeField.actionBtn.enabled = NO;
            }
            
        } userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.weakTimer forMode:NSRunLoopCommonModes];
    }
    
    [self.verifyCodeSender sendVerifyCodeWithPhoneNum:self.phoneNumField.actionTextField.text sendType:VerifyCodeSendType_Login callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        TCNetBaseData *baseData = [TCNetBaseData initWithJsonDic:responseData];
        if (!err) {
            if (!baseData.success) {
                [weakSelf.weakTimer invalidate];
                weakSelf.weakTimer = nil;
                weakSelf.repeatCount = verifyCodeEffectiveTime;
                [weakSelf.verifyCodeField setActionBtnTitle:@"发送验证码"];
                weakSelf.verifyCodeField.actionBtn.enabled = YES;
                TCAlertNoTitle(baseData.message);
                
            }
        }else
        {
            [weakSelf.weakTimer invalidate];
            weakSelf.weakTimer = nil;
            weakSelf.repeatCount = verifyCodeEffectiveTime;
            [weakSelf.verifyCodeField setActionBtnTitle:@"发送验证码"];
            weakSelf.verifyCodeField.actionBtn.enabled = YES;
            TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.verifyCodeSendError", nil));
        }
    }];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    textField.text = text;
    
    BOOL hasTelephone = [self.userNameTextField.text clearMarginSpace].length > 0;
    BOOL hasVerifyCode = [self.passwordTextField.text clearMarginSpace].length > 0;
    
    self.loginBtn.enabled = (hasTelephone && hasVerifyCode);
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.loginBtn.enabled = NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField) {
        [textField resignFirstResponder];
        [self beginLoginAction];
    }
    return YES;
}


#pragma mark - UI setter and getter

- (UITextField *)userNameTextField
{
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.logoImgView.bottom + 39, BOUND_WIDTH - 20, 45)];
        _userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入您的手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithUInt:0xc2c2c2]}];
        _userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _userNameTextField.returnKeyType = UIReturnKeyNext;
        _userNameTextField.delegate = self;
    }
    
    return _userNameTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.userNameTextField.bottom, BOUND_WIDTH - 20, 45)];
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithUInt:0xc2c2c2]}];
        _passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _passwordTextField.delegate = self;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.secureTextEntry = YES;
    }
    
    return _passwordTextField;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, self.passwordTextField.bottom + 60, BOUND_WIDTH - 36, 45)];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:[UIColor colorWithUInt:0x10b8d8]];
        _loginBtn.layer.cornerRadius = 4.0;
        
        [_loginBtn addTarget:self action:@selector(beginLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)forgetPasswordBtn
{
    if (!_forgetPasswordBtn) {
        _forgetPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewObjectInMiddleOriginX(200), self.loginBtn.bottom + 18, 200, 20)];
        [_forgetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetPasswordBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_forgetPasswordBtn setTitleColor:[UIColor colorWithUInt:0x10b8d8] forState:UIControlStateNormal];
        [_forgetPasswordBtn addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _forgetPasswordBtn;
}

- (UIButton *)smsLoginBtn
{
    if (!_smsLoginBtn) {
        _smsLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewObjectInMiddleOriginX(200), BOUND_HEIGHT - TC_NAV_HEIGHT - 38, 200, 20)];
        [_smsLoginBtn setTitle:@"使用短信验证登录" forState:UIControlStateNormal];
        [_smsLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_smsLoginBtn setTitleColor:[UIColor colorWithUInt:0x555555] forState:UIControlStateNormal];
         [_smsLoginBtn addTarget:self action:@selector(smsLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsLoginBtn;
}

- (UIButton *)registerBtn
{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,50,30)];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return  _registerBtn;
}

- (UIImageView *)logoImgView
{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewObjectInMiddleOriginX(97), 39, 97, 97)];
        _logoImgView.image = [UIImage imageNamed:@"login_logo"];
    }
    
    return _logoImgView;
}


- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, self.view.height - TC_NAV_HEIGHT)];
        _bgView.backgroundColor = self.view.backgroundColor;
        UIButton *bgBtn = [[UIButton alloc] initWithFrame:_bgView.bounds];
        [bgBtn addTarget:self action:@selector(resignTextFieldFirstResponderAction) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:bgBtn];
    }
    
    return _bgView;
}

- (UIImageView *)userNameLeftView
{
    if (!_userNameLeftView) {
        _userNameLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, self.userNameTextField.height)];
        _userNameLeftView.image = [UIImage imageNamed:@"login_phone"];
        [_userNameLeftView setContentMode:UIViewContentModeCenter];
    }
    
    return _userNameLeftView;
}


- (UIImageView *)passwordLeftView
{
    if (!_passwordLeftView) {
        _passwordLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, self.passwordTextField.height)];
        _passwordLeftView.image = [UIImage imageNamed:@"login_lock"];
         [_passwordLeftView setContentMode:UIViewContentModeCenter];
    }
    
    return _passwordLeftView;
}

- (UIView *)lineView1
{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, self.userNameTextField.bottom, self.userNameTextField.width, 0.5)];
        _lineView1.backgroundColor = [UIColor colorWithUInt:0xc2c2c2];
    }
    
    return _lineView1;
}

- (UIView *)lineView2
{
    if (!_lineView2) {
       _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, self.passwordTextField.bottom, self.passwordTextField.width, 0.5)];
        _lineView2.backgroundColor = [UIColor colorWithUInt:0xc2c2c2];
    }
    
    return _lineView2;
}

- (UIButton *)showPasswordBtn
{
    if (!_showPasswordBtn) {
        _showPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, self.passwordTextField.height)];
        [_showPasswordBtn setImage:[UIImage imageNamed:@"login_eye"] forState:UIControlStateNormal];
        [_showPasswordBtn setImage:[UIImage imageNamed:@"login_eye_cur"] forState:UIControlStateSelected];
        
        [_showPasswordBtn addTarget:self action:@selector(showPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _showPasswordBtn;
}


- (TCLoginTypeTextField *)phoneNumField
{
    if (!_phoneNumField) {
        _phoneNumField = [[TCLoginTypeTextField alloc] initWithTitle:@"+86" frame:self.userNameTextField.frame];
        [_phoneNumField setActionTextFieldPlaceholder:@"请输入您的手机号码" color: [UIColor colorWithUInt:0xc2c2c2]];
        _phoneNumField.actionTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _phoneNumField;
}


- (TCLoginTypeTextField *)verifyCodeField
{
    if (!_verifyCodeField) {
        _verifyCodeField = [[TCLoginTypeTextField alloc] initWithTitle:@"验证码" actionButtonTitle:@"发送验证码" frame:self.passwordTextField.frame];
        [_verifyCodeField setActionTextFieldPlaceholder:@"请输入您的验证码" color: [UIColor colorWithUInt:0xc2c2c2]];
        [_verifyCodeField.actionBtn addTarget:self action:@selector(sendVerifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _verifyCodeField;
}

@end
