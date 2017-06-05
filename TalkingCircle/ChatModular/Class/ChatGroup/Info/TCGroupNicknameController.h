//
//  TCGroupNicknameController.h
//  TalkingCircle
//
//  Created by iMac on 2017/5/5.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TCGroupNickNameBlock)(NSString *name);

@interface TCGroupNicknameController : UIViewController

@property(nonatomic,strong) TCGroupNickNameBlock block;

/*
 * 群组名称 修改群组中现实的昵称
 */
@property (nonatomic,assign) BOOL isEditGroupNickNamed; //是否是修改群组中显示的昵称

@end
