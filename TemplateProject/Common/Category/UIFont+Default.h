//
//  UIFont+Default.h
//  iShow
//
//  Created by 谭建平 on 16/5/26.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Default)

// 正常
+ (UIFont *)customRegularFontOfSize:(CGFloat)fontSize;

// 轻体
+ (UIFont *)customLightFontOfSize:(CGFloat)fontSize;

// 粗体
+ (UIFont *)customBoldFontOfSize:(CGFloat)fontSize;

// 中体
+ (UIFont *)customMediumFontOfSize:(CGFloat)fontSize;

@end
