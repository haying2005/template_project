//
//  UIFont+Default.m
//  iShow
//
//  Created by 谭建平 on 16/5/26.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "UIFont+Default.h"

@implementation UIFont (Default)

+ (UIFont *)customRegularFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize] ?: [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)customLightFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize] ?: [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)customBoldFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize] ?: [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)customMediumFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize] ?: [UIFont systemFontOfSize:fontSize];
}

@end
