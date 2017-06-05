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

#import "ContactSelectionViewController.h"

#import "EMRemarkImageView.h"
#import "BaseTableViewCell.h"
#import "RealtimeSearchUtil.h"
#import "BaseSelectCell.h"

#import "PersonModel.h"

#import "BaseTableViewCell.h"
#import "UIViewController+SearchController.h"

@interface ContactSelectionViewController ()<EMSearchControllerDelegate>

@property (strong, nonatomic) NSMutableArray *contactsSource;
@property (strong, nonatomic) NSMutableArray *selectedContacts;
@property (strong, nonatomic) NSMutableArray *groupMembers;
@property (strong, nonatomic) NSMutableArray *blockSelectedUsernames;

@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIScrollView *footerScrollView;
@property (strong, nonatomic) UIButton *doneButton;

@property (nonatomic) BOOL presetDataSource;

@end

@implementation ContactSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _contactsSource = [NSMutableArray array];
        _selectedContacts = [NSMutableArray array];
        _groupMembers = [NSMutableArray array];
        
        [self setObjectComparisonStringBlock:^NSString *(id object) {
            return object;
        }];
        
        [self setComparisonObjectSelector:^NSComparisonResult(id object1, id object2) {
            NSString *username1 = (NSString *)object1;
            NSString *username2 = (NSString *)object2;
            
            return [username1 caseInsensitiveCompare:username2];
        }];
    }
    return self;
}

- (instancetype)initWithBlockSelectedUsernames:(NSArray *)blockUsernames
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _blockSelectedUsernames = [NSMutableArray array];
        _groupMembers = [NSMutableArray arrayWithArray:blockUsernames];
        
        for(NSString *name in blockUsernames)
        {
            PersonModel *model =[[PersonModel alloc] init];
            model.userName = name;
            model.readOnly = YES;
            model.txicon = [UIImage imageNamed:@"ic_head"];
            [_blockSelectedUsernames addObject:model];
        }
        
    }
    
    return self;
}

- (instancetype)initWithContacts:(NSArray *)contacts
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _presetDataSource = YES;
        [_contactsSource addObjectsFromArray:contacts];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"title.chooseContact", @"select the contact");
    
    self.navigationItem.rightBarButtonItem = nil;
    //更改索引的背景颜色
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    [self addCustomRightBarItem];
    
    [self setupSearchController];
   
}

//自定义导航栏右边菜单项
-(void) addCustomRightBarItem
{
    NSString *btnTitle =@"确定";
    if (!self.isAddGroupMember) {
        btnTitle = @"删除";
    }
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitleColor:[UIColor colorWithHexString:@"2287fb"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton = btn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)setupSearchController
{
    [self enableSearchController];
    
    __weak ContactSelectionViewController *weakSelf = self;
    self.resultController.tableView.tableFooterView = [[UIView alloc] init];
    
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
        
        [weakSelf cancelSearch];
    }];
    
    UISearchBar *searchBar = self.searchController.searchBar;
    searchBar.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = searchBar;
    [searchBar sizeToFit];
    
}

#pragma mark - EMSearchControllerDelegate

- (void)cancelButtonClicked
{
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
}

- (void)searchTextChangeWithString:(NSString *)aString
{
    __weak typeof(self) weakSelf = self;
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.contactsSource searchText:aString collationStringSelector:@selector(showName) resultBlock:^(NSArray *results) {
        if (results) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.resultController.displaySource removeAllObjects];
                [weakSelf.resultController.displaySource addObjectsFromArray:results];
                [weakSelf.resultController.tableView reloadData];
            });
        }
    }];
}

