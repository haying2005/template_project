//
//  UIColor+WYColor.m
//  JustForFun
//
//  Created by godfather on 16/3/1.
//  Copyright (c) 2016年 godfather. All rights reserved.
//

#import "UIColor+WYColor.h"

@implementation UIColor (WYColor)
+ (UIColor *) colorWithHex:(uint) hex alpha:(CGFloat)alpha {
    int red, green, blue;
    
    blue = hex & 0x0000FF;
    green = ((hex & 0x00FF00) >> 8);
    red = ((hex & 0xFF0000) >> 16);
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}
+ (UIColor *) randomColorAlpha:(CGFloat)alpha {
    CGFloat red = (arc4random() % 100) * 0.01;
    CGFloat green = (arc4random() % 100) * 0.01;
    CGFloat blue = (arc4random() % 100) * 0.01;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
