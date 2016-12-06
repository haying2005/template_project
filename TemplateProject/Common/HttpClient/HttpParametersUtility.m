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
                                 parameters:@{@"mark" : @"mark-value"}];
}



@end
