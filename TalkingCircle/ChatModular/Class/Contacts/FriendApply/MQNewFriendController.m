//
//  MQNewFriendController.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQNewFriendController.h"

#import "ChatViewController.h"
#import "UserProfileManager.h"
#import "AddFriendViewController.h"
#import "MQNewFriendCell.h"

#import "InvitationManager.h"
#import "RealtimeSearchUtil.h"

#import "BaseTableViewCell.h"
#import "UIViewController+SearchController.h"

@interface MQNewFriendController ()<MQNewFriendCellDelegate,EMSearchControllerDelegate>

@property (nonatomic,strong) NSMutableArray *friendsSource;

@end

@implementation MQNewFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的朋友";
    self.friendsSource = [NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self addFriendBarButtonItem];
    [self setupSearchController];
    
    [self loadDataSourceFromLocalDB];
}

-(void) addFriendBarButtonItem
{
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [addButton setImage:[UIImage imageNamed:@"add-friend"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(doAddFriend:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem =item;
}

- (void)loadDataSourceFromLocalDB
{
    [_friendsSource removeAllObjects];
    NSString *loginName = [EMClient sharedClient].currentUsername;
    if(loginName && [loginName length] > 0)
    {
        NSArray * applyArray = [[InvitationManager sharedInstance] applyEmtitiesWithloginUser:loginName];
        [self.friendsSource addObjectsFromArray:applyArray];
        
        [self.tableView reloadData];
    }
}


- (void)setupSearchController
{
    [self enableSearchController];
    
    __weak MQNewFriendController *weakSelf = self;
    [self.resultController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        static NSString *CellIdentifier = @"BaseTableViewCell";
        BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSString *buddy = [weakSelf.resultController.displaySource objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"ic_head"];
        cell.textLabel.text = buddy;
        cell.username = buddy;
        
        return cell;
    }];
    
    [self.resultController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 50;
    }];
    
    [self.resultController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSString *buddy = [weakSelf.resultController.displaySource objectAtIndex:indexPath.row];
        [weakSelf.searchController.searchBar endEditing:YES];
        
#ifdef REDPACKET_AVALABLE
        RedPacketChatViewController *chatVC = [[RedPacketChatViewController alloc] initWithConversationChatter:buddy conversationType:EMConversationTypeChat];
#else
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:buddy
                                                                            conversationType:EMConversationTypeChat];
#endif
        chatVC.title = [[UserProfileManager sharedInstance] getNickNameWithUsername:buddy];
        [weakSelf.navigationController pushViewController:chatVC animated:YES];
        
        [weakSelf cancelSearch];
    }];
    
    UISearchBar *searchBar = self.searchController.searchBar;
    self.tableView.tableHeaderView = searchBar;
    [searchBar sizeToFit];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.friendsSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MQNewFriendCell *cell = [MQNewFriendCell newFriendWithTableView:tableView];
    
    if(self.friendsSource.count > indexPath.row)
    {
        ApplyEntity *entity = [self.friendsSource objectAtIndex:indexPath.row];
        if (entity) {
            cell.indexPath = indexPath;
            cell.delegate = self;
            cell.entityObject = entity;
        }
    }

    
    return cell;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    [label setText:@"我的朋友"];
    [contentView addSubview:label];
    return contentView;

}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark

-(void)friendCellAddFriendAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void) friendCellAcceptFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.friendsSource count]) {
        [self showHudInView:self.view hint:NSLocalizedString(@"sendingApply", @"sending apply...")];
        
        ApplyEntity *entity = [self.friendsSource objectAtIndex:indexPath.row];
        //ApplyStyle applyStyle = [entity.style intValue];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error;
//            if (applyStyle == ApplyStyleGroupInvitation) {
//                [[EMClient sharedClient].groupManager acceptInvitationFromGroup:entity.groupId inviter:entity.applicantUsername error:&error];
//            }
//            else if (applyStyle == ApplyStyleJoinGroup)
//            {
//                error = [[EMClient sharedClient].groupManager acceptJoinApplication:entity.groupId applicant:entity.applicantUsername];
//            }
//            else if(applyStyle == ApplyStyleFriend){
                error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:entity.applicantUsername];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHud];
                if (!error) {
//                    [self.dataSource removeObject:entity];
                    NSString *loginUsername = [[EMClient sharedClient] currentUsername];
                    [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
                    entity.hasAccept = YES;
                    [self.tableView reloadData];
                }
                else{
                    [self showHint:NSLocalizedString(@"acceptFail", @"accept failure")];
                }
            });
        });
    }
}

#pragma mark - EMSearchControllerDelegate

- (void)cancelButtonClicked
{
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
}

- (void)searchTextChangeWithString:(NSString *)aString
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"aString:%@",aString);
//    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:nil searchText:aString collationStringSelector:@selector(showName) resultBlock:^(NSArray *results) {
//        if (results) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.resultController.displaySource removeAllObjects];
//                [weakSelf.resultController.displaySource addObjectsFromArray:results];
//                [weakSelf.resultController.tableView reloadData];
//            });
//        }
//    }];
}


#pragma mark -  添加朋友

-(void)doAddFriend:(UIButton *) btn
{
    AddFriendViewController *addController = [[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:addController animated:YES];
}

@end
