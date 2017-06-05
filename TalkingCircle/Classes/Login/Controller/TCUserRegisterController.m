//
//  TCUserRegisterController.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/15.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCUserRegisterController.h"
#import "TCLoginTypeTextField.h"
#import "TCVerifyCodeSendRequest.h"
#import "TCUserLoginInfo.h"
#import "EMClientUserLoginRequest.h"
#import "HWWeakTimer.h"

@interface TCUserRegisterController ()
{
    TCVerifyCodeSendRequest *verifyCodeSendRequest;
}

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) TCLoginTypeTextField *nickNameField;
@property (nonatomic, strong) TCLoginTypeTextField *phoneNumField;
@property (nonatomic, strong) TCLoginTypeTextField *verifyCodeField;
@property (nonatomic, strong) TCLoginTypeTextField *inviteCodeField;
@property (nonatomic, strong) TCLoginTypeTextField *passwordField;
@property (nonatomic, strong) TCLoginTypeTextField *confirmPasswordField;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UILabel *remindTips;

@property (nonatomic, assign) CGRect registerBtnInWindowFrame;

@property (nonatomic, strong) NSTimer *weakTimer;
@property (nonatomic, assign) int repeatCount;

@end


@implementation TCUserRegisterController

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
    
    [self.bgView addSubview:self.nickNameField];
    [self.bgView addSubview:self.phoneNumField];
    [self.bgView addSubview:self.verifyCodeField];
    [self.bgView addSubview:self.passwordField];
    [self.bgView addSubview:self.confirmPasswordField];
    [self.bgView addSubview:self.inviteCodeField];
    
    [self.bgView addSubview:self.confirmBtn];
    [self.bgView addSubview:self.remindTips];
    
}

- (void)initData
{
    self.title = @"注册";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    verifyCodeSendRequest = [[TCVerifyCodeSendRequest alloc] init];
    
    self.repeatCount = verifyCodeEffectiveTime;
}

#pragma mark -- Private Method

- (void)resignTextFieldFirstResponderAction
{
    [self.phoneNumField.actionTextField resignFirstResponder];
    [self.nickNameField.actionTextField resignFirstResponder];
    [self.verifyCodeField.actionTextField resignFirstResponder];
    [self.passwordField.actionTextField resignFirstResponder];
    [self.confirmPasswordField.actionTextField resignFirstResponder];
    [self.inviteCodeField.actionTextField resignFirstResponder];
}

