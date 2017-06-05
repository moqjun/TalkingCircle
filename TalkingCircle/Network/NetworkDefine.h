//
//  NetworkDefine.h
//  PADRP
//
//  Created by zhaoYuan on 16/12/27.
//  Copyright © 2016年 容灾规划支持组. All rights reserved.
//

#ifndef NetworkDefine_h
#define NetworkDefine_h

typedef NS_ENUM(NSInteger,ServiceNetStatusCode){
    ServiceNetStatusCode_OK = 1,
    ServiceNetStatusCode_paramErr = 2,
    ServiceNetStatusCode_noLogin = 401,
    ServiceNetStatusCode_loginNameOrPWErr = 4,
    ServiceNetStatusCode_pageNotFound = 5,
    ServiceNetStatusCode_inServiceErr = 6,
};

#define TC_IS_DEBUG

#ifdef TC_IS_DEBUG

#define UserBaseUrl "http://119.23.38.234:8002"   //user相关

#define PayBaseUrl "http://119.23.38.234:8003"    //pay相关

#define ChatBaseUrl "http://119.23.38.234:8004"   //chat相关

#else

#define UserBaseUrl "http://119.23.38.234:8002"

#define PayBaseUrl  "http://119.23.38.234:8003"

#define ChatBaseUrl "http://119.23.38.234:8004"

#endif


//user
#define NetSendVerifyCodePath "/user/captcha"

#define NetUserPhoneLoginPath "/user/login"

#define NetUserVerifyCodeLoginPath "/user/captcha-login"

#define NetUserRegisterPath "/user/register"

#define NetChangePasswordPath "/user/resetpwd"

#define NetUserInformationPath "/ucenter/index"

#define NetEditUserNicknamePath "/ucenter/nickname"

#define NetInvitationCodePath "/ucenter/invitationcode"

#define NetUserMyPartner "/ucenter/mypartner"


//chat
#define NetChatAddfriendPath "/chat/addfriend"



//pay

#define NetPayRecevieRedPacketPath "/red-envelopes/receive"
#define NetPaySendRedPacketPath    "/red-envelopes/send"
#define NetPayRedPacketStatusPath  "/red-envelopes/status"


//aes test
#define NetAesTestPath "/index/aes-test"

#endif /* NetworkDefine_h */
