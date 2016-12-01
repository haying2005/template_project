//
//  NSMutableAttributedString+Utility.h
//  PageTest
//
//  Created by 谭建平 on 16/6/15.
//  Copyright © 2016年 谭建平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSMutableAttributedString (Utility)

- (void)setAttributeTextColor:(UIColor *)color;
- (void)setAttributeTextColor:(UIColor *)color range:(NSRange)range;

- (void)setAttributeBackgroundColor:(UIColor *)color;
- (void)setAttributeBackgroundColor:(UIColor *)color range:(NSRange)range;

- (void)setAttributeFont:(UIFont *)font;
- (void)setAttributeFont:(UIFont *)font range:(NSRange)range;

- (void)setAttributeCharacterSpacing:(CGFloat)chracterSpacing;
- (void)setAttributeCharacterSpacing:(CGFloat)chracterSpacing range:(NSRange)range;

- (void)setAttributeUnderlineStyle:(CTUnderlineStyle)style
                          modifier:(CTUnderlineStyleModifiers)modifier;
- (void)setAttributeUnderlineStyle:(CTUnderlineStyle)style
                          modifier:(CTUnderlineStyleModifiers)modifier
                             range:(NSRange)range;

/**
 *  添加空心字
 *
 *  @param strokeWidth 空心字边框宽
 *  @param strokeColor 空心字边框颜色
 */
- (void)setAttributeStrokeWidth:(unichar)strokeWidth
                    strokeColor:(UIColor *)strokeColor;
- (void)setAttributeStrokeWidth:(unichar)strokeWidth
                    strokeColor:(UIColor *)strokeColor
                          range:(NSRange)range;

/**
 *  设置对齐样式
 *
 *  @param linesSpacing 行间距，-1默认
 *  @param paragraphSpacing 段落间距，\n隔开，-1默认
 */
- (void)setAttributeAlignment:(NSTextAlignment)textAlignment
                  lineSpacing:(CGFloat)linesSpacing
             paragraphSpacing:(CGFloat)paragraphSpacing
                lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (void)setAttributeAlignment:(NSTextAlignment)textAlignment
                  lineSpacing:(CGFloat)linesSpacing
             paragraphSpacing:(CGFloat)paragraphSpacing
                lineBreakMode:(NSLineBreakMode)lineBreakMode
                        range:(NSRange)range;

- (void)setAttributeParagraphStyle:(NSParagraphStyle *)paragraphStyle;
- (void)setAttributeParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range;

/**
 *  计算属性字符串的高度
 *  适用于UILabel的attributedText属性，与设定了宽度后调用sizeToFit调整后的高度一样
 */
- (CGSize)attributeSizeConstrainedToWidth:(CGFloat)width;

@end
