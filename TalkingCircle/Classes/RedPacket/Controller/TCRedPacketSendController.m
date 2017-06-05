//
//  TCRedPacketController.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/23.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCRedPacketSendController.h"

@interface TCRedPacketSendController ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, strong) UITextView *messageTextView;
@property (nonatomic, strong) UILabel *moneyLab;

@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UILabel *tipsLab;
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation TCRedPacketSendController

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
    self.view.backgroundColor = [UIColor colorWithUInt:0xf1f1f1];
    
    [self.view addSubview:self.bgView];
    
    [self.bgView addSubview:self.backBtn];
    
    [self.bgView addSubview:self.moneyTextField];
    [self.bgView addSubview:self.messageTextView];
    [self.bgView addSubview:self.moneyLab];
    [self.bgView addSubview:self.confirmBtn];

}

- (void)initData
{
    self.title = @"发红包";
}

#pragma mark - private Method

- (void)closePage
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)sendRedpacketAction
{
    WEAK_SELF(self, weakSelf);
    [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
        maker.cgiWrap.m_functionId = NetFunc_SendRedpacket;
        maker.cgiWrap.requestMethod = NetRequestMethod_POST;
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:2];
        [param safeSetObject:weakSelf.userId forKey:@"to_user"];
        [param safeSetObject:@"1" forKey:@"amount"];
        
        maker.cgiWrap.param = param;
        
    } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
        if (!err) {
            TCNetBaseData *baseData = [TCNetBaseData initWithJsonDic:responseData];
            if (baseData.success) {
                NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
                [infoDic safeSetObject:[responseData objectForKey:@"order_id"] forKey:@"redPacketId"];
                [weakSelf sendRedpacket:infoDic];
            }else{
                TCAlertNoTitle(baseData.message);
            }
        }else{
            
        }
        
    }];
}

- (void)sendRedpacket:(NSMutableDictionary*)infoDic
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(personalRedpacketSendWithRedpacketInfo:)]) {
        [self.delegate personalRedpacketSendWithRedpacketInfo:infoDic];
    }
}

#pragma mark - UI

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HEIGHT)];
        _bgView.backgroundColor = [UIColor colorWithUInt:0xf1f1f1];
    }
    
    return _bgView;
}

- (UITextField *)moneyTextField
{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, TC_NAV_HEIGHT + 30, BOUND_WIDTH - 40, 60)];
        _moneyTextField.layer.cornerRadius = 6.0f;
        _moneyTextField.layer.borderColor = [UIColor colorWithUInt:0xc2c2c2].CGColor;
        _moneyTextField.layer.borderWidth = 1.0f;
        
        UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, _moneyTextField.height)];
        leftLab.text = @"金额";
        leftLab.font = [UIFont systemFontOfSize:15];
        
        UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, _moneyTextField.height)];
        rightLab.text = @"元";
        rightLab.font = [UIFont systemFontOfSize:15];
        
        _moneyTextField.leftView = leftLab;
        _moneyTextField.rightView = rightLab;
        
        _moneyTextField.leftViewMode = UITextFieldViewModeAlways;
        _moneyTextField.rightViewMode = UITextFieldViewModeAlways;
        
        _moneyTextField.delegate = self;
        
    }
    return _moneyTextField;
}

- (UITextView *)messageTextView
{
    if (!_messageTextView) {
        _messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, self.moneyTextField.bottom + 20, BOUND_WIDTH - 40, 60)];
        _messageTextView.delegate = self;
        _messageTextView.layer.cornerRadius = 6.0f;
        _messageTextView.layer.borderColor = [UIColor colorWithUInt:0xc2c2c2].CGColor;
        _messageTextView.layer.borderWidth = 1.0f;
        
    }
    
    return _messageTextView;
}

- (UILabel *)moneyLab
{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(20, self.messageTextView.bottom + 10, BOUND_WIDTH - 40, 30)];
        _moneyLab.text = @"￥ 0.00";
        _moneyLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _moneyLab;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewObjectInMiddleOriginX(200), self.moneyLab.bottom + 10, 200, 40)];
        [_confirmBtn setTitle:@"塞钱进红包" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = 4.0f;
        [_confirmBtn setBackgroundColor:[UIColor redColor]];
        [_confirmBtn addTarget:self action:@selector(sendRedpacketAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmBtn;
}

- (UILabel *)tipsLab
{
    if (!_tipsLab) {
        _tipsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _tipsLab;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10,20,50,30)];
        [_backBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return  _backBtn;
}


@end
