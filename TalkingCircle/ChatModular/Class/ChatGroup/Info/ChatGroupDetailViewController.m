/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "ChatGroupDetailViewController.h"

#import "ContactSelectionViewController.h"
#import "GroupSettingViewController.h"
#import <Hyphenate/EMGroup.h>
#import "ContactView.h"
#import "GroupSubjectChangingViewController.h"
#import "SearchMessageViewController.h"
#import "EMGroupAdminsViewController.h"
#import "EMGroupMembersViewController.h"
#import "EMGroupMutesViewController.h"
#import "EMGroupBansViewController.h"

#import "TCGroupNicknameController.h"
#import "TCGroupNoticeController.h"
#import "TopViewController.h"

#import "MQSetting.h"


#pragma mark - ChatGroupDetailViewController

#define kColOfRow 5
#define kContactSize 60

#define ALERTVIEW_CHANGEOWNER 100

@interface ChatGroupDetailViewController ()<EMGroupManagerDelegate, EMChooseViewDelegate, UIAlertViewDelegate,TopViewControllerDelagate>

- (void)unregisterNotifications;
- (void)registerNotifications;

@property (strong, nonatomic) EMGroup *chatGroup;

@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIButton *deleteButton;

@property (strong, nonatomic) UIButton *configureButton;

@property (strong, nonatomic) ContactView *selectedContact;

@property (strong, nonatomic) TopViewController *topVC;
@property (strong, nonatomic) NSMutableArray *groupHeads;





- (void)configureAction;

@end

@implementation ChatGroupDetailViewController

- (instancetype)initWithGroup:(EMGroup *)chatGroup
{
    self = [super init];
    if (self) {
        // Custom initialization
        _chatGroup = chatGroup;
    }
    return self;
}

- (instancetype)initWithGroupId:(NSString *)chatGroupId
{
    EMGroup *chatGroup = nil;
    NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
    for (EMGroup *group in groupArray) {
        if ([group.groupId isEqualToString:chatGroupId]) {
            chatGroup = group;
            break;
        }
    }
    
    if (chatGroup == nil) {
        chatGroup = [EMGroup groupWithId:chatGroupId];
    }
    
    self = [self initWithGroup:chatGroup];
    if (self) {
        //
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"群详情";
    
    self.groupHeads = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"UpdateGroupDetail" object:nil];
    [self registerNotifications];
    
    [self getChatGroupDetailVCItems];
    [self initCustomBarItemAndView];
    
    [self fetchGroupInfo];
}

-(void) initCustomBarItemAndView
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.accessibilityIdentifier = @"back";
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    //[self.navigationItem setLeftBarButtonItem:backItem];
    
    
    _topVC=[[TopViewController alloc]initWithNibName:@"TopViewController" bundle:nil];
    _topVC.delagate=self;
    _topVC.view.frame=CGRectMake(0, 0, WIDTH_SCREEN, 90);
    if (self.chatGroup.permissionType == EMGroupPermissionTypeMember)
    {
         _topVC.isGroupMember=YES;
    }
   
    self.tableView.tableHeaderView=_topVC.view;
    
    self.tableView.tableFooterView = self.footerView;
    
}

