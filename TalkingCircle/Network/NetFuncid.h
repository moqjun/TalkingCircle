//
//  NetFuncid.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#ifndef NetFuncid_h
#define NetFuncid_h


typedef NS_ENUM(NSInteger, NetFuncid)
{
    NetFunc_SendVerifyCode = 101,    //发送验证码
    NetFunc_Login = 102,             //账号登录
    NetFunc_ChangePassword = 103,    //修改密码
    NetFunc_UserRigster = 104,        //用户注册
    NetFunc_VerifyCodeLogin = 105,    //验证码登录
    NetFunc_UserInformation = 106,    //用户信息
    NetFunc_EditNickName = 107,    //修改昵称
    NetFunc_invitationCode = 108,    //获取邀请码
    NetFunc_AddFriend = 109,    //加好友记录
    NetFunc_MyPartner = 110,    //我的推荐
    NetFunc_SendRedpacket = 111,    //发红包
    NetFunc_ReceiveRedpacket = 112,    //收红包
    NetFunc_RedpacketStatus = 113,    //红包状态
    NetFunc_AesTest = 114,
};

#endif /* NetFuncid_h */
