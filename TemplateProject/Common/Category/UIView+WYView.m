//
//  UIView+WYView.m
//  JustForFun
//
//  Created by 方闻宇 on 16/3/8.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import "UIView+WYView.h"

@implementation UIView (WYView)

- (id)initWithMainFrame
{
    CGRect frame = CGRectMake(0, 0, 320, 480 - 20 - 44);
    return [self initWithFrame:frame];
}

+ (CGRect)mainFrame
{
    return CGRectMake(0, 0, 320, 480 - 20 - 44);
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGPoint)center {
    CGPoint point = self.frame.origin;
    
    CGPoint center = CGPointMake(point.x + self.width/2, point.y + self.height/2);
    return center;
}

//- (void)setCenter:(CGPoint)center {
//    CGPoint origin = CGPointMake(center.x - self.width/2, center.y - self.height/2);
//    [self setOrigin:origin];
//}

- (void)setCenterX:(CGFloat)x {
    CGPoint center = CGPointMake(x, self.center.y);
    [self setCenter:center];
}

- (void)setCenterY:(CGFloat)y {
    CGPoint center = CGPointMake(self.center.x, y);
    [self setCenter:center];
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.width;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)point
{
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}

+ (UIView *)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}


- (void)addDashBorderWithCornerRadius:(CGFloat)cornerRadius
                          borderColor:(UIColor *)borderColor
                          borderWidth:(CGFloat)borderWidth
                      lineDashPattern:(NSArray *)dashPattern {
    
    if (self.layer.mask) {
        return;
    }
    
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = borderColor.CGColor;
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius].CGPath;
    border.lineWidth = borderWidth * 2; //有一半宽度在外面不显示 所以要乘以2
    border.lineJoin = @"square";
    border.lineDashPattern = dashPattern;

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius].CGPath;
    self.layer.mask = maskLayer;
    
    [self.layer addSublayer:border];
    
}


@end
