//
//  NSStringAdditions.h
//  Test
//
//  Created by tan on 13-5-20.
//  Copyright (c) 2013年 tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>

@interface NSString (NSStringAdditions)

+ (NSString *)UUID;

- (NSArray *)traverseUsingRegularExp:(NSString *)reg;
- (BOOL)matchRegularExp:(NSString *)reg;

- (NSString *)trim;

- (NSString *)stringFromMD5;
- (NSString *)stringFromSHA1;

- (NSString *)encodeForURL;
- (NSString *)encodeForURLReplacingSpacesWithPlus;
- (NSString *)decodeFromURL;

+ (NSString *)jsonRepresentWithObject:(id)object options:(NSJSONWritingOptions)options;
- (id)jsonResolveWithOptions:(NSJSONReadingOptions)options;

- (BOOL)isPureInt;
- (BOOL)isPureFloat;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)sizeWithFont:(UIFont *)font
           lineSpacing:(CGFloat)lineSpacin   // -1 default
               kerning:(CGFloat)kerning      // -1 default
                 width:(CGFloat)width;

- (NSAttributedString *)attributedStringWithFont:(UIFont *)font
                                     lineSpacing:(CGFloat)lineSpacing   // -1 default
                                         kerning:(CGFloat)kerning;      // -1 default


//计算一段字符串的长度。（单字节字符算1，多字节字符算2）
- (int)countTheStrLength;

- (int)countTheStrLength_;

//多字节字符（包括emoji表情） 长度一律算2， 因为emoji字符的length是大于1的，所以不能用简单的substring方法
- (NSMutableString *)stringByShortToLength:(int)length;

//获取小头像
- (NSString *)toSmallHeadUrlString;

//获取中头像
- (NSString *)toMediumHeadUrlString;

@end
