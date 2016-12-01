//
//  UIView+Layout.h
//  Test
//
//  Created by Tan on 15/4/15.
//  Copyright (c) 2015年 tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (LayoutAddition)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@end
