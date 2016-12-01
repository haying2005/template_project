//
//  UIButton+Layout.h
//  Testt
//
//  Created by Tan on 15/3/27.
//  Copyright (c) 2015年 Testt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIButton (Layout)

// vertical

- (void)centerVerticallyWithPadding:(CGFloat)padding;

- (void)centerVertically;


// horizontal

// padding不准，实际显示貌似会偏大
- (void)centerHorizontallyWithPadding:(CGFloat)padding;

// padding不准，实际只有大约1/2
- (void)horizontallyLayoutWithLabelCenterAndImagePadding:(CGFloat)padding;

// imagePadding、labelPadding不准，实际只有大约1/2
- (void)horizontallyLayoutWithImagePadding:(CGFloat)imagePadding labelPadding:(CGFloat)labelPadding;

//add by 方闻宇
- (void)buttonWithIcon:(UIImage *)image spacing:(CGFloat)spacing andAttributedString:(NSAttributedString *)str isImageLeft:(BOOL)flag;

@end
