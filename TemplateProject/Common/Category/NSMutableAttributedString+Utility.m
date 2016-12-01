//
//  NSMutableAttributedString+Utility.m
//  PageTest
//
//  Created by 谭建平 on 16/6/15.
//  Copyright © 2016年 谭建平. All rights reserved.
//

#import "NSMutableAttributedString+Utility.h"

@implementation NSMutableAttributedString (Utility)

- (void)setAttributeTextColor:(UIColor *)color
{
    [self setAttributeTextColor:color range:NSMakeRange(0, [self length])];
}

- (void)setAttributeTextColor:(UIColor *)color range:(NSRange)range
{
    if (color.CGColor)
    {
        [self removeAttribute:NSForegroundColorAttributeName range:range];
        
        [self addAttribute:NSForegroundColorAttributeName
                     value:color
                     range:range];
    }
}

- (void)setAttributeBackgroundColor:(UIColor *)color
{
    [self setAttributeBackgroundColor:color range:NSMakeRange(0, [self length])];
}

- (void)setAttributeBackgroundColor:(UIColor *)color range:(NSRange)range
{
    [self removeAttribute:NSBackgroundColorAttributeName range:range];
    
    [self addAttribute:NSBackgroundColorAttributeName
                 value:color
                 range:range];
}

- (void)setAttributeFont:(UIFont *)font
{
    [self setAttributeFont:font range:NSMakeRange(0, [self length])];
}

- (void)setAttributeFont:(UIFont *)font range:(NSRange)range
{
    if (font)
    {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, nil);
        if (nil != fontRef)
        {
            [self removeAttribute:(NSString*)kCTFontAttributeName range:range];
            [self addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:range];
            CFRelease(fontRef);
        }
    }
}

- (void)setAttributeCharacterSpacing:(CGFloat)chracterSpacing
{
    [self setAttributeCharacterSpacing:chracterSpacing range:NSMakeRange(0, self.length)];
}

- (void)setAttributeCharacterSpacing:(CGFloat)chracterSpacing range:(NSRange)range
{
    [self removeAttribute:(id)kCTKernAttributeName range:range];
    
    [self addAttribute:(NSString *)kCTKernAttributeName
                 value:@(chracterSpacing)
                 range:range];
}

- (void)setAttributeUnderlineStyle:(CTUnderlineStyle)style
                          modifier:(CTUnderlineStyleModifiers)modifier
{
    [self setAttributeUnderlineStyle:style
                            modifier:modifier
                               range:NSMakeRange(0, self.length)];
}

- (void)setAttributeUnderlineStyle:(CTUnderlineStyle)style
                          modifier:(CTUnderlineStyleModifiers)modifier
                             range:(NSRange)range
{
    [self removeAttribute:(NSString *)kCTUnderlineColorAttributeName range:range];
    
    if (style != kCTUnderlineStyleNone) {
        [self addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                     value:[NSNumber numberWithInt:(style | modifier)]
                     range:range];
    }
}

- (void)setAttributeStrokeWidth:(unichar)strokeWidth
                    strokeColor:(UIColor *)strokeColor
{
    [self setAttributeStrokeWidth:strokeWidth strokeColor:strokeColor range:NSMakeRange(0, self.length)];
}

- (void)setAttributeStrokeWidth:(unichar)strokeWidth
                    strokeColor:(UIColor *)strokeColor
                          range:(NSRange)range
{
    [self removeAttribute:(id)kCTStrokeWidthAttributeName range:range];
    if (strokeWidth > 0) {
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&strokeWidth);
        
        [self addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)num range:range];
    }
    
    [self removeAttribute:(id)kCTStrokeColorAttributeName range:range];
    if (strokeColor) {
        [self addAttribute:(id)kCTStrokeColorAttributeName value:(id)strokeColor.CGColor range:range];
    }
}

- (void)setAttributeAlignment:(NSTextAlignment)textAlignment
                  lineSpacing:(CGFloat)linesSpacing
             paragraphSpacing:(CGFloat)paragraphSpacing
                lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    [self setAttributeAlignment:textAlignment lineSpacing:linesSpacing paragraphSpacing:paragraphSpacing lineBreakMode:lineBreakMode range:NSMakeRange(0, self.length)];
}

- (void)setAttributeAlignment:(NSTextAlignment)textAlignment
                  lineSpacing:(CGFloat)linesSpacing
             paragraphSpacing:(CGFloat)paragraphSpacing
                lineBreakMode:(NSLineBreakMode)lineBreakMode
                        range:(NSRange)range
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = textAlignment;
    if (linesSpacing != -1) {
        paragraphStyle.lineSpacing = linesSpacing;
    }
    if (paragraphSpacing != -1) {
        paragraphStyle.paragraphSpacing = paragraphSpacing;
    }
    paragraphStyle.lineBreakMode = lineBreakMode;
    [self setAttributeParagraphStyle:paragraphStyle range:range];
}

- (void)setAttributeParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    [self setAttributeParagraphStyle:paragraphStyle range:NSMakeRange(0, self.length)];
}

- (void)setAttributeParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range
{
    [self removeAttribute:NSParagraphStyleAttributeName range:range];
    
    [self addAttribute:NSParagraphStyleAttributeName
                 value:paragraphStyle
                 range:range];
}

- (CGSize)attributeSizeConstrainedToWidth:(CGFloat)width
{
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                              context:nil].size;
}

@end
