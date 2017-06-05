//
//  TCForgetPasswordController.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/15.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCForgetPasswordController.h"
#import "TCLoginTypeTextField.h"
#import "TCVerifyCodeSendRequest.h"
#import "HWWeakTimer.h"

@interface TCForgetPasswordController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) TCLoginTypeTextField *phoneNumField;
@property (nonatomic, strong) TCLoginTypeTextField *verifyCodeField;
@property (nonatomic, strong) TCLoginTypeTextField *passwordField;
@property (nonatomic, strong) TCLoginTypeTextField *confirmPasswordField;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, assign) CGRect confirmBtnInWindowFrame;

@property (nonatomic, strong) TCVerifyCodeSendRequest *verifyCodeSendRequest;

@property (nonatomic, strong) NSTimer *weakTimer;
@property (nonatomic, assign) int repeatCount;


@end

@implementation TCForgetPasswordController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.phoneNumField];
    [self.bgView addSubview:self.verifyCodeField];
    [self.bgView addSubview:self.passwordField];
    [self.bgView addSubview:self.confirmPasswordField];
    
    [self.bgView addSubview:self.confirmBtn];
    
}

- (void)initData
{
    self.title = @"忘记密码";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.verifyCodeSendRequest = [[TCVerifyCodeSendRequest alloc] init];
    self.repeatCount = verifyCodeEffectiveTime;
}

#pragma mark -- Private Method

- (void)goBack
{
    [self hideHud];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resignTextFieldFirstResponderAction
{
    [self.phoneNumField.actionTextField resignFirstResponder];
    [self.verifyCodeField.actionTextField resignFirstResponder];
    [self.passwordField.actionTextField resignFirstResponder];
    [self.confirmPasswordField.actionTextField resignFirstResponder];
}

- (void)confirmChangePasswordAction
{
    if (![self changePasswordCheck]) {
        return;
    }
    
    [self showHudInView:self.bgView hint:@"正在修改密码..."];
    WEAK_SELF(self, weakSelf);
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_ChangePassword;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
        [params safeSetObject:weakSelf.phoneNumField.actionTextField.text forKey:@"mobile"];
        [params safeSetObject:weakSelf.verifyCodeField.actionTextField.text forKey:@"mobile_code"];
        [params safeSetObject:[weakSelf.passwordField.actionTextField.text md5String] forKey:@"password"];
        maker.cgiWrap.param = params;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        [weakSelf hideHud];
        TCNetBaseData *baseData = [TCNetBaseData initWithJsonDic:responseData];
        if (!err) {
            if (baseData.success) {
                [weakSelf showHint:@"修改密码成功"];
                [weakSelf performSelector:@selector(goBack) withObject:nil afterDelay:2];
            }else{
               TCAlertNoTitle(baseData.message);
            }
        }else{
            TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.changePasswordError", nil));
        }
    }];
}

