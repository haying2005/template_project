//
//  HttpClient.m
//  iShow
//
//  Created by 谭建平 on 16/5/9.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient ()
{

}
@end

@implementation HttpClient

+ (HttpClient *)shareInstance
{
    static HttpClient *httpClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpClient = [[self alloc] init];
    });
    return httpClient;
}

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)commonBusinessHandle:(NSDictionary *)responseObject
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSString *errorDescription))failure
{
    if (![responseObject isKindOfClass:[NSDictionary class]] ||
        ![(NSDictionary *)responseObject objectForKey:@"data"] ||
        ![(NSDictionary *)responseObject objectForKey:@"status"] ||
        ![(NSDictionary *)responseObject objectForKey:@"error"]) {
        failure(@"数据异常");
        return ;
    }
    
    NSInteger status = [[(NSDictionary *)responseObject objectForKey:@"status"] integerValue];
    
    if (status == 1) {         // 成功
        success([(NSDictionary *)responseObject objectForKey:@"data"]);
    }
    else if (status == 0) {    // 失败
        failure([(NSDictionary *)responseObject objectForKey:@"error"]);
    }
    else if (status == -1) {   // 需要登录
        failure(@"需要登录");
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NEED_LOGIN object:nil];
        });        
    }
}

- (void)requestWithParameters:(HttpParametersModel *)httpParametersModel
                      success:(void (^)(id data))success
                      failure:(void (^)(NSString *errorDescription))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", nil];
    manager.requestSerializer.timeoutInterval = HTTP_TIMEOUT_INTERVAL;
    
    if (httpParametersModel.requestMethod == HttpRequestMethod_Get) {
        [manager GET:httpParametersModel.urlString
          parameters:httpParametersModel.parameters
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self commonBusinessHandle:responseObject
                                    success:success
                                    failure:failure];
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 failure(error.localizedDescription);
             }];
    }
    else if (httpParametersModel.requestMethod == HttpRequestMethod_Post) {
        [manager POST:httpParametersModel.urlString
           parameters:httpParametersModel.parameters
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  [self commonBusinessHandle:responseObject
                                     success:success
                                     failure:failure];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  failure(error.localizedDescription);
              }];
    }
}

- (void)requestWithParameters:(HttpParametersModel *)httpParametersModel
    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                     progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                      success:(void (^)(id data))success
                      failure:(void (^)(NSString *errorDescription))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", nil];
    
    [manager POST:httpParametersModel.urlString
       parameters:httpParametersModel.parameters
constructingBodyWithBlock:block
         progress:uploadProgress
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              [self commonBusinessHandle:responseObject
                                 success:success
                                 failure:failure];
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              failure(error.localizedDescription);
          }];
}

@end
