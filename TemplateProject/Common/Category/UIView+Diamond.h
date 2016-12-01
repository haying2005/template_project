//
//  UIView+Diamond.h
//  JSQMessages
//
//  Created by 谭建平 on 16/4/22.
//  Copyright © 2016年 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Diamond)

- (void)removeLayerMask;

- (void)addDiamondShapeClipWithCornerRadius:(CGFloat)cornerRadius
                                borderColor:(UIColor *)borderColor
                                borderWidth:(CGFloat)borderWidth;

- (void)addHexagonShapeClipWithTopCornerRadius:(CGFloat)topCornerRadius
                              leftCornerRadius:(CGFloat)leftCornerRadius
                 rightTriangleHorizontalLength:(CGFloat)leftCornerRadius
                                   borderColor:(UIColor *)borderColor
                                   borderWidth:(CGFloat)borderWidth;

@end