- (void)confirmRegisterAction
{
    if (![self registerCheck]) {
        return;
    }
    
    [self showHudInView:self.bgView hint:@"正在注册..."];
    
    WEAK_SELF(self, weakSelf);
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_UserRigster;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic safeSetObject:weakSelf.phoneNumField.actionTextField.text forKey:@"mobile"];
        [dic safeSetObject:weakSelf.nickNameField.actionTextField.text forKey:@"nickname"];
        [dic safeSetObject:[weakSelf.passwordField.actionTextField.text md5String] forKey:@"password"];
        [dic safeSetObject:weakSelf.verifyCodeField.actionTextField.text forKey:@"mobile_code"];
        [dic safeSetObject:weakSelf.inviteCodeField.actionTextField.text forKey:@"invitation"];
        
        maker.cgiWrap.param = dic;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        
        TCNetBaseData *baseData = [TCNetBaseData initWithJsonDic:responseData];
        
        if (!err) {

            if (baseData.success) {
                [[TCUserLoginInfo shareInstance] updateToken:[responseData objectForKey:@"token"]];
                [[TCUserLoginInfo shareInstance] updateUserName:weakSelf.phoneNumField.actionTextField.text];
                [[TCUserLoginInfo shareInstance] updatePasswordMd5:[weakSelf.passwordField.actionTextField.text md5String]];
                
                [[EMClientUserLoginRequest shareInstance] loginWithUsername:weakSelf.phoneNumField.actionTextField.text password:[TCUserLoginInfo shareInstance].passwordMd5 callBack:^(NSError *err, id responseData, NSDictionary *ext) {
                    
                    [weakSelf hideHud];
                    if(!err){
        
                    }else{
                        TCAlertNoTitle(@"登录失败，请重新登录！");
                    }
                    
                    
                }];
            }else{
                TCAlertNoTitle(baseData.message);
            }
            
        
        }else{
            [weakSelf hideHud];
            TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.registerError", nil));
        }
    }];
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
    
    [verifyCodeSendRequest sendVerifyCodeWithPhoneNum:self.phoneNumField.actionTextField.text sendType:VerifyCodeSendType_Register callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        
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

- (void)showPasswordAction:(UIButton*)sender
{
    sender.selected = !sender.selected;
    
    if (sender == self.passwordField.actionBtn) {
        self.passwordField.actionTextField.secureTextEntry = !sender.selected;
    }else if (sender == self.confirmPasswordField.actionBtn){
        self.confirmPasswordField.actionTextField.secureTextEntry = !sender.selected;
    }
    
    
}

- (BOOL)registerCheck
{
    NSString *nickName = [self.nickNameField.actionTextField.text clearMarginSpace];
    NSString *phoneNum = [self.phoneNumField.actionTextField.text clearMarginSpace];
    NSString *verifyCode = [self.verifyCodeField.actionTextField.text clearMarginSpace];
    NSString *confirmPassword = [self.confirmPasswordField.actionTextField.text clearMarginSpace];
    NSString *password = [self.passwordField.actionTextField.text clearMarginSpace];
    
   
    if (nickName.length <= 0 || nickName.length > 20) {
         TCAlertNoTitle(NSLocalizedString(@"TC.login.alertMessage.nickNameError", nil));
        return NO;
    }
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

- (void)keyboardWillShow:(NSNotification *)notif {
    
    if(self.nickNameField.actionTextField.isFirstResponder){
        self.bgView.y = 0;
        return;
    }
    
    CGFloat duration = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect      = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (self.registerBtnInWindowFrame.origin.y == 0) {
        self.registerBtnInWindowFrame = [self.bgView convertRect:self.confirmBtn.frame toView:self.view.window];
    }
    //    CGRect frame = [self.bgView convertRect:self.confirmBtn.frame toView:self.view.window];
    CGFloat space = CGRectGetMinY(rect) - CGRectGetMinY(self.registerBtnInWindowFrame);
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


#pragma mark -- UI Setters and Getters

- (TCLoginTypeTextField *)nickNameField
{
    if (!_nickNameField) {
        _nickNameField = [[TCLoginTypeTextField alloc] initWithTitle:@"昵称" frame:CGRectMake(10, self.titleLab.bottom + 40, BOUND_WIDTH - 20, 45)];
        [_nickNameField setActionTextFieldPlaceholder:@"昵称不能超过20个字符" color:[UIColor colorWithUInt:0xc2c2c2]];
       
    }
    return _nickNameField;
}


- (TCLoginTypeTextField *)phoneNumField
{
    if (!_phoneNumField) {
        _phoneNumField = [[TCLoginTypeTextField alloc] initWithTitle:@"+86" frame:CGRectMake(10, self.nickNameField.bottom + 1, BOUND_WIDTH - 20, 45)];
        [_phoneNumField setActionTextFieldPlaceholder:@"请输入您的手机号码" color:[UIColor colorWithUInt:0xc2c2c2]];
    }
    
    return _phoneNumField;
}

- (TCLoginTypeTextField *)verifyCodeField
{
    if (!_verifyCodeField) {
        _verifyCodeField = [[TCLoginTypeTextField alloc] initWithTitle:@"验证码" actionButtonTitle:@"发送验证码" frame:CGRectMake(10, self.phoneNumField.bottom + 1, BOUND_WIDTH - 20, 45)];
         [_verifyCodeField setActionTextFieldPlaceholder:@"请输入您的验证码" color:[UIColor colorWithUInt:0xc2c2c2]];
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
        [_passwordField setActionTextFieldPlaceholder:@"请输入密码" color:[UIColor colorWithUInt:0xc2c2c2]];
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
        _confirmPasswordField.actionTextField.placeholder = @"请再次输入密码";
        _confirmPasswordField.actionTextField.secureTextEntry = YES;
        [_confirmPasswordField setActionTextFieldPlaceholder:@"请再次输入密码" color:[UIColor colorWithUInt:0xc2c2c2]];
        [_confirmPasswordField.actionBtn setImage:[UIImage imageNamed:@"login_eye"] forState:UIControlStateNormal];
        [_confirmPasswordField.actionBtn setImage:[UIImage imageNamed:@"login_eye_cur"] forState:UIControlStateSelected];
        [_confirmPasswordField.actionBtn addTarget:self action:@selector(showPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmPasswordField;
}

- (TCLoginTypeTextField *)inviteCodeField
{
    if (!_inviteCodeField) {
        _inviteCodeField = [[TCLoginTypeTextField alloc] initWithTitle:@"邀请码" frame:CGRectMake(10, self.confirmPasswordField.bottom + 1, BOUND_WIDTH - 20, 45)];
        [_inviteCodeField setActionTextFieldPlaceholder:@"请输入您的邀请码（选填）" color:[UIColor colorWithUInt:0xc2c2c2]];
    }
    
    return _inviteCodeField;
}

- (UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, BOUND_WIDTH, 40)];
        _titleLab.text = @"新用户注册";
        _titleLab.font = [UIFont systemFontOfSize:28];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLab;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, self.inviteCodeField.bottom + 60, BOUND_WIDTH - 36, 45)];
        [_confirmBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:[UIColor colorWithUInt:0x10b8d8]];
        _confirmBtn.layer.cornerRadius = 4.0;
        
        [_confirmBtn addTarget:self action:@selector(confirmRegisterAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmBtn;
}

- (UILabel *)remindTips
{
    if (!_remindTips) {
        _remindTips = [[UILabel alloc] initWithFrame:CGRectMake(self.confirmBtn.left, self.confirmBtn.bottom + 5, self.confirmBtn.width, 28)];
        _remindTips.numberOfLines = 2;
        _remindTips.textColor = [UIColor colorWithUInt:0xc2c2c2];
        _remindTips.font = [UIFont systemFontOfSize:12];
        
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"使用淘支付，就表示你同意淘支付的使用条款"];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithUInt:0xc2c2c2] range:NSMakeRange(0, title.length - 5)];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithUInt:0x10b8d8] range:NSMakeRange(title.length - 4, 4)];
        
        _remindTips.attributedText = title;
        
        CGSize titleSize = [_remindTips.text boundingRectWithSize:CGSizeMake(self.confirmBtn.width, 40) font:_remindTips.font text:_remindTips.text];
        if (titleSize.width < _remindTips.width) {
            _remindTips.height = 14;
        }
    }
    
    return _remindTips;
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
