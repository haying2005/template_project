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

@end