-(void) getChatGroupDetailVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    MQSettingItem *groupName = [MQSettingItem createWithTitle:@"群聊名称" subTitle:@""];
     MQSettingItem *code = [MQSettingItem createWithImageName:nil title:@"二维码" subTitle:nil rightImageName:@"qd"];
    
    MQSettingItem *nickName = [MQSettingItem createWithTitle:@"我在本群的昵称" subTitle:@""];
    MQSettingItem *groupNotice = [MQSettingItem createWithTitle:@"群公告" subTitle:@"未设置"];
   
    
    MQSettingGrounp *frist = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:groupName, code, nickName, groupNotice, nil];
    [items addObject:frist];
    
    MQSettingItem *msgFree = [MQSettingItem createWithTitle:@"消息免打扰"];
     msgFree.type = MQSettingItemTypeSwitch;
    MQSettingItem *msgTop = [MQSettingItem createWithTitle:@"消息置顶"];
     msgTop.type = MQSettingItemTypeSwitch;
    MQSettingGrounp *second = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:msgFree, msgTop, nil];
    [items addObject:second];
    
    MQSettingItem *findChatRecord = [MQSettingItem createWithTitle:@"查找聊天记录"];
    
    MQSettingItem *setChatBg = [MQSettingItem createWithTitle:@"设置当前聊天背景"];
     MQSettingItem *complain = [MQSettingItem createWithTitle:@"投诉"];
    
    MQSettingGrounp *three = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:findChatRecord, setChatBg,complain, nil];
    [items addObject:three];
    
    MQSettingItem *clearChatRecord = [MQSettingItem createWithTitle:@"清空聊天记录"];
    
    MQSettingGrounp *four = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:clearChatRecord, nil];
    [items addObject:four];
    
    self.data = items;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    [self unregisterNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerNotifications {
    [self unregisterNotifications];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}

- (void)unregisterNotifications {
    [[EMClient sharedClient].groupManager removeDelegate:self];
}

#pragma mark - getter

- (UIButton *)deleteButton
{
    if (_deleteButton == nil) {
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.accessibilityIdentifier = @"clear_message";
        [_deleteButton setTitle:@"删除并退出" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAndQuitAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.layer.cornerRadius = 5;
        [_deleteButton setBackgroundColor:[UIColor redColor]];
    }
    
    return _deleteButton;
}


- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        self.deleteButton.frame = CGRectMake(20, 10, _footerView.frame.size.width - 40, 35);
        [_footerView addSubview:self.deleteButton];
        
        
    }
    
    return _footerView;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    if (self.chatGroup.permissionType == EMGroupPermissionTypeOwner || self.chatGroup.permissionType == EMGroupPermissionTypeAdmin) {
//        return 9;
//    }
//    else {
//        return 7;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    // Configure the cell...
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
//    }
//    
//    if (indexPath.row == 0) {
//        cell.textLabel.text = NSLocalizedString(@"group.id", @"group ID");
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.detailTextLabel.text = _chatGroup.groupId;
//    }
//    else if (indexPath.row == 1) {
//        cell.textLabel.text = NSLocalizedString(@"title.groupSetting", @"Group Setting");
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    else if (indexPath.row == 2) {
//        cell.textLabel.text = NSLocalizedString(@"title.groupSubjectChanging", @"Change group name");
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    else if (indexPath.row == 3) {
//        cell.textLabel.text = NSLocalizedString(@"title.groupSearchMessage", @"Search Message from History");
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    else if (indexPath.row == 4) {
//        cell.textLabel.text = NSLocalizedString(@"group.owner", @"Owner");
//        
//        cell.detailTextLabel.text = self.chatGroup.owner;
//        
//        if (self.chatGroup.permissionType == EMGroupPermissionTypeOwner) {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        else {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
//    }
//    else if (indexPath.row == 5) {
//        cell.textLabel.text = NSLocalizedString(@"group.admins", @"Admins");
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", (int)[self.chatGroup.adminList count]];
//    }
//    else if (indexPath.row == 6) {
//        cell.textLabel.text = NSLocalizedString(@"group.members", @"Members");
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%i / %i", (int)(self.chatGroup.occupantsCount - 1 - [self.chatGroup.adminList count]), (int)self.chatGroup.setting.maxUsersCount];
//        NSLog([NSString stringWithFormat:@"111111=========%ld", (long)self.chatGroup.occupantsCount]);
//    }
//    else if (indexPath.row == 7) {
//        cell.textLabel.text = NSLocalizedString(@"group.mutes", @"Mutes");
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    else if (indexPath.row == 8) {
//        cell.textLabel.text = NSLocalizedString(@"title.groupBlackList", @"Black list");
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    
//    return cell;
//}
//
//#pragma mark - Table view delegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                TCGroupNicknameController *nickVC =[[TCGroupNicknameController alloc] init];
                nickVC.title =@"群聊名称";
                [self.navigationController pushViewController:nickVC animated:YES];
                break;
            }
            case 1:
            {
                break;
            }
            case 2:
            {
                TCGroupNicknameController *nickVC =[[TCGroupNicknameController alloc] init];
                nickVC.title =@"修改昵称";
                nickVC.isEditGroupNickNamed = YES;
                [self.navigationController pushViewController:nickVC animated:YES];
                break;
            }
            case 3:
            {
                TCGroupNoticeController *noticeVC =[[TCGroupNoticeController alloc] init];
                [self.navigationController pushViewController:noticeVC animated:YES];
                break;
            }
        }
    }
}

#pragma mark - UIAlertViewDelegate

//弹出提示的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView cancelButtonIndex] == buttonIndex) {
        return;
    }
    
    if (alertView.tag == ALERTVIEW_CHANGEOWNER) {
        //获取文本输入框
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString *newOwner = textField.text;
        if ([newOwner length] > 0) {
            EMError *error = nil;
            [self showHudInView:self.view hint:@"Hold on ..."];
            self.chatGroup = [[EMClient sharedClient].groupManager updateGroupOwner:self.chatGroup.groupId newOwner:newOwner error:&error];
            [self hideHud];
            if (error) {
                [self showHint:NSLocalizedString(@"group.changeOwnerFail", @"Failed to change owner")];
            } else {
                [self.tableView reloadData];
            }
        }
        
    }
}

