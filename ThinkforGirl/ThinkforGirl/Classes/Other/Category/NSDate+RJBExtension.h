//
//  NSDate+RJBExtension.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/25.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RJBExtension)



/**
 比较 date和fram的差值

 */
- (NSDateComponents *)rjb_deteFrom:(NSDate *)from;



/**
 是否是今年
 */
- (BOOL)isYear;

/**
 是否是今天
 */
- (BOOL)isToday;

/**
 是否是昨天
 */
- (BOOL)isYesterday;

@end
