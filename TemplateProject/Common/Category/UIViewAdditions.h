//
//  UIViewAdditions.h
//  Test
//
//  Created by tan on 13-5-17.
//  Copyright (c) 2013年 tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (UIViewAdditions)

- (void)showAllSubviews;
- (void)showAllSubviewsAndLayers;

- (void)removeAllSubviews;
- (void)removeSubviewWithClassName:(NSString *)className;

- (UIViewController *)viewController;

// opposite to isDescendantOfView, returns YES for self.
- (BOOL)containSubview:(UIView *)view;

// find the first subview recursively with className, include self
- (UIView *)subviewWithClassName:(NSString *)className;

// find the first subview recursively with viewAddress, include self
- (UIView *)subviewWithViewAddress:(NSString *)viewAddress;

// find the first superview circularly, include self
- (UIView *)superviewWithClassName:(NSString *)className;

- (UIImage *)image;
- (UIImage *)gradientImage;
- (void)addReflectionEffect;

// need release or autorelease
- (UIView *)deepCopy;

// return the x, y coordinate on the screen, don't subtract scroll views' contentOffset.
- (CGFloat)screenOffsetX;
- (CGFloat)screenOffsetY;

// return the x , y coordinate on the screen, taking into account scroll views.
- (CGFloat)screenX;
- (CGFloat)screenY;

// calculates the offset of this view from another view in screen coordinates. otherView should be a parent view of this view.
- (CGPoint)offsetFromView:(UIView *)otherView;

- (void)addBorderWithWidth:(CGFloat)borderWidth color:(UIColor *)borderColor;
- (void)addCornerWithRadius:(CGFloat)cornerRadius;

@end
