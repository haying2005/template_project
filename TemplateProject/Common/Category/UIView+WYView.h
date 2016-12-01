//
//  UIView+WYView.h
//  JustForFun
//
//  Created by 方闻宇 on 16/3/8.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WYView)

- (id)initWithMainFrame;

+ (CGRect)mainFrame;

+ (UIView *)duplicate:(UIView*)view;

- (CGFloat)left;
- (void)setLeft:(CGFloat)left;

- (CGFloat)right;
- (void)setRight:(CGFloat)right;

- (CGFloat)top;
- (void)setTop:(CGFloat)top;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGPoint)center;

- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;


- (void)setSize:(CGSize)size;


- (void)setOrigin:(CGPoint)point;

//添加虚线边框
- (void)addDashBorderWithCornerRadius:(CGFloat)cornerRadius
                          borderColor:(UIColor *)borderColor
                          borderWidth:(CGFloat)borderWidth
                      lineDashPattern:(NSArray *)dashPattern;

@end
