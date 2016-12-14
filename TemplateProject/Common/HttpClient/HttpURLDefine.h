//
//  HttpURLDefine.h
//  iShow
//
//  Created by 谭建平 on 16/5/9.
//  Copyright © 2016年 godfather. All rights reserved.
//

#ifndef HttpURLDefine_h
#define HttpURLDefine_h

// **************************** 配置信息 **********************************

// 超时时间，以秒计算
#define HTTP_TIMEOUT_INTERVAL       20.f

// 需要登录的通知
#define NOTIFICATION_NEED_LOGIN     @"NOTIFICATION_NEED_LOGIN"

// 接口环境
#define kTestEnvironment            0

// Base URL
#if kTestEnvironment
    #define URL_ENTRY               @"http://115.159.71.110/v1"
#else   
    #define URL_ENTRY               @"http://template.kinsoo.com/v1"
#endif

// **************************** 接口 *************************************

//初始化
#define URL_INIT                    [URL_ENTRY stringByAppendingString:@"/init"]

//注册
#define URL_REGISTER                [URL_ENTRY stringByAppendingString:@"/login/signup"]

//登录
#define URL_LOGIN                   [URL_ENTRY stringByAppendingString:@"/login/login"]

//登出
#define URL_LOGOUT                  [URL_ENTRY stringByAppendingString:@"/user/loginout"]

//微信登录
#define URL_WEIXIN_LOGIN            [URL_ENTRY stringByAppendingString:@"/platform/weixin"]

//QQ登录
#define URL_QQ_LOGIN                [URL_ENTRY stringByAppendingString:@"/platform/qq"]

//微博登录
#define URL_WEIBO_LOGIN             [URL_ENTRY stringByAppendingString:@"/platform/weibo"]

//FaceBook登录
#define URL_FACEBOOK_LOGIN          [URL_ENTRY stringByAppendingString:@"/platform/fb"]

//Twitter登录
#define URL_TWITTER_LOGIN           [URL_ENTRY stringByAppendingString:@"/platform/twitter"]

//同步用户设备信息，devicetoken
#define URL_SET_DEVICE              [URL_ENTRY stringByAppendingString:@"/user/setdevice"]

//发送手机验证码
#define URL_SEND_CODE               [URL_ENTRY stringByAppendingString:@"/login/sendcode"]

//重置密码
#define URL_RESET_PASS              [URL_ENTRY stringByAppendingString:@"/login/resetpwd"]

//版本检查
#define URL_CHECK_VERSION           [URL_ENTRY stringByAppendingString:@"/init/checkversion"]

//修改情感状态
#define URL_MODIFY_EMOTION          [URL_ENTRY stringByAppendingString:@"/user/modify-emotion"]

//修改职业
#define URL_MODIFY_JOB              [URL_ENTRY stringByAppendingString:@"/user/modify-job"]

//微信下单
#define URL_WX_ORDER                [URL_ENTRY stringByAppendingString:@"/pay/wxorder"]

//获取微信订单支付状态
#define URL_WX_ORDER_STATUS         [URL_ENTRY stringByAppendingString:@"/pay/wxorderstatus"]

//支付历史
#define URL_PAY_HISTORY             [URL_ENTRY stringByAppendingString:@"/pay/history"]

//支付宝下单
#define URL_ALI_ORDER               [URL_ENTRY stringByAppendingString:@"/pay/aliorder"]

//文件上传
#define URL_UPLOAD               [URL_ENTRY stringByAppendingString:@"/login/upload"]

//修改完善信息
#define URL_EDITUSERINFO            [URL_ENTRY stringByAppendingString:@"/user/modify"]



#endif /* HttpURLDefine_h */
