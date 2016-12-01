//
//  UILabel+Gradient.m
//  PageTest
//
//  Created by 谭建平 on 16/6/4.
//  Copyright © 2016年 谭建平. All rights reserved.
//

#import "UILabel+Gradient.h"
#import "NSObjectAdditions.h"

static char key;

@implementation UILabel (Gradient)

- (void)addGradientEffectWithTopColor:(UIColor *)topColor
                          bottomColor:(UIColor *)bottomColor
{
    CAGradientLayer *gradientLayer = nil;
    
    gradientLayer = [self getAssociatedObjectWithKey:&key];
    CGRect rect = self.frame;
    
    if (gradientLayer) {
        gradientLayer.colors = @[(id)topColor.CGColor,
                                 (id)bottomColor.CGColor];
        return;
        
    }
    
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    gradientLayer.colors = @[(id)topColor.CGColor,
                             (id)bottomColor.CGColor];
    
    [self.superview.layer addSublayer:gradientLayer];
    gradientLayer.mask = self.layer;
    
    self.frame = gradientLayer.bounds;
    
    [self setAssociatedObjectWithKey:&key value:gradientLayer policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

@end
