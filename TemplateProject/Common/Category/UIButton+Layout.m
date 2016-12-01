//
//  UIButton+Layout.m
//  Testt
//
//  Created by Tan on 15/3/27.
//  Copyright (c) 2015年 Testt. All rights reserved.
//

#import "UIButton+Layout.h"

@implementation UIButton (Layout)

- (void)centerVerticallyWithPadding:(CGFloat)padding
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                            0.0f,
                                            0.0f,
                                            - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            - imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0f);
}

- (void)centerVertically
{
    const CGFloat kDefaultPadding = 6.0f;
    
    [self centerVerticallyWithPadding:kDefaultPadding];
}

- (void)centerHorizontallyWithPadding:(CGFloat)padding
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalWidth = (imageSize.width + titleSize.width + padding);
    CGFloat marginLength = (self.frame.size.width - totalWidth) / 2;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            marginLength,
                                            0.0f,
                                            marginLength + padding);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            marginLength + padding,
                                            0.0f,
                                            marginLength);
}

- (void)horizontallyLayoutWithLabelCenterAndImagePadding:(CGFloat)padding
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalWidth = (imageSize.width + titleSize.width);
    CGFloat marginLength = self.frame.size.width - totalWidth;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            -marginLength + padding,
                                            0.0f,
                                            0.0f);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            -imageSize.width,
                                            0.0f,
                                            0.0f);
}

- (void)horizontallyLayoutWithImagePadding:(CGFloat)imagePadding labelPadding:(CGFloat)labelPadding
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalWidth = (imageSize.width + titleSize.width);
    CGFloat marginLength = (self.frame.size.width - totalWidth);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            -marginLength + imagePadding,
                                            0.0f,
                                            0.0f);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            -marginLength + imagePadding + labelPadding,
                                            0.0f,
                                            0.0f);
}
- (void)buttonWithIcon:(UIImage *)image spacing:(CGFloat)spacing andAttributedString:(NSAttributedString *)str isImageLeft:(BOOL)flag {
    
    UIButton *btn = self;
    //[btn setBackgroundColor:[UIColor greenColor]];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setAttributedTitle:str forState:UIControlStateNormal];
    
    [btn.titleLabel sizeToFit];
    
    if (flag) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, spacing, 0, -0)];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn sizeToFit];
        btn.width += spacing;
    }
    
    else {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, - image.size.width, 0, 0)];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn sizeToFit];
        btn.width += spacing;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.width - image.size.width, 0, 0)];
    }

}

@end
