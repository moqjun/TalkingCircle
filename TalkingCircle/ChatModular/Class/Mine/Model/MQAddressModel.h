//
//  MQAddressModel.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQAddressModel : NSObject

@property (nonatomic,strong) NSString *name;          //联系人姓名
@property (nonatomic,strong) NSString *phone;         //手机号码
@property (nonatomic,strong) NSString *address;       //地区地址
@property (nonatomic,strong) NSString *detailAddress; //详细地址／门牌街道
@property (nonatomic,strong) NSString *code;          //邮政编码

//用于显示Label textField 
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic,strong) NSString *fieldText;

@end