- (NSString*)showName
{
    return @"";
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UIView *)footerView
{
    if (self.mulChoice && _footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
        _footerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        _footerView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
        
        _footerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, _footerView.frame.size.width - 30 - 70, _footerView.frame.size.height - 5)];
        _footerScrollView.backgroundColor = [UIColor clearColor];
        [_footerView addSubview:_footerScrollView];
        
       
    }
    
    return _footerView;
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactListCell";
    BaseSelectCell *cell = [BaseSelectCell baseSelectWithTableView:tableView];
    
    
    PersonModel *model = [[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.personModel = model;
    
    return cell;
}



//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    if ([_blockSelectedUsernames count] > 0) {
//        NSString *username = [[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//        return ![self isBlockUsername:username];
//    }
//    
//    return YES;
//}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonModel *model = [[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (model.readOnly)
    {
        return ;
    }
    model.checked = !model.checked;
    
    if (model.checked)
    {
        [self.selectedContacts addObject:model];
       
    }
    else
    {
        [self.selectedContacts removeObject:model];
        
    }
    [self reloadRightBarItem];
    
    [tableView reloadData];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *username = [[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    if ([self isBlockUsername:username])
//    {
//        return ;
//    }
//    if ([self.selectedContacts containsObject:username]) {
//        [self.selectedContacts removeObject:username];
//        
//        [self reloadFooterView];
//    }
//}

#pragma mark - private

- (BOOL)isBlockUsername:(NSString *)username
{
    if (!self.isAddGroupMember)
    {
        return NO;
    }
    if (username && [username length] > 0) {
        if ([_blockSelectedUsernames count] > 0) {
            for (PersonModel *model in _blockSelectedUsernames)
            {
                NSString *tmpName = model.userName;
                if ([username isEqualToString:tmpName]) {
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

- (void)reloadRightBarItem
{
    NSString *btnTitle =@"确定";
    if (self.isAddGroupMember)
    {
        btnTitle =[NSString stringWithFormat:@"确定(%ld)",self.selectedContacts.count];
    }
    else
    {
         btnTitle =[NSString stringWithFormat:@"删除(%ld)",self.selectedContacts.count];
    }
    [self.doneButton setTitle:btnTitle forState:UIControlStateNormal];
}

#pragma mark - public

- (void)loadDataSource
{
    if (!_presetDataSource) {
        [self showHudInView:self.view hint:NSLocalizedString(@"loadData", @"Load data...")];
        [_dataSource removeAllObjects];
        [_contactsSource removeAllObjects];
        
        NSArray *array = nil;
        if (self.isAddGroupMember)
        {
            NSArray *buddyList = [[EMClient sharedClient].contactManager getContacts];
            for (NSString *username in buddyList) {
                [self.contactsSource addObject:username];
            }
            
            array =[self sortRecords:self.contactsSource];
        }
        else
        {
             array =[self sortRecords:self.groupMembers];
        }
        
        for (NSArray *tempArray in array)
        {
            
            NSMutableArray *contacts =[NSMutableArray array];
            for (NSString *userName in tempArray)
            {
                PersonModel *model = [[PersonModel alloc] init];
                model.userName = userName;
                model.txicon = [UIImage imageNamed:@"ic_head"];
                model.readOnly =[self isBlockUsername:userName];
                [contacts addObject:model];
            }
            [_dataSource addObject:contacts];
            
        }

        [self hideHud];
    }
    else {
        
        NSArray *array =[[self sortRecords:self.contactsSource] mutableCopy];
        
        for (NSArray *tempArray in array)
        {
           
                NSMutableArray *contacts =[NSMutableArray array];
                for (NSString *userName in tempArray)
                {
                    PersonModel *model = [[PersonModel alloc] init];
                    model.userName = userName;
                    model.txicon = [UIImage imageNamed:@"ic_head"];
                    model.readOnly =[self isBlockUsername:userName];
                    
                    [contacts addObject:model];
                }
                [_dataSource addObject:contacts];
        }
    }
    [self.tableView reloadData];
}

- (void)doneAction:(id)sender
{
    BOOL isPop = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(viewController:didFinishSelectedSources:)]) {
        if ([_blockSelectedUsernames count] == 0) {
            isPop = [_delegate viewController:self didFinishSelectedSources:self.selectedContacts];
        }
        else{
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSString *username in self.selectedContacts) {
                if(![self isBlockUsername:username])
                {
                    [resultArray addObject:username];
                }
            }
            isPop = [_delegate viewController:self didFinishSelectedSources:resultArray];
        }
    }
    
    if (isPop) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma mark 处理右侧菜单项点击事件
- (void)onClickEvent:(id)sender
{
    //确定 ，删除
    if (self.isAddGroupMember)
    {
       
    }
    else
    {
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