#pragma mark - EMChooseViewDelegate

- (BOOL)viewController:(EMChooseViewController *)viewController didFinishSelectedSources:(NSArray *)selectedSources
{
    NSInteger maxUsersCount = self.chatGroup.setting.maxUsersCount;
    if (([selectedSources count] + self.chatGroup.membersCount) > maxUsersCount) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"group.maxUserCount", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        [alertView show];
        
        return NO;
    }
    
    [self showHudInView:self.view hint:NSLocalizedString(@"group.addingOccupant", @"add a group member...")];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *source = [NSMutableArray array];
        for (NSString *username in selectedSources) {
            [source addObject:username];
        }
        
        NSString *username = [[EMClient sharedClient] currentUsername];
        NSString *messageStr = [NSString stringWithFormat:NSLocalizedString(@"group.somebodyInvite", @"%@ invite you to join group \'%@\'"), username, weakSelf.chatGroup.subject];
        EMError *error = nil;
        weakSelf.chatGroup = [[EMClient sharedClient].groupManager addOccupants:source toGroup:weakSelf.chatGroup.groupId welcomeMessage:messageStr error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [weakSelf reloadDataSource];
            }
            else {
                [weakSelf hideHud];
                [weakSelf showHint:error.errorDescription];
            }
        
        });
    });
    
    return YES;
}

#pragma mark - EMGroupManagerDelegate

- (void)groupInvitationDidAccept:(EMGroup *)aGroup
                         invitee:(NSString *)aInvitee
{
    if ([aGroup.groupId isEqualToString:self.chatGroup.groupId]) {
        [self fetchGroupInfo];
    }
}

#pragma mark - data



- (void)fetchGroupInfo
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:self.view hint:NSLocalizedString(@"loadData", @"Load data...")];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        EMError *error = nil;
        EMGroup *group = [[EMClient sharedClient].groupManager getGroupSpecificationFromServerWithId:weakSelf.chatGroup.groupId error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
//            [weakSelf tableViewDidFinishTriggerHeader:YES reload:NO];
        });
        
        if (!error) {
            weakSelf.chatGroup = group;
            EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:group.groupId type:EMConversationTypeGroupChat createIfNotExist:YES];
            if ([group.groupId isEqualToString:conversation.conversationId]) {
                NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                [ext setObject:group.subject forKey:@"subject"];
                [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                conversation.ext = ext;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf reloadDataSource];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf showHint:NSLocalizedString(@"group.fetchInfoFail", @"failed to get the group details, please try again later")];
            });
        }
    });
}

- (void)reloadDataSource
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.chatGroup.permissionType == EMGroupPermissionTypeOwner || self.chatGroup.permissionType == EMGroupPermissionTypeAdmin || self.chatGroup.setting.style == EMGroupStylePrivateMemberCanInvite) {
            
        } else {
        }
        
        if (self.chatGroup.occupants.count)
        {
            
            [self addBtnClick:self.chatGroup.occupants];
        }
        
        [self.tableView reloadData];
        [self refreshFooterView];
        [self hideHud];
    });
}

- (void)refreshFooterView
{
    NSLog(@"occupants:%@",self.chatGroup.occupants);
    
    if (self.chatGroup.permissionType == EMGroupPermissionTypeOwner) {
       
        [self.deleteButton setTitle:@"删除并退出群组" forState:UIControlStateNormal];
    }
    else{
        [self.deleteButton setTitle:@"退出群组" forState:UIControlStateNormal];
    }
}

#pragma mark - action

- (void)updateUI:(NSNotification *)aNotif
{
    id obj = aNotif.object;
    if (obj && [obj isKindOfClass:[EMGroup class]]) {
        self.chatGroup = (EMGroup *)obj;
        [self reloadDataSource];
    }
}


#pragma mark 添加成员

- (void)addMemberButtonAction
{
    NSMutableArray *occupants = [[NSMutableArray alloc] init];
    [occupants addObject:self.chatGroup.owner];
    [occupants addObjectsFromArray:self.chatGroup.adminList];
    [occupants addObjectsFromArray:self.chatGroup.memberList];
    
    ContactSelectionViewController *selectionController = [[ContactSelectionViewController alloc] initWithBlockSelectedUsernames:occupants];
    selectionController.isAddGroupMember = YES;
    selectionController.delegate = self;
    [self.navigationController pushViewController:selectionController animated:YES];
}

