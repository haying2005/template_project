//
//  HttpClient.h
//  iShow
//
//  Created by 谭建平 on 16/5/9.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpParametersUtility.h"

@interface HttpClient : NSObject

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

+ (HttpClient *)shareInstance;

// 接口请求
- (void)requestWithParameters:(HttpParametersModel *)httpParametersModel
                      success:(void (^)(id data))success
                      failure:(void (^)(NSString *errorDescription))failure;

// 数据上传
- (void)requestWithParameters:(HttpParametersModel *)httpParametersModel
    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                     progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                      success:(void (^)(id data))success
                      failure:(void (^)(NSString *errorDescription))failure;

#pragma clang diagnostic pop

@end
