//
//  MQNewFriendModel.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/19.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "EaseUserModel.h"

@interface MQNewFriendModel : EaseUserModel

/** @brief 添加朋友的时候标柱的内容 */
@property (nonatomic,strong) NSString *body;

/** @brief 新的朋友所处的状态，未添加、处理申请结果、已经添加 */

@property (nonatomic,assign) NSInteger status;

@end
