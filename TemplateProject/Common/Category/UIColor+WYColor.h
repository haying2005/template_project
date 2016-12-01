//
//  UIColor+WYColor.h
//  JustForFun
//
//  Created by godfather on 16/3/1.
//  Copyright (c) 2016年 godfather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WYColor)
+ (UIColor *) colorWithHex:(uint) hex alpha:(CGFloat)alpha;
+ (UIColor *) randomColorAlpha:(CGFloat)alpha;
@end
