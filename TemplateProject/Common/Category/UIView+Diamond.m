//
//  UIView+Diamond.m
//  JSQMessages
//
//  Created by 谭建平 on 16/4/22.
//  Copyright © 2016年 Hexed Bits. All rights reserved.
//

#import "UIView+Diamond.h"

@implementation UIView (Diamond)

- (void)removeLayerMask
{
    if (self.layer.mask) {
        self.layer.mask = nil;
    }
    
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
}

- (void)addDiamondShapeClipWithCornerRadius:(CGFloat)cornerRadius
                                borderColor:(UIColor *)borderColor
                                borderWidth:(CGFloat)borderWidth
{
    if (self.layer.mask) {
        return ;
    }

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rect = self.bounds;
    
    CGPathMoveToPoint(path, NULL, rect.size.width / 4, rect.size.height / 4);
    CGPathAddArcToPoint(path, NULL, rect.size.width / 2, 0, rect.size.width * 0.75, rect.size.height * 0.25, cornerRadius);
    CGPathAddArcToPoint(path, NULL, rect.size.width, rect.size.height * 0.5, rect.size.width * 0.75, rect.size.height * 0.75, cornerRadius);
    CGPathAddArcToPoint(path, NULL, rect.size.width / 2, rect.size.height, rect.size.width * 0.25, rect.size.height * 0.75, cornerRadius);
    CGPathAddArcToPoint(path, NULL, 0, rect.size.height * 0.5, rect.size.width * 0.25, rect.size.height * 0.25, cornerRadius);
    CGPathAddLineToPoint(path, NULL, rect.size.width / 4, rect.size.height / 4);
    
    CGPathCloseSubpath(path);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path;
    
    [self.layer setMask:shapeLayer];
    
    if (borderColor && borderWidth != 0.) {
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.path = path;
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.lineWidth = borderWidth;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:borderLayer];
    }
    
    CGPathRelease(path);
}

- (void)addHexagonShapeClipWithTopCornerRadius:(CGFloat)topCornerRadius
                              leftCornerRadius:(CGFloat)leftCornerRadius
                 rightTriangleHorizontalLength:(CGFloat)rightTriangleHorizontalLength
                                   borderColor:(UIColor *)borderColor
                                   borderWidth:(CGFloat)borderWidth
{
    if (self.layer.mask) {
        return ;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rect = self.bounds;
    
    CGFloat offsetX = rect.origin.x;
    CGFloat offsetY = rect.origin.y;
    
    CGFloat rightTriangleVerticalLength = rect.size.height / 2.;
    
    CGPathMoveToPoint(path, NULL, rightTriangleHorizontalLength / 2. + offsetX, rightTriangleVerticalLength / 2. + offsetY);
    CGPathAddArcToPoint(path, NULL, rightTriangleHorizontalLength + offsetX, 0 + offsetY, rect.size.width * 0.5 + offsetX, 0 + offsetY, topCornerRadius);
    CGPathAddArcToPoint(path, NULL, rect.size.width - rightTriangleHorizontalLength + offsetX, 0 + offsetY, rect.size.width - rightTriangleHorizontalLength / 2. + offsetX, rightTriangleVerticalLength / 2. + offsetY, topCornerRadius);
    CGPathAddArcToPoint(path, NULL, rect.size.width + offsetX, rightTriangleVerticalLength + offsetY, rect.size.width - rightTriangleHorizontalLength / 2. + offsetX, rightTriangleVerticalLength * 1.5 + offsetY, leftCornerRadius);
    CGPathAddArcToPoint(path, NULL, rect.size.width - rightTriangleHorizontalLength + offsetX, rightTriangleVerticalLength * 2 + offsetY, rect.size.width / 2. + offsetX, rightTriangleVerticalLength * 2 + offsetY, topCornerRadius);
    CGPathAddArcToPoint(path, NULL, rightTriangleHorizontalLength + offsetX, rightTriangleVerticalLength * 2 + offsetY, rightTriangleHorizontalLength / 2. + offsetX, rightTriangleVerticalLength * 1.5 + offsetY, topCornerRadius);
    CGPathAddArcToPoint(path, NULL, 0 + offsetX, rightTriangleVerticalLength + offsetY, rightTriangleHorizontalLength / 2. + offsetX, rightTriangleVerticalLength * .5 + offsetY, leftCornerRadius);
    CGPathAddLineToPoint(path, NULL, rightTriangleHorizontalLength / 2. + offsetX, rightTriangleVerticalLength / 2. + offsetY);
    
    CGPathCloseSubpath(path);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path;
    
    [self.layer setMask:shapeLayer];
    
    if (borderColor && borderWidth != 0.) {
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.path = path;
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.lineWidth = borderWidth;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:borderLayer];
    }
    
    CGPathRelease(path);
}

@end
