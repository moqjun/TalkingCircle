//
//  MQUIHelper.m
//  iOSAppTemplate
//
//  Created by 莫强军 on 15/9/24.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "MQUIHelper.h"

@implementation MQUIHelper

+ (MQSettingGrounp *) getFriensListItemsGroup
{
    MQSettingItem *notify = [MQSettingItem createWithImageName:@"plugins_FriendNotify" title:@"新的朋友"];
    MQSettingItem *friendGroup = [MQSettingItem createWithImageName:@"add_friend_icon_addgroup" title:@"群聊"];
    MQSettingItem *tag = [MQSettingItem createWithImageName:@"Contact_icon_ContactTag" title:@"标签"];
    MQSettingItem *offical = [MQSettingItem createWithImageName:@"add_friend_icon_offical" title:@"公众号"];
    MQSettingGrounp *group = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:notify, friendGroup, tag, offical, nil];
    return group;
}

+ (NSMutableArray *) getMineVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    MQSettingItem *bill = [MQSettingItem createWithImageName:@"bill" title:@"账单"];
    MQSettingItem *payMent = [MQSettingItem createWithImageName:@"payment" title:@"淘支付"];
    MQSettingItem *patry = [MQSettingItem createWithImageName:@"patry" title:@"我的合伙人"];
    MQSettingGrounp *group1 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:bill, payMent, patry, nil];
    [items addObject:group1];

    
    MQSettingItem *setting = [MQSettingItem createWithImageName:@"setting" title:@"设置"];
    MQSettingGrounp *group2 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:setting, nil];
    [items addObject:group2];
    return items;
}

+ (NSMutableArray *) getDiscoverItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    MQSettingItem *friendsAlbum = [MQSettingItem createWithImageName:@"ff_IconShowAlbum" title:@"朋友圈" subTitle:nil rightImageName:@"2.jpg"];
    MQSettingGrounp *group1 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:friendsAlbum, nil];
    [items addObject:group1];

    MQSettingItem *qrCode = [MQSettingItem createWithImageName:@"ff_IconQRCode" title:@"扫一扫"];
    MQSettingItem *shake = [MQSettingItem createWithImageName:@"ff_IconShake" title:@"摇一摇"];
    MQSettingGrounp *group2 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:qrCode, shake, nil];
    [items addObject:group2];
    
    MQSettingItem *loacation = [MQSettingItem createWithImageName:@"ff_IconLocationService" title:@"附近的人" subTitle:nil rightImageName:@"FootStep"];
    loacation.rightImageHeightOfCell = 0.43;
    MQSettingItem *bottle = [MQSettingItem createWithImageName:@"ff_IconBottle" title:@"漂流瓶"];
    MQSettingGrounp *group3 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:loacation, bottle, nil];
    [items addObject:group3];

    MQSettingItem *shopping = [MQSettingItem createWithImageName:@"CreditCard_ShoppingBag" title:@"购物"];
    MQSettingItem *game = [MQSettingItem createWithImageName:@"MoreGame" title:@"游戏" subTitle:@"超火力新枪战" rightImageName:@"game_tag_icon"];
    MQSettingGrounp *group4 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:shopping, game, nil];
    [items addObject:group4];

    return items;
}

+ (NSMutableArray *) getDetailVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    MQSettingItem *tag = [MQSettingItem createWithTitle:@"设置备注和标签"];
    MQSettingItem *phone = [MQSettingItem createWithTitle:@"电话号码" subTitle:@"18888888888"];
    phone.alignment = MQSettingItemAlignmentLeft;
    MQSettingGrounp *group1 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:tag, phone, nil];
    [items addObject:group1];
    MQSettingItem *position = [MQSettingItem createWithTitle:@"地区" subTitle:@"山东 青岛"];
    position.alignment = MQSettingItemAlignmentLeft;
    MQSettingItem *album = [MQSettingItem createWithTitle:@"个人相册"];
    album.subImages = @[@"1.jpg", @"2.jpg", @"8.jpg", @"0.jpg"];
    album.alignment = MQSettingItemAlignmentLeft;
    MQSettingItem *more = [MQSettingItem createWithTitle:@"更多"];
    MQSettingGrounp *group2 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:position, album, more, nil];
    [items addObject:group2];

    MQSettingItem *chatButton = [MQSettingItem createWithTitle:@"发消息"];
    chatButton.type = MQSettingItemTypeButton;
    MQSettingItem *videoButton = [MQSettingItem createWithTitle:@"视频聊天"];
    videoButton.type = MQSettingItemTypeButton;
    videoButton.btnBGColor = [UIColor whiteColor];
    videoButton.btnTitleColor = [UIColor blackColor];
    MQSettingGrounp *group3 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:chatButton, videoButton, nil];
    [items addObject:group3];
    
    return items;
}

+ (NSMutableArray *) getMineDetailVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    MQSettingItem *avatar = [MQSettingItem createWithImageName:nil title:@"个人头像" subTitle:nil rightImageName:@"ic_head"];
     avatar.accessoryType = UITableViewCellAccessoryNone;
    MQSettingItem *name = [MQSettingItem createWithTitle:@"昵称" subTitle:[[EMClient sharedClient] currentUsername]];
    MQSettingItem *num = [MQSettingItem createWithTitle:@"圈友账号" subTitle:@"li-bokun"];
    num.accessoryType = UITableViewCellAccessoryNone;
    
    MQSettingItem *code = [MQSettingItem createWithImageName:nil title:@"二维码" subTitle:nil rightImageName:@"ic_head"];
    MQSettingItem *address = [MQSettingItem createWithTitle:@"我的地址"];
    MQSettingGrounp *frist = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:avatar, name, num, code, address, nil];
    [items addObject:frist];
    
    MQSettingItem *sex = [MQSettingItem createWithTitle:@"性别" subTitle:@"男"];
    MQSettingItem *pos = [MQSettingItem createWithTitle:@"地区" subTitle:@"山东 滨州"];
   
    MQSettingGrounp *second = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:sex, pos, nil];
    [items addObject:second];
    
    return items;
}

