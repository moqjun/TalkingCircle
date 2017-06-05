//
//  TCGroupNicknameController.m
//  TalkingCircle
//
//  Created by iMac on 2017/5/5.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCGroupNicknameController.h"

@interface TCGroupNicknameController ()

@property (nonatomic,weak) UITextField *nickNameField;

@end

@implementation TCGroupNicknameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    [self addCustomViewAndItem];
    
}

-(void)addCustomViewAndItem
{
    //field
    UITextField *field =[[UITextField alloc] initWithFrame:CGRectMake(10, 30, WIDTH_SCREEN-10, 30)];
    field.font = [UIFont systemFontOfSize:14];
    field.backgroundColor = [UIColor whiteColor];
    field.placeholder =self.isEditGroupNickNamed? @"请输入昵称":@"群组名称";
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nickNameField = field;
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 30, WIDTH_SCREEN-10, 30)];
    imageView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:imageView];
    [self.view addSubview:field];
    
    
    
    //barItem
    
    UIButton *saveBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:DEFAULT_MAIN_COLOR forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveNickName:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark 保存修改的数据
-(void)saveNickName:(UIButton *) btn
{
    NSLog(@"nickname:%@",self.nickNameField.text);
    
    NSString *nickName = self.nickNameField.text;
    
    if(nickName.length > 0)
    {
        //设置推送设置
        [self showHint:NSLocalizedString(@"setting.saving", "saving...")];
        
        WEAK_SELF(self, weakSelf);
        
        
        if (self.isEditGroupNickNamed)
        {
            //修改在群组显示昵称
        }
        else
        {
            //修改群组名称
            
        }
        
        [[NetServiceUtils shareInstance] tcMakeRequestWithBuilder:^(NetServiceMaker *maker) {
            maker.cgiWrap.m_functionId = NetFunc_EditNickName;
            maker.cgiWrap.requestMethod = NetRequestMethod_POST;
            
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
            [params safeSetObject:nickName forKey:@"nickname"];
            
            maker.cgiWrap.param = params;
            
        } callBack:^(NSError *err, id responseData, NSDictionary *ext) {
            
            if (!err)
            {
                [weakSelf hideHud];
                NSNumber *statusNum =[responseData objectForKey:@"status"];
                if ([statusNum integerValue] == ServiceNetStatusCode_OK)
                {
                    [weakSelf showHint:@"修改成功"];
                    [EaseCommonUserDefault setUserInformation:nickName forKey:@"nickname"];
                    self.block(nickName);
                    self.block = nil;
                }
            }
        }];
        
    }
    else
    {
        [self showHint:@"编辑框输入内容不能为空"];
    }
    
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