//清空聊天记录

-(void) deleteAllChatMessage
{
    __weak typeof(self) weakSelf = self;
    [EMAlertView showAlertWithTitle:NSLocalizedString(@"prompt", @"Prompt")
                            message:NSLocalizedString(@"sureToDelete", @"please make sure to delete")
                    completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
                        if (buttonIndex == 1) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveAllMessages" object:weakSelf.chatGroup.groupId];
                        }
                    } cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
                  otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
}

//设置群组
- (void)configureAction {
    // todo
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        [[EMClient sharedClient].groupManager ignoreGroupPush:weakSelf.chatGroup.groupId ignore:weakSelf.chatGroup.isPushNotificationEnabled];
    });
}


/*
 *如果当前用户是群主，删除并退出群组（解散群组）
 *如果当前用户是群成员，退出群组
*/

- (void)deleteAndQuitAction
{
   if(self.chatGroup.permissionType == EMGroupPermissionTypeOwner)
   {
       [self dissolveAction];
   }
   else
   {
       [self exitAction];
   }
    
}

//解散群组
- (void)dissolveAction
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:self.view hint:NSLocalizedString(@"group.destroy", @"dissolution of the group")];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        EMError *error = [[EMClient sharedClient].groupManager destroyGroup:weakSelf.chatGroup.groupId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
            if (error) {
                [weakSelf showHint:NSLocalizedString(@"group.destroyFail", @"dissolution of group failure")];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitChat" object:nil];
            }
        });
    });
}

//退出群组
- (void)exitAction
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:self.view hint:NSLocalizedString(@"group.leave", @"quit the group")];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        EMError *error = nil;
        [[EMClient sharedClient].groupManager leaveGroup:weakSelf.chatGroup.groupId error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
            if (error) {
                [weakSelf showHint:NSLocalizedString(@"group.leaveFail", @"exit the group failure")];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitChat" object:nil];
            }
        });
    });
}

- (void)didIgnoreGroupPushNotification:(NSArray *)ignoredGroupList error:(EMError *)error {
    // todo
    NSLog(@"ignored group list:%@.", ignoredGroupList);
}

#pragma  mark topview delagate 邀请加群;
-(void)addBtnClick:(NSArray *) addArray
{
    NSLog(@"add btn click!");
    if (addArray == nil)
    {
//        PersonModel *model=[[PersonModel alloc]init];
//        int randInt = arc4random() % 100;
//        NSString *randomfid=[NSString stringWithFormat:@"%d",randInt];
//        model.friendId=randomfid;
//        model.userName=[NSString stringWithFormat:@"名称%ld",self.groupHeads.count];
//        model.txicon=[UIImage imageNamed:@"qq3"];
//        [_topVC addOneTximg:model];
//        
//        [self.groupHeads addObject:model];
        [self addMemberButtonAction];
    }
    else
    {
        for (NSString *name in addArray)
        {
            PersonModel *model=[[PersonModel alloc]init];
            int randInt = arc4random() % 100;
            NSString *randomfid=[NSString stringWithFormat:@"%d",randInt];
            model.friendId=randomfid;
            model.userName= name;
            model.txicon=[UIImage imageNamed:@"qq3"];
            [_topVC addOneTximg:model];
             [self.groupHeads addObject:model];
        }
        
        
    }
    
    [self setTopViewFrame:self.groupHeads];
   
}

#pragma  mark delagate 点击进入编辑模式
-(void)subBtnClick:(NSArray*) delArray
{
    NSMutableArray *occupants = [[NSMutableArray alloc] init];
//    [occupants addObject:self.chatGroup.owner];
    [occupants addObjectsFromArray:self.chatGroup.adminList];
    [occupants addObjectsFromArray:self.chatGroup.memberList];
    
    ContactSelectionViewController *selectionController = [[ContactSelectionViewController alloc] initWithBlockSelectedUsernames:occupants];
    
    selectionController.delegate = self;
    [self.navigationController pushViewController:selectionController animated:YES];
}

// 设置topview的高度变化
-(void)setTopViewFrame:(NSArray*)allP
{
    int lie=0;
    if(WIDTH_SCREEN>320)
    {
        lie=5;
    }else
    {
        lie=4;
    }
    int Allcount=allP.count+2;
    int line=Allcount/lie;
    if(Allcount%lie>0)
        line++;
    _topVC.view.frame=CGRectMake(0, 0, WIDTH_SCREEN, line*90);
    self.tableView.tableHeaderView=_topVC.view;
}


@end