- (BOOL)changePasswordCheck
{
    NSString *phoneNum = [self.phoneNumField.actionTextField.text clearMarginSpace];
    NSString *verifyCode = [self.verifyCodeField.actionTextField.text clearMarginSpace];
    NSString *confirmPassword = [self.confirmPasswordField.actionTextField.text clearMarginSpace];
    NSString *password = [self.passwordField.actionTextField.text clearMarginSpace];
    
    
    if (phoneNum.length <= 0 || ![phoneNum isPhoneNum]) {
        TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.phoneNumError", nil));
        return NO;
    }
    
    if (verifyCode.length <= 0) {
        TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.verifyCodeError", nil));
        return NO;
    }
    
    if (password.length <= 0) {
        TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.passwordError", nil));
        return NO;
    }
    
    if (confirmPassword.length <= 0) {
        TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.passwordError", nil));
        return NO;
    }
    
    if (![password isEqualToString:confirmPassword]) {
        TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.passwordNotInequality", nil));
    }
    return YES;
}

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
    
    [self.verifyCodeSendRequest sendVerifyCodeWithPhoneNum:self.phoneNumField.actionTextField.text sendType:VerifyCodeSendType_ForgetPassword callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        TCNetBaseData *baseData = [TCNetBaseData initWithJsonDic:responseData];
        if (!err) {
            if (!baseData.success) {
                [weakSelf.weakTimer invalidate];
                weakSelf.weakTimer = nil;
                weakSelf.repeatCount = verifyCodeEffectiveTime;
                [weakSelf.verifyCodeField setActionBtnTitle:@"发送验证码"];
                weakSelf.verifyCodeField.actionBtn.enabled = YES;
                TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.verifyCodeSendError", nil));
                
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

- (void)showPasswordAction:(UIButton*)sender
{
    sender.selected = !sender.selected;
    
    if (sender == self.passwordField.actionBtn) {
        self.passwordField.actionTextField.secureTextEntry = !sender.selected;
    }else if (sender == self.confirmPasswordField.actionBtn){
        self.confirmPasswordField.actionTextField.secureTextEntry = !sender.selected;
    }
    
    
}

- (void)keyboardWillShow:(NSNotification *)notif {
    CGFloat duration = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect      = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (self.confirmBtnInWindowFrame.origin.y == 0) {
        self.confirmBtnInWindowFrame = [self.bgView convertRect:self.confirmBtn.frame toView:self.view.window];
    }
//    CGRect frame = [self.bgView convertRect:self.confirmBtn.frame toView:self.view.window];
    CGFloat space = CGRectGetMinY(rect) - CGRectGetMinY(self.confirmBtnInWindowFrame);
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


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    textField.text = text;
    
    BOOL hasTelephone = [self.phoneNumField.actionTextField.text clearMarginSpace].length > 0;
    BOOL hasVerifyCode = [self.verifyCodeField.actionTextField.text clearMarginSpace].length > 0;
    BOOL hasPassword = [self.passwordField.actionTextField.text clearMarginSpace].length > 0;
    BOOL hasConfirmPassword = [self.confirmPasswordField.actionTextField.text clearMarginSpace].length > 0;
    self.confirmBtn.enabled = (hasTelephone && hasVerifyCode && hasPassword && hasConfirmPassword);
    
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.confirmBtn.enabled = NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneNumField.actionTextField) {
        [self.verifyCodeField.actionTextField becomeFirstResponder];
    }else if (textField == self.verifyCodeField.actionTextField) {
        [self.passwordField.actionTextField becomeFirstResponder];
    }else if (textField == self.passwordField.actionTextField) {
        [self.confirmPasswordField.actionTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        [self confirmChangePasswordAction];
    }
    return YES;
}


#pragma mark -- UI Setters and Getters

- (TCLoginTypeTextField *)phoneNumField
{
    if (!_phoneNumField) {
        _phoneNumField = [[TCLoginTypeTextField alloc] initWithTitle:@"+86" frame:CGRectMake(10, self.titleLab.bottom + 40, BOUND_WIDTH - 20, 45)];
        [_phoneNumField setActionTextFieldPlaceholder:@"请输入您的手机号码" color: [UIColor colorWithUInt:0xc2c2c2]];
        _phoneNumField.actionTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _phoneNumField;
}


- (TCLoginTypeTextField *)verifyCodeField
{
    if (!_verifyCodeField) {
        _verifyCodeField = [[TCLoginTypeTextField alloc] initWithTitle:@"验证码" actionButtonTitle:@"发送验证码" frame:CGRectMake(10, self.phoneNumField.bottom + 1, BOUND_WIDTH - 20, 45)];
        [_verifyCodeField setActionTextFieldPlaceholder:@"请输入您的验证码" color: [UIColor colorWithUInt:0xc2c2c2]];
//        _verifyCodeField.actionTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_verifyCodeField.actionBtn addTarget:self action:@selector(sendVerifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _verifyCodeField;
}

- (TCLoginTypeTextField *)passwordField
{
    if (!_passwordField) {
        _passwordField = [[TCLoginTypeTextField alloc] initWithTitle:@"密码" actionButtonImageName:@"login_eye" frame:CGRectMake(10, self.verifyCodeField.bottom + 1, BOUND_WIDTH - 20, 45)];
        _passwordField.actionTextField.secureTextEntry = YES;
        [_passwordField setActionTextFieldPlaceholder:@"设置新密码" color: [UIColor colorWithUInt:0xc2c2c2]];
        [_passwordField.actionBtn setImage:[UIImage imageNamed:@"login_eye"] forState:UIControlStateNormal];
        [_passwordField.actionBtn setImage:[UIImage imageNamed:@"login_eye_cur"] forState:UIControlStateSelected];
        [_passwordField.actionBtn addTarget:self action:@selector(showPasswordAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _passwordField;
}

- (TCLoginTypeTextField *)confirmPasswordField
{
    if (!_confirmPasswordField) {
        _confirmPasswordField = [[TCLoginTypeTextField alloc] initWithTitle:@"确认密码" actionButtonImageName:@"login_eye" frame:CGRectMake(10, self.passwordField.bottom + 1, BOUND_WIDTH - 20, 45)];
        _confirmPasswordField.actionTextField.secureTextEntry = YES;
        [_confirmPasswordField setActionTextFieldPlaceholder:@"确认新密码" color: [UIColor colorWithUInt:0xc2c2c2]];
        [_confirmPasswordField.actionBtn setImage:[UIImage imageNamed:@"login_eye"] forState:UIControlStateNormal];
        [_confirmPasswordField.actionBtn setImage:[UIImage imageNamed:@"login_eye_cur"] forState:UIControlStateSelected];
        [_confirmPasswordField.actionBtn addTarget:self action:@selector(showPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmPasswordField;
}


- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, BOUND_WIDTH, 40)];
        _titleLab.font = [UIFont systemFontOfSize:28];
        _titleLab.text = @"重置密码";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLab;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, self.confirmPasswordField.bottom + 60, BOUND_WIDTH - 36, 45)];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:[UIColor colorWithUInt:0x10b8d8]];
        _confirmBtn.layer.cornerRadius = 4.0;
        
        [_confirmBtn addTarget:self action:@selector(confirmChangePasswordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmBtn;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, self.view.height)];
        _bgView.backgroundColor = self.view.backgroundColor;
        UIButton *bgBtn = [[UIButton alloc] initWithFrame:_bgView.bounds];
        [bgBtn addTarget:self action:@selector(resignTextFieldFirstResponderAction) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:bgBtn];
    }
    
    return _bgView;
}

@end
