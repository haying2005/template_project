//
//  UIColorAdditions.m
//  Test
//
//  Created by tan on 14-2-21.
//  Copyright (c) 2014年 tan. All rights reserved.
//

#import "UIColorAdditions.h"

@implementation UIColor (UIColorAdditions)

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    const char *pRed=[[hexString substringWithRange:NSMakeRange(0, 2)] UTF8String];
    const char *pGreen=[[hexString substringWithRange:NSMakeRange(2, 2)] UTF8String];
    const char *pBlue=[[hexString substringWithRange:NSMakeRange(4, 2)] UTF8String];
    CGFloat red=strtol(pRed, NULL, 16)      / 255.0f;
    CGFloat green=strtol(pGreen, NULL, 16)  / 255.0f;
    CGFloat blue=strtol(pBlue, NULL, 16)    / 255.0f;
    
    return [UIColor colorWithRed:red
						   green:green
							blue:blue
						   alpha:1.];
}

+ (UIColor *)colorWithIntegerRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red    / 255.0f
						   green:green  / 255.0f
							blue:blue   / 255.0f
						   alpha:alpha];
}

@end
