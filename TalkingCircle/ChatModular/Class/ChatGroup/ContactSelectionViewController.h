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

#import "EMChooseViewController.h"

@class PersonModel;

@interface ContactSelectionViewController : EMChooseViewController

//是否进入选择添加群组成员状态
@property (nonatomic,assign) BOOL isAddGroupMember;

//已有选中的成员username，在该页面，这些成员不能被取消选择
- (instancetype)initWithBlockSelectedUsernames:(NSArray *)blockUsernames;

- (instancetype)initWithContacts:(NSArray *)contacts;


@end
