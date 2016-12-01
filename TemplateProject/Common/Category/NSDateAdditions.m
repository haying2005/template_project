//
//  NSDateAdditions.m
//  Test
//
//  Created by tan on 13-8-26.
//  Copyright (c) 2013年 tan. All rights reserved.
//

#import "NSDateAdditions.h"

@implementation NSDate (NSDateAdditions)

+ (id)dateWithString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *dateFormatter=[[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateFormat=format;
    return [dateFormatter dateFromString:string];
}

+ (id)dateWithTimestampString:(NSString *)string
{
    NSDateFormatter *dateFormatter=[[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateFormat=TIMESTAMP_IDENTIFIER;
    return [dateFormatter dateFromString:string];
}

+ (id)dateWithComponents:(NSDateComponents *)components
{
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (id)dateWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day hour:(NSUInteger)hour minute:(NSUInteger)minute second:(NSUInteger)second
{
    NSDateComponents *components=[[NSDateComponents new] autorelease];
    components.year=year;
    components.month=month;
    components.day=day;
    components.hour=hour;
    components.minute=minute;
    components.second=second;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter=[[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateFormat=format;
    return [dateFormatter stringFromDate:self];
}

- (NSString *)timeStampString
{
    return [self stringWithFormat:TIMESTAMP_IDENTIFIER];
}

- (NSDateComponents *)dateComponentsWithFlag:(NSUInteger)flag
{
    return [[NSCalendar currentCalendar] components:flag fromDate:self];
}

- (NSDateComponents *)commonDateComponents
{
    return [self dateComponentsWithFlag:COMMON_DATECOMPONENT_IDENTIFIER];
}

@end
