//
//  DateUtils.m
//  mos
//
//  Created by zhangyuc on 13-3-26.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+(NSString *)dateFormatsBase:(NSDate *)dat formats:(NSString *)formats{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formats];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:dat];
    //alloc后对不使用的对象别忘了release
    [dateFormatter release];
    return currentDateStr;
}
//从json中解析时间
+(NSDate*)getDate:(id)timeSince1970{
    NSDictionary* dateDic = (NSDictionary*)timeSince1970;
    NSString *str = [dateDic objectForKey:@"time"];
    double dateDouble = [str doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateDouble/1000];
    return date;
}

//解析long型时间（未测试）
+(NSDate*)getDateByLong:(id)timeSince1970{
    return [NSDate dateWithTimeIntervalSince1970:[timeSince1970 doubleValue]/1000];
}

//解析long型时间（未测试）
+(NSString*)getStringDate:(id)timeSince1970 formats:(NSString *)formats{

    return [self dateFormatsBase:[self getDate:timeSince1970] formats:formats];
    
}


+(NSString*)getCurrentStrDate{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString ;
    
    
}

+(NSString*)getYesterdayStr{
    NSDate *  senddate= [NSDate dateWithTimeIntervalSinceNow: -(24*60*60) ];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString ;
    
}

+(NSDate*)getYesterday{
    NSDate *  yesterday= [NSDate dateWithTimeIntervalSinceNow: -(24*60*60) ];
    return yesterday ;
}

//获取上个月的第一天,始终不明白为什么把字符转成日期的时候会少一年，所以得手动增加一年
+(NSDate*)getLastMonthEndDay{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMdd"];
    
    NSString*  locationString=[dateformatter stringFromDate:senddate];
    NSString* yearStr=[locationString substringWithRange:NSMakeRange(0,4)];
    int YearInt=[yearStr intValue];
    
    
    
    NSString*  firstDayStr=[ [NSString stringWithFormat:@"%d",YearInt] stringByAppendingString:[locationString substringWithRange:NSMakeRange(4,2)]];
    firstDayStr=[firstDayStr stringByAppendingFormat:@"01"];
    
    NSDate* firstDay=[dateformatter dateFromString:firstDayStr];
    NSDate* lastMonthEndDay=[firstDay initWithTimeInterval:-(24*60*60) sinceDate:firstDay];
    return  lastMonthEndDay;  
    
}

+(NSString*)getLastMonthStr{
    NSString *lastMonth=[self getLastMonthEndDayStr];
    NSString *res =[lastMonth substringWithRange:NSMakeRange(0,7)];
    return res;
}


+(NSString*)getLastMonthEndDayStr{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:[self getLastMonthEndDay]];
    
    return locationString ;

}


@end
