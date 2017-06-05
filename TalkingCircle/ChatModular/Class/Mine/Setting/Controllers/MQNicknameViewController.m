//
//  MQNicknameViewController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQNicknameViewController.h"
#import "UserProfileManager.h"

@interface MQNicknameViewController ()

@property (nonatomic,weak) UITextField *nickNameField;

@end

@implementation MQNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.title = @"昵称";
    
    [self addCustomViewAndItem];
    
}

-(void)addCustomViewAndItem
{
    //field
    UITextField *field =[[UITextField alloc] initWithFrame:CGRectMake(10, 30, WIDTH_SCREEN-10, 30)];
    field.font = [UIFont systemFontOfSize:14];
    field.backgroundColor = [UIColor whiteColor];
    field.placeholder = @"请输入昵称";
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nickNameField = field;
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 30, WIDTH_SCREEN-10, 30)];
    imageView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:imageView];
    [self.view addSubview:field];
    
    //label
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(10, 65, WIDTH_SCREEN-10, 20)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    label.text = @"填写昵称方便他人认识你";
   
    [self.view addSubview:label];
    
    //barItem
    
    UIButton *saveBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveNickName:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark 保存修改的昵称数据
-(void)saveNickName:(UIButton *) btn
{
    NSLog(@"nickname:%@",self.nickNameField.text);
    
    NSString *nickName = self.nickNameField.text;
    
    if(nickName.length > 0)
    {
        //设置推送设置
        [self showHint:NSLocalizedString(@"setting.saving", "saving...")];
        
        WEAK_SELF(self, weakSelf);
        
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
