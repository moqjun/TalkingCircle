//
//  MQSetting.m
//  iOSAppTemplate
//
//  Created by 莫强军 on 15/9/24.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "MQSetting.h"

@implementation MQSettingItem

- (id) init
{
    if (self = [super init]) {
        self.alignment = MQSettingItemAlignmentRight;
        
        self.bgColor = [UIColor whiteColor];
        self.titleColor = [UIColor blackColor];
        self.titleFont = [UIFont systemFontOfSize:15.5f];
        self.subTitleColor = [UIColor grayColor];
        self.subTitleFont = [UIFont systemFontOfSize:15.0f];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.rightImageHeightOfCell = 0.72;
        self.middleImageHeightOfCell = 0.35;
    }
    return self;
}

+ (MQSettingItem *) createWithTitle:(NSString *)title
{
    return [MQSettingItem createWithImageName:nil title:title];
}

+ (MQSettingItem *) createWithImageName:(NSString *)imageName title:(NSString *)title
{
    return [MQSettingItem createWithImageName:imageName title:title subTitle:nil rightImageName:nil];
}

+ (MQSettingItem *) createWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    return [MQSettingItem createWithImageName:nil title:title subTitle:subTitle rightImageName:nil];
}

+ (MQSettingItem *) createWithImageName:(NSString *)imageName title:(NSString *)title middleImageName:(NSString *)middleImageName subTitle:(NSString *)subTitle
{
    return [MQSettingItem createWithImageName:imageName title:title middleImageName:middleImageName subTitle:subTitle rightImageName:nil];
}

+ (MQSettingItem *) createWithImageName:(NSString *)imageName title:(NSString *)title subTitle:(NSString *)subTitle rightImageName:(NSString *)rightImageName
{
    return [MQSettingItem createWithImageName:imageName title:title middleImageName:nil subTitle:subTitle rightImageName:rightImageName];
}

+ (MQSettingItem *) createWithImageName:(NSString *)imageName title:(NSString *)title middleImageName:(NSString *)middleImageName subTitle:(NSString *)subTitle rightImageName:(NSString *)rightImageName
{
    MQSettingItem *item = [[MQSettingItem alloc] init];
    item.imageName = imageName;
    item.middleImageName = middleImageName;
    item.rightImageName = rightImageName;
    item.title = title;
    item.subTitle = subTitle;
    return item;
}

- (void) setAlignment:(MQSettingItemAlignment)alignment
{
    _alignment = alignment;
    if (alignment == MQSettingItemAlignmentMiddle) {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void) setType:(MQSettingItemType)type
{
    _type = type;
    if (type == MQSettingItemTypeSwitch) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if (type == MQSettingItemTypeButton) {
        self.btnBGColor = DEFAULT_GREEN_COLOR;
        self.btnTitleColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgColor = [UIColor clearColor];
    }
}

@end


@implementation MQSettingGrounp

- (id) initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle settingItems:(MQSettingItem *)firstObj, ...
{
    if (self = [super init]) {
        _headerTitle = headerTitle;
        _footerTitle = footerTitle;
        _items = [[NSMutableArray alloc] init];
        va_list argList;
        if (firstObj) {
            [_items addObject:firstObj];
            va_start(argList, firstObj);
            id arg;
            while ((arg = va_arg(argList, id))) {
                [_items addObject:arg];
            }
            va_end(argList);
        }
    }
    return self;
}

- (MQSettingItem *) itemAtIndex:(NSUInteger)index
{
    return [_items objectAtIndex:index];
}

- (NSUInteger) indexOfItem:(MQSettingItem *)item
{
    return [_items indexOfObject:item];
}

- (NSUInteger) itemsCount
{
    return self.items.count;
}

@end
