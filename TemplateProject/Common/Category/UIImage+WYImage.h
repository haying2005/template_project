//
//  UIImage+WYImage.h
//  iShow
//
//  Created by godfather on 16/3/16.
//  Copyright © 2016年 godfather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WYImage)

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage*)getSubImage:(CGRect)rect;
//等比例缩放()
-(UIImage*)scaleToSize:(CGSize)size;

//uiview转uiimage
+ (UIImage*)convertViewToImage:(UIView*)v;
//- (UIImage *)scaleToFitScreenScale;

- (UIImage *)imageCroppedToRect:(CGRect)rect;

//改变图片颜色
- (UIImage *)changeColor:(UIColor *)color;


@end
