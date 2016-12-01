//
//  Utility.h
//  Test
//
//  Created by Green on 14-6-6.
//  Copyright (c) 2014年 tan. All rights reserved.
//

#ifndef Test_Utility_h
#define Test_Utility_h

// ZNLog for debug
#define ZN_DEBUG DEBUG

#define STRING_GET_LASTPATHCOMPONENT(str) (\
        {   char *str_ret = NULL;\
            int i = 0;\
            while (((char *)str)[i] != '\0') i++;\
            while (((char *)str)[i] != '/') i--;\
            str_ret = (char *)str + i + 1;\
            str_ret;\
        })

#if ZN_DEBUG
#define ZNLog(format, ...) NSLog(@"(%s-%d)%s:" format, (char *)STRING_GET_LASTPATHCOMPONENT((char *)__FILE__), __LINE__, (char *)__FUNCTION__, ##__VA_ARGS__)
#else
#define ZNLog(format, ...)
#endif

// Safe Release An Object
#if __has_feature(objc_arc)
#define SAFE_RELEASE(x) do{if(x){x = nil;}}while(0)
#else
#define SAFE_RELEASE(x) do{if(x){[x release];x = nil;}}while(0)
#endif

// Weak Self
#define WEAKSELF        typeof(self) __weak weakSelf = self;

// Strong Self
#define STRONGSELF      typeof(self) __strong strongSelf = self;

// Degree and radian convert
#define DEGREE_TO_RADIAN(x)             (M_PI * (x) / 180.)
#define RADIAN_TO_DEGREE(x)             ((x) * 180. / M_PI)

// RGB Color
#define RGBA(r,g,b,a)                   [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define RGB(r,g,b)                      RGBA(r, g, b, 1.0f)

// Judge the OS's version
#define IOS_VERSION_EQUAL(x)            ([[[UIDevice currentDevice] systemVersion] floatValue] == x)
#define IOS_VERSION_EQUAL_OR_GREATER(x) ([[[UIDevice currentDevice] systemVersion] floatValue] >= x)

// Alert
#define alert(title, body) do{\
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title\
                                                    message:body\
                                                   delegate:nil\
                                          cancelButtonTitle:@"确定"\
                                          otherButtonTitles:nil];\
    [alert show];\
}while(0)

// Screen WIDTH & HEIGHT
#define SCREEN_WIDTH                        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                       ([UIScreen mainScreen].bounds.size.height)

// Screen Resolution Judge
#define SCREEN_IS3DOT5INCH                  ([UIScreen mainScreen].bounds.size.height == 480.)
#define SCREEN_IS4INCH                      ([UIScreen mainScreen].bounds.size.height == 568.)
#define SCREEN_IS4DOT7INCH                  ([UIScreen mainScreen].bounds.size.height == 667.)
#define SCREEN_IS5DOT5INCH                  ([UIScreen mainScreen].bounds.size.height == 736.)

// Screen Adapt
#define IPHONE5_WIDTH                                   320.
#define IPHONE6_WIDTH                                   375.
#define IPHONE6P_WIDTH                                  414.

#define IPHONE5_SCREEN                                  IPHONE5_WIDTH
#define IPHONE6_SCREEN                                  IPHONE6_WIDTH
#define IPHONE6P_SCREEN                                 IPHONE6P_WIDTH

#define IS_IPHONE5_SCREEN                               (SCREEN_WIDTH == IPHONE5_SCREEN)
#define IS_IPHONE6_SCREEN                               (SCREEN_WIDTH == IPHONE6_SCREEN)
#define IS_IPHONE6P_SCREEN                              (SCREEN_WIDTH == IPHONE6P_SCREEN)

#define ADAPT_LENGTH_UTIL(from, to, fromLength)         (to / from * fromLength)
#define ADAPT_LENGTH_TO_CURRENTSCREEN(from, fromLength) ([UIScreen mainScreen].bounds.size.width / from * fromLength)
#define ADAPT_LENGTH(fromLength)                        ([UIScreen mainScreen].bounds.size.width / IPHONE6_SCREEN * fromLength)

// Image pt Length
#define IMAGE_PT_WIDTH(image)                           ((image.scale == 1) ? (image.size.width / [UIScreen mainScreen].scale) : (image.size.width))
#define IMAGE_PT_HEIGHT(image)                          ((image.scale == 1) ? (image.size.height / [UIScreen mainScreen].scale) : (image.size.height))

// Execute once - first
#define EXECUTE_ONCE(x)         do{\
    static bool firstFlag = true;\
    if (firstFlag) {\
        x;\
        firstFlag = false;\
    }\
}while(0)

// Execute - skip first
#define EXECUTE_SKIP_FIRST(x)   do{\
    static bool firstFlag = true;\
    if (!firstFlag) {\
        x;\
    }\
    if (firstFlag) {\
        firstFlag = false;\
    }\
}while(0)

// App Delegate
#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#endif
