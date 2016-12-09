//
//  HttpParametersUtility.h
//  iShow
//
//  Created by 谭建平 on 16/5/9.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpURLDefine.h"

typedef enum {
    HttpRequestMethod_Get,
    HttpRequestMethod_Post
}HttpRequestMethod;

@interface HttpParametersModel : NSObject

@property (nonatomic, assign) HttpRequestMethod requestMethod;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSDictionary *parameters;

@end

@interface HttpParametersUtility : NSObject

+ (HttpParametersModel *)initParammeters;

+ (HttpParametersModel *)registerParammetersWithPhone:(NSString *)phone pass:(NSString *)pass code:(NSString *)code inviter:(NSString *)inviter;

+ (HttpParametersModel *)loginParammetersWithPhone:(NSString *)phone pass:(NSString *)pass;

+ (HttpParametersModel *)logoutParammeters;

+ (HttpParametersModel *)weixinLoginParametersWithOpenid:(NSString *)openId
                                            access_token:(NSString *)accessToken;

+ (HttpParametersModel *)weiboLoginParametersWithOpenid:(NSString *)openId
                                           access_token:(NSString *)accessToken;

+ (HttpParametersModel *)qqLoginParametersWithOpenid:(NSString *)openId
                                        access_token:(NSString *)accessToken;

+ (HttpParametersModel *)setDeviceTokenParammetersWithToken:(NSString *)token;

//type 类型：1注册 2重置密码
+ (HttpParametersModel *)sendCheckCodeParammetersWithPhone:(NSString *)phone
                                                      type:(int)type;

+ (HttpParametersModel *)resetPassParammetersWithPhone:(NSString *)phone
                                                  pass:(NSString *)pass
                                                  code:(NSString *)code;

+ (HttpParametersModel *)checkVersionParammeters;

//情感状态（0：保密，1：单身，2：恋爱中，3：已婚，4：同性）
+ (HttpParametersModel *)modifyEmotionParammetersWithState:(NSInteger)state;

+ (HttpParametersModel *)modifyJobParammetersWithJob:(NSString *)job;

+ (HttpParametersModel *)wxOrderParammetersWithPayType:(int)payType cid:(NSString *)cid;

+ (HttpParametersModel *)wxOrderStatusParammetersWithOrderID:(NSString *)orderID;

+ (HttpParametersModel *)payHistoryParammetersWithPage:(int)page;

+ (HttpParametersModel *)aliOrderParammetersWithPayType:(int)payType cid:(NSString *)cid;


@end