+ (NSMutableArray *) getSettingVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
   
    
    MQSettingItem *noti = [MQSettingItem createWithTitle:@"新消息提醒"];
    MQSettingItem *noDisturbMode = [MQSettingItem createWithTitle:@"勿扰模式"];
    noDisturbMode.type = MQSettingItemTypeSwitch;
     MQSettingItem *clearRecord = [MQSettingItem createWithTitle:@"清空聊天记录"];
    MQSettingItem *privacy = [MQSettingItem createWithTitle:@"隐私"];
   
    MQSettingGrounp *group1 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:noti,noDisturbMode,clearRecord, privacy, nil];
    [items addObject:group1];
    
    MQSettingItem *safe = [MQSettingItem createWithImageName:nil title:@"账号安全" middleImageName:@"ProfileLockOn" subTitle:@"已保护"];
    MQSettingItem *about = [MQSettingItem createWithTitle:@"关于洽谈圈"];
    MQSettingGrounp *group2 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:safe,about, nil];
    [items addObject:group2];
    
    MQSettingItem *exit = [MQSettingItem createWithTitle:@"退出"];
    
    MQSettingGrounp *group3 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:exit, nil];
    [items addObject:group3];
    
    return items;
}

+ (NSMutableArray *) getDetailSettingVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];

    MQSettingItem *tag = [MQSettingItem createWithTitle:@"设置备注及标签"];
    MQSettingGrounp *group1 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:tag, nil];
    [items addObject:group1];

    MQSettingItem *recommend = [MQSettingItem createWithTitle:@"把他推荐给好友"];
    MQSettingGrounp *group2 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:recommend, nil];
    [items addObject:group2];
    
    MQSettingItem *starFriend = [MQSettingItem createWithTitle:@"把它设为星标朋友"];
    starFriend.type = MQSettingItemTypeSwitch;
    MQSettingGrounp *group3 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:starFriend, nil];
    [items addObject:group3];
    
    MQSettingItem *prohibit = [MQSettingItem createWithTitle:@"不让他看我的朋友圈"];
    prohibit.type = MQSettingItemTypeSwitch;
    MQSettingItem *ignore = [MQSettingItem createWithTitle:@"不看他的朋友圈"];
    ignore.type = MQSettingItemTypeSwitch;
    MQSettingGrounp *group4 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:prohibit, ignore, nil];
    [items addObject:group4];
    
    MQSettingItem *addBlacklist = [MQSettingItem createWithTitle:@"加入黑名单"];
    addBlacklist.type = MQSettingItemTypeSwitch;
    MQSettingItem *report = [MQSettingItem createWithTitle: @"举报"];
    MQSettingGrounp *group5 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:addBlacklist, report, nil];
    [items addObject:group5];

    MQSettingItem *delete = [MQSettingItem createWithTitle:@"删除好友"];
    delete.type = MQSettingItemTypeButton;
    MQSettingGrounp *group6 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:delete, nil];
    [items addObject:group6];

    return items;
}

+ (NSMutableArray *) getNewNotiVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    MQSettingItem *recNoti = [MQSettingItem createWithTitle:@"接受新消息通知"];
    recNoti.type = MQSettingItemTypeSwitch;
    MQSettingGrounp *group1 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"" settingItems:recNoti, nil];
    [items addObject:group1];


    MQSettingItem *voice = [MQSettingItem createWithTitle:@"声音"];
    voice.type = MQSettingItemTypeSwitch;
    MQSettingItem *shake = [MQSettingItem createWithTitle:@"震动"];
    shake.type = MQSettingItemTypeSwitch;
    MQSettingGrounp *group2 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"" settingItems:voice, shake, nil];
    [items addObject:group2];

   
    return items;
}

+ (NSMutableArray *) getPrivacyVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    MQSettingItem *recNoti = [MQSettingItem createWithTitle:@"加我时需要验证"];
    recNoti.type = MQSettingItemTypeSwitch;
    MQSettingGrounp *group1 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"" settingItems:recNoti, nil];
    [items addObject:group1];
    
    
    MQSettingItem *voice = [MQSettingItem createWithTitle:@"通过手机号加我"];
    voice.type = MQSettingItemTypeSwitch;
    MQSettingItem *shake = [MQSettingItem createWithTitle:@"可通过群聊加我"];
    shake.type = MQSettingItemTypeSwitch;
    MQSettingGrounp *group2 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"" settingItems:voice, shake, nil];
    [items addObject:group2];
    
    
    return items;
}

+ (NSMutableArray *) getAccountSafeVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    MQSettingItem *circleNum = [MQSettingItem createWithTitle:@"圈友号" subTitle:@"cloud"];
    circleNum.accessoryType = UITableViewCellAccessoryNone;
    MQSettingItem *editPhone = [MQSettingItem createWithTitle:@"修改手机号"];
    
    MQSettingGrounp *group1 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"" settingItems:circleNum,editPhone, nil];
    [items addObject:group1];
    
    
    MQSettingItem *editPwd = [MQSettingItem createWithTitle:@"修改密码"];
   
    MQSettingItem *bindEmail = [MQSettingItem createWithImageName:nil title:@"绑定邮箱" middleImageName:@"ProfileLockOn" subTitle:@"未绑定"];
    MQSettingGrounp *group2 = [[MQSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"" settingItems:editPwd, bindEmail, nil];
    [items addObject:group2];
    
    
    return items;
}


@end
