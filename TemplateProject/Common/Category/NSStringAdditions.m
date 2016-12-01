//
//  NSStringAdditions.m
//  Test
//
//  Created by tan on 13-5-20.
//  Copyright (c) 2013年 tan. All rights reserved.
//

#import "NSStringAdditions.h"

@implementation NSString (NSStringAdditions)

+ (NSString *)UUID
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return [(NSString *)uuidStr autorelease];
}

//example: NSLog(@"%@",[@"abcd432e<a>fghi</a>jklmnop4324qabr5654<a />6stu<b />vwxyz" traverseUsingRegularExp:@"<(.*)>.*<\\/\\1>|<[^/]*/>"]);
- (NSArray *)traverseUsingRegularExp:(NSString *)reg
{
	NSMutableArray *result = [NSMutableArray array];
	NSRange range = [self rangeOfString:reg options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])];
    while (range.length>0)
	{
		[result addObject:[NSValue valueWithRange:range]];
		range = NSMakeRange(range.location+range.length, [self length]-(range.location+range.length));
		range = [self rangeOfString:reg options:NSRegularExpressionSearch range:range];
	}
	return result;
}

- (BOOL)matchRegularExp:(NSString *)reg
{
    return [self rangeOfString:reg options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])].length>0;
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringFromMD5
{
    if (self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (unsigned int)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [outputString autorelease];
}

- (NSString *)stringFromSHA1
{
    if (self == nil || [self length] == 0)
        return nil;
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)encodeForURL
{
    const CFStringRef legalURLCharactersToBeEscaped = CFSTR("!*'();:@&=+$,/?#[]<>\"{}|\\`^% ");
    
    return [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, legalURLCharactersToBeEscaped, kCFStringEncodingUTF8)) autorelease];
}

- (NSString *)encodeForURLReplacingSpacesWithPlus;
{
    const CFStringRef legalURLCharactersToBeEscaped = CFSTR("!*'();:@&=$,/?#[]<>\"{}|\\`^% ");
    
    NSString *replaced = [self stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)replaced, NULL, legalURLCharactersToBeEscaped, kCFStringEncodingUTF8)) autorelease];
}

- (NSString *)decodeFromURL
{
    NSString *decoded = [NSMakeCollectable(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8)) autorelease];
    return [decoded stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

+ (NSString *)jsonRepresentWithObject:(id)object options:(NSJSONWritingOptions)options
{
    return [[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:object options:options error:NULL] encoding:NSUTF8StringEncoding] autorelease];
}

- (id)jsonResolveWithOptions:(NSJSONReadingOptions)options
{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:options error:NULL];
}

- (BOOL)isPureInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if (self == nil || self.length == 0) {
        return CGSizeZero;
    }
    
     if ([self respondsToSelector:@selector(sizeWithFont:constrainedToSize:lineBreakMode:)]) {
         CGSize textSize = [self sizeWithFont:font
                            constrainedToSize:size
                                lineBreakMode:NSLineBreakByCharWrapping];
         return textSize;
     }
    
    return CGSizeZero;
}

- (CGSize)sizeWithFont:(UIFont *)font
           lineSpacing:(CGFloat)lineSpacing
               kerning:(CGFloat)kerning
                 width:(CGFloat)width
{
    NSMutableDictionary *mutableAttributes = [NSMutableDictionary dictionary];
    
    [mutableAttributes setObject:font forKey:(NSString *)kCTFontAttributeName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    if (lineSpacing != -1)
        paragraphStyle.lineSpacing = lineSpacing;
    
    [mutableAttributes setObject:paragraphStyle forKey:(NSString *)kCTParagraphStyleAttributeName];
    
    if (kerning != -1)
        [mutableAttributes setObject:@(kerning) forKey:(NSString *)kCTKernAttributeName];
    
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:mutableAttributes
                                         context:nil].size;
    return textSize;
}

- (NSAttributedString *)attributedStringWithFont:(UIFont *)font
                                     lineSpacing:(CGFloat)lineSpacing
                                         kerning:(CGFloat)kerning
{
    NSMutableDictionary *mutableAttributes = [NSMutableDictionary dictionary];
    
    [mutableAttributes setObject:font forKey:(NSString *)kCTFontAttributeName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    if (lineSpacing != -1)
        paragraphStyle.lineSpacing = lineSpacing;
    
    [mutableAttributes setObject:paragraphStyle forKey:(NSString *)kCTParagraphStyleAttributeName];
    
    if (kerning != -1)
        [mutableAttributes setObject:@(kerning) forKey:(NSString *)kCTKernAttributeName];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self attributes:mutableAttributes];
    
    return attributedString;
}



- (int)countTheStrLength  {
    
//    int strlength = 0;
//    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
//    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
//        if (*p) {
//            p++;
//            strlength++;
//        }
//        else {
//            p++;
//        }
//        
//    }
//    return strlength;
    return [self countTheStrLength_];
 
}

//计算一段(utf-8)字符串的长度，多字节字符（包括emoji表情） 长度一律算2
- (int)countTheStrLength_ {
    
//    int strlength = 0;
//    const char *p = [self UTF8String];
//    if (!p) {
//        ZNLog(@"字符为空或者字符格式为非UTF-8格式");
//    }
//    
//    unsigned long bytelength = strlen(p);//字节数
//    
//    for (int i = 0; i < bytelength; i ++, p++) {
//        
//        if ((*p & 0b10000000) == 0b00000000) {
//            strlength ++;
//        }
//        else if ((*p & 0b11100000) == 0b11000000) {
//            strlength += 2;
//        }
//        else if ((*p & 0b11110000) == 0b11100000) {
//            strlength += 2;
//        }
//        else if ((*p & 0b11111000) == 0b11110000) {
//            strlength += 2;
//        }
//        else if ((*p & 0b11111100) == 0b11111000) {
//            strlength += 2;
//        }
//        else if ((*p & 0b11111110) == 0b11111100) {
//            strlength += 2;
//        }
//    }
//    return strlength;
    
    __block int count = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        NSLog(@"%@: range: %lu - %lu", substring, (unsigned long)enclosingRange.location, (unsigned long)enclosingRange.length);
        if (strlen([substring UTF8String]) > 1) {
            count += 2; //多字节字符（包括emoji表情） 长度一律算2
        }
        else count += 1;
    }];
    return count;
}

//多字节字符（包括emoji表情） 长度一律算2， 因为emoji字符的length是大于1的，所以不能用简单的substring方法
- (NSMutableString *)stringByShortToLength:(int)length {
    
    __block int len = 0;
    
    NSMutableString *str_M = [NSMutableString string];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        ZNLog(@"%@: range: %lu - %lu", substring, (unsigned long)enclosingRange.location, (unsigned long)enclosingRange.length);
        if (strlen([substring UTF8String]) > 1) {
            if (len + 2 <= length) {
                len += 2;
                [str_M appendString:substring];
            }
        }
        else {
            if (len + 1 <= length) {
                len += 1;
                [str_M appendString:substring];
            }
        }
    }];
    return str_M;
}


//转换为小头像
- (NSString *)toSmallHeadUrlString {
    if ([self hasSuffix:@"_b.png"] || [self hasSuffix:@"_m.png"]) {
        return [[self substringToIndex:self.length - 6] stringByAppendingString:@"_s.png"];
    }
    else {
        return self;
    }

}

//转换为中头像
- (NSString *)toMediumHeadUrlString {
    if ([self hasSuffix:@"_b.png"] || [self hasSuffix:@"_s.png"]) {
        return [[self substringToIndex:self.length - 6] stringByAppendingString:@"_m.png"];
    }
    else {
        return self;
    }
}

@end
