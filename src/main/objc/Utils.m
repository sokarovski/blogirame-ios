//
//  Utils.m
//  Blogirame
//
//  Created by Aleksandra Gavrilovska on 4/16/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "Utils.h"
static NSDateFormatter *serverDateFormatter = nil;
static NSDateFormatter *shortTimeFormatter = nil;
static NSDateFormatter *shortDateFormatter = nil;
@implementation Utils
+ (NSDateFormatter *)serverDateFormatter
{
    //2013-04-16 14:44:03
    if (!serverDateFormatter) {
        serverDateFormatter = [[NSDateFormatter alloc] init];
        [serverDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [serverDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CEST"]];
    }
    return serverDateFormatter;
}

+ (NSDateFormatter *)shortTimeFormatter
{
    if (!shortTimeFormatter) {
        shortTimeFormatter = [[NSDateFormatter alloc] init];
        [shortTimeFormatter setLocale:[NSLocale currentLocale]];
        [shortTimeFormatter setDateStyle:NSDateFormatterNoStyle];
        [shortTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return shortTimeFormatter;
}

+ (NSDateFormatter *)shortDateFormatter
{
    if (!shortDateFormatter) {
        shortDateFormatter = [[NSDateFormatter alloc] init];
        [shortDateFormatter setLocale:[NSLocale currentLocale]];
        [shortDateFormatter setDateStyle:NSDateFormatterShortStyle];
        [shortDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return shortDateFormatter;
}

+ (NSInteger)ordinalDaySinceNow:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    int comps = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *dateComponents = [gregorian components:comps fromDate:[NSDate date]];
    NSDate *now = [gregorian dateFromComponents:dateComponents];
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:now];
    NSInteger days = 0;
    if (timeInterval < 0) {
        days = timeInterval / 86400 - 1;
    } else {
        days = timeInterval / 86400;
    }
    return days;
}

+ (NSString *)formattedDateStringFromDate:(NSString *)dateString
{
    NSDate *date = [[Utils serverDateFormatter] dateFromString:dateString];
    if (date) {
        NSInteger ordinalDay = [Utils ordinalDaySinceNow:date];
        if (ordinalDay == 0) {
            return [[Utils shortTimeFormatter] stringFromDate:date];
        }
        if (ordinalDay == - 1) {
            return @"Вчера";
        }
        return [[Utils shortDateFormatter] stringFromDate:date];
    }
    return @"";
}
@end
