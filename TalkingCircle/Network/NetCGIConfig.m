//
//  NetCGIConfig.m
//  PADRP
//
//  Created by zhaoYuan on 16/12/26.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#import "NetCGIConfig.h"
#import "NetFuncid.h"

@interface NetCGIConfig ()

@property(nonatomic, strong) NSMutableDictionary *m_functionIdDic;

@end


@implementation NetCGIConfig


static NetCGIConfig *s_instance = NULL;

+ (NetCGIConfig *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[NetCGIConfig alloc] init];
        [s_instance config];
    });
    return s_instance;
}

- (void)config
{
    _m_functionIdDic = [[NSMutableDictionary alloc] init];
    
    //发验证码
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_SendVerifyCode cgiName:@NetSendVerifyCodePath cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_SendVerifyCode]];
    
    //账号密码登录
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_Login cgiName:@NetUserPhoneLoginPath cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_RSA channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_Login]];
    
    //注册
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_UserRigster cgiName:@NetUserRegisterPath cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_RSA channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_UserRigster]];
    
    //验证码登录
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_VerifyCodeLogin cgiName:@NetUserVerifyCodeLoginPath cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_RSA channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_VerifyCodeLogin]];
    
    //修改密码
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_ChangePassword cgiName:@NetChangePasswordPath cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_ChangePassword]];


    //用户信息
     [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_UserInformation cgiName:@NetUserInformationPath cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_UserInformation]];
    
    //修改昵称
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_EditNickName cgiName:@NetEditUserNicknamePath cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_EditNickName]];
    
    //获取邀请码
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_invitationCode cgiName:@NetInvitationCodePath cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_invitationCode]];
    
    //加好友
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_AddFriend cgiName:@NetChatAddfriendPath cgiUrl:@ChatBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_AddFriend]];
    
    //我的推荐
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_MyPartner cgiName:@NetUserMyPartner cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_MyPartner]];
    
    //发红包
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_SendRedpacket cgiName:@NetPaySendRedPacketPath cgiUrl:@PayBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_SendRedpacket]];
    
    //收红包
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_ReceiveRedpacket cgiName:@NetPayRecevieRedPacketPath cgiUrl:@PayBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_ReceiveRedpacket]];
    
    //红包状态
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_RedpacketStatus cgiName:@NetPayRedPacketStatusPath cgiUrl:@PayBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_RedpacketStatus]];
    
    //aes test
    [_m_functionIdDic setObject:[[NetCGIItem alloc] initWithFuncId:NetFunc_AesTest cgiName:@NetAesTestPath cgiUrl:@UserBaseUrl decryptType:NetCGI_ENCRYPT_DECRYPT_TYPE_NONE channelType:NetCGI_CHANNEL_TYPE_SHORT] forKey:[NSNumber numberWithInt:NetFunc_AesTest]];
}


- (NetCGIItem *)findItemWithFuncInternal:(const int)funcId
{
    return [_m_functionIdDic objectForKey:[NSNumber numberWithInt:funcId]];;
}

+ (NetCGIItem *)findItemWithFunc:(const int)funcId
{
    return [[NetCGIConfig sharedInstance] findItemWithFuncInternal:funcId];
}

@end
