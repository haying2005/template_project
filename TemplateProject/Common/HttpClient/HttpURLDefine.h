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
#define kTestEnvironment            1

// Base URL
#if kTestEnvironment
    #define URL_ENTRY               @"http://115.159.71.110/v1"
#else   
    #define URL_ENTRY               @"http://dev-api.kinsoo.com/v1"
#endif

// **************************** 接口 *************************************

//初始化
#define URL_INIT                    [URL_ENTRY stringByAppendingString:@"/init"]






#endif /* HttpURLDefine_h */
