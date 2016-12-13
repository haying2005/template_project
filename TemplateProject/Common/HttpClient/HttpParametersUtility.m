//
//  HttpParametersUtility.m
//  iShow
//
//  Created by 谭建平 on 16/5/9.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "HttpParametersUtility.h"
#import "User.h"

@implementation HttpParametersModel

@end

@implementation HttpParametersUtility

// **************************** Utility *************************************

+ (NSMutableDictionary *)commonParameters
{
    NSMutableDictionary *commonParameters = [[NSMutableDictionary alloc] init];
    
    NSString *accessToken = [User shareInstance].accessToken;
    commonParameters[@"accessToken"] = accessToken ? accessToken : @"";
    
    return commonParameters;
}

+(HttpParametersModel *)httpParametersModelWithURL:(NSString *)urlString
                                        parameters:(NSDictionary *)parameters
{
    HttpParametersModel *httpParametersModel = [[HttpParametersModel alloc] init];
    httpParametersModel.urlString = urlString;
    httpParametersModel.parameters = [self commonParameters];
    
    if (parameters)
        [(NSMutableDictionary *)httpParametersModel.parameters addEntriesFromDictionary:parameters];
    
    return httpParametersModel;
}

// **************************** 接口参数 *************************************

+ (HttpParametersModel *)initParammeters
{
    return [self httpParametersModelWithURL:URL_INIT
                                 parameters:@{@"mark" : [[User shareInstance] getUUID]}];
}

+ (HttpParametersModel *)registerParammetersWithPhone:(NSString *)phone pass:(NSString *)pass code:(NSString *)code inviter:(NSString *)inviter
{
    if (!inviter) {
        return [self httpParametersModelWithURL:URL_REGISTER
                                     parameters:@{@"username" : phone,
                                                  @"password" : pass,
                                                  @"code" : code,
                                                  @"mark" : [[User shareInstance] getUUID]}];
    }
    
    else {
        return [self httpParametersModelWithURL:URL_REGISTER
                                     parameters:@{@"username" : phone,
                                                  @"password" : pass,
                                                  @"code" : code,
                                                  @"inviter"  : inviter,
                                                  @"mark" : [[User shareInstance] getUUID]}];
    }
    
}

+ (HttpParametersModel *)loginParammetersWithPhone:(NSString *)phone pass:(NSString *)pass
{
    return [self httpParametersModelWithURL:URL_LOGIN
                                 parameters:@{@"username" : phone,
                                              @"password" : pass}];
}

+ (HttpParametersModel *)logoutParammeters {
    return [self httpParametersModelWithURL:URL_LOGOUT parameters:nil];
}

+ (HttpParametersModel *)weixinLoginParametersWithOpenid:(NSString *)openId
                                            access_token:(NSString *)accessToken
{
    return [self httpParametersModelWithURL:URL_WEIXIN_LOGIN
                                 parameters:@{@"pid" : openId,
                                              @"access_token" : accessToken}];
}

+ (HttpParametersModel *)weiboLoginParametersWithOpenid:(NSString *)openId
                                           access_token:(NSString *)accessToken
{
    return [self httpParametersModelWithURL:URL_WEIBO_LOGIN
                                 parameters:@{@"pid" : openId,
                                              @"access_token" : accessToken}];
}

+ (HttpParametersModel *)qqLoginParametersWithOpenid:(NSString *)openId
                                        access_token:(NSString *)accessToken
{
    return [self httpParametersModelWithURL:URL_QQ_LOGIN
                                 parameters:@{@"pid" : openId,
                                              @"access_token" : accessToken}];
}

+ (HttpParametersModel *)setDeviceTokenParammetersWithToken:(NSString *)token
{
    return [self httpParametersModelWithURL:URL_SET_DEVICE
                                 parameters:@{@"type" : @(1),
                                              @"token" : token}];
}

+ (HttpParametersModel *)sendCheckCodeParammetersWithPhone:(NSString *)phone
                                                      type:(int)type {
    return [self httpParametersModelWithURL:URL_SEND_CODE
                                 parameters:@{@"phone" : phone,
                                              @"type" : @(type)}];
}

+ (HttpParametersModel *)resetPassParammetersWithPhone:(NSString *)phone
                                                  pass:(NSString *)pass
                                                  code:(NSString *)code {
    return [self httpParametersModelWithURL:URL_RESET_PASS
                                 parameters:@{@"username" : phone,
                                              @"password" : pass,
                                              @"code" : code}];
}

+ (HttpParametersModel *)checkVersionParammeters
{
    return [self httpParametersModelWithURL:URL_CHECK_VERSION
                                 parameters:@{@"type" : @(1)}];
}

+ (HttpParametersModel *)modifyEmotionParammetersWithState:(NSInteger)state
{
    return [self httpParametersModelWithURL:URL_MODIFY_EMOTION
                                 parameters:@{@"emotion" : @(state)}];
}

+ (HttpParametersModel *)modifyJobParammetersWithJob:(NSString *)job
{
    return [self httpParametersModelWithURL:URL_MODIFY_JOB
                                 parameters:@{@"job" : job}];
}

+ (HttpParametersModel *)wxOrderParammetersWithPayType:(int)payType cid:(NSString *)cid
{
    return [self httpParametersModelWithURL:URL_WX_ORDER
                                 parameters:@{@"payType" : @(payType),
                                              @"cid" : cid}];
}

+ (HttpParametersModel *)wxOrderStatusParammetersWithOrderID:(NSString *)orderID
{
    return [self httpParametersModelWithURL:URL_WX_ORDER_STATUS
                                 parameters:@{@"orderId" : orderID}];
}

+ (HttpParametersModel *)payHistoryParammetersWithPage:(int)page
{
    return [self httpParametersModelWithURL:URL_PAY_HISTORY
                                 parameters:@{@"page" : @(page)}];
}

+ (HttpParametersModel *)aliOrderParammetersWithPayType:(int)payType cid:(NSString *)cid
{
    return [self httpParametersModelWithURL:URL_ALI_ORDER
                                 parameters:@{@"payType" : @(payType),
                                              @"cid" : cid}];
}

+ (HttpParametersModel *)uploadParammeters {
    return [self httpParametersModelWithURL:URL_UPLOAD parameters:nil];
}

//修改用户基本信息
+ (HttpParametersModel *)editUserInfoParammetersWithNick:(NSString *)nick desc:(NSString *)desc headUrl:(NSString *)url
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (nick && nick.length > 0) {
        [dic setObject:nick forKey:@"nickName"];
    }
    if (desc && desc.length > 0) {
        [dic setObject:desc forKey:@"description"];
    }
    if (url && url.length > 0) {
        [dic setObject:url forKey:@"headUrl"];
    }
    
    return [self httpParametersModelWithURL:URL_EDITUSERINFO
                                 parameters:dic];
}

@end
