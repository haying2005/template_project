//
//  NSDateAdditions.h
//  Test
//
//  Created by tan on 13-8-26.
//  Copyright (c) 2013年 tan. All rights reserved.
//

#import <Foundation/Foundation.h>

// in the Gregorian calendar (NSGregorianCalendar) , weekday's value shows below
// Sunday Monday Tuesday Wednesday Thursday Friday Saturday
// 1      2      3       4         5        6      7

#define TIMESTAMP_IDENTIFIER                @"yyyy-MM-dd HH:mm:ss.SSS"
#define COMMON_DATECOMPONENT_IDENTIFIER     (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday)

@interface NSDate (NSDateAdditions)

+ (id)dateWithString:(NSString *)string format:(NSString *)format;
+ (id)dateWithTimestampString:(NSString *)string;

+ (id)dateWithComponents:(NSDateComponents *)components;
+ (id)dateWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day hour:(NSUInteger)hour minute:(NSUInteger)minute second:(NSUInteger)second;

- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)timeStampString;

- (NSDateComponents *)dateComponentsWithFlag:(NSUInteger)flag;
- (NSDateComponents *)commonDateComponents;

@end
