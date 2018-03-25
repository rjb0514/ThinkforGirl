//
//  NSDate+RJBExtension.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/25.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "NSDate+RJBExtension.h"

@implementation NSDate (RJBExtension)

- (NSDateComponents *)rjb_deteFrom:(NSDate *)from {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componets =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:from toDate:self options:0];

    return componets;
    
}


- (BOOL)isYear {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger sYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == sYear;
    
}


- (BOOL)isToday {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
   NSDateComponents *nowComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
     NSDateComponents *selfComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    
    return nowComponents.year == selfComponents.year && nowComponents.month == selfComponents.month && selfComponents.day == nowComponents.day;
    
}


- (BOOL)isYesterday {
    
    //比较是不是昨天的关键是  不管时分秒 只计算到天
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyy-mm-dd";
    
    NSDate *nowdate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowdate toDate:selfDate options:0];
    
    
    return components.year ==0 && components.month == 0 && components.day == 2;
    
}


@end
