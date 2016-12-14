//
//  Macro.h
//  live
//
//  Created by kenneth on 15-7-9.
//  Copyright (c) 2015年 kenneth. All rights reserved.
//

//获取屏幕 宽度、高度
#define SCREEN_WIDTH                                ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                               ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SCALE                                ([UIScreen mainScreen].scale)

//状态栏高度
#define STATUS_HEIGHT                               ([UIApplication sharedApplication].statusBarFrame.size.height)

// 业务逻辑的接口的成功返回状态
#define BUSINESS_SUCCESS_STATUS                     (1)

// 默认头像
#define DEFAULT_AVATAR_IMAGE                        ([UIImage imageNamed:@"avatar"])

// 字符串类型检查
#define STRING_VALUE_CHECK(string)                  ([string isKindOfClass:[NSString class]] ? string : nil)

// 应用app store地址 ishow:1126199551, ding dong:768082524
#define APP_ID                                      @"768082524"
//#define APPSTORE_URL                                [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8", APP_ID]
//#define APPSTORE_URL                                @"https://itunes.apple.com/cn/app/tao-bao-sui-shi-sui-xiang/id387682726?mt=8"
#define APPSTORE_URL                                @"https://www.pgyer.com/VprD"

#define USERINFO_UPDATE_NOTIFICATION                @"USERINFO_UPDATE_NOTIFICATION"


// 极光
#define kJPushAppKey                @"1111"
#define kJPushChannel               @"App Store"
#define kJPushIsProduction          0

//-------------------------THIRD OPEN PLATFORM-------------------------

// 新浪微博
#define kSinaWeiBoAppKey            @"1124889445"
#define kSinaWeiBoAppSecret         @"b640e80d42515103d4904c1f39dbb074"
#define kSinaWeiBoRedirectURL       @"https://api.weibo.com/oauth2/default.html"

// 微信
#define kWeiXinAppKey               @"wxf0d3c6b75d034b0e"
#define kWeiXinAppSecret            @"3d93a875d1c58736a0213f60d4634866"

// 腾讯QQ
#define kTencentQQAppKey            @"1105798203"
#define kTencentQQAppSecret         @"F32bWwW57nEu7myp"
#define kTencentQQRedirectURL       @"http://www.baidu.com"

// FaceBook
#define kFaceBookAppKey             @"915900235211681"

// Twitter
#define kTwitterAppKey              @"FExa4eORHjRrJBYwy7LSRDLsk"
#define kTwitterAppSecret           @"XHXY5yiKCuqWcsPepAe41xB02gu3vnwa2jGOFPxKTt6KWPqrND"



