//
//  DateUtils.h
//  mos
//
//  Created by zhangyuc on 13-3-26.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

//基础日期格式化类
+(NSString *)dateFormatsBase:(NSDate *)dat formats:(NSString *)formats;
+(NSDate*)getDate:(id)timeSince1970;
+(NSString*)getStringDate:(id)timeSince1970 formats:(NSString *)formats;
+(NSString*)getCurrentStrDate;
+(NSString*)getYesterdayStr;
+(NSDate*)getYesterday;

+(NSDate*)getLastMonthEndDay;
+(NSString*)getLastMonthEndDayStr;
+(NSString*)getLastMonthStr;

@end
