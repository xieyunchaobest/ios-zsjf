//
//  StringUtils.h
//  mos
//
//  Created by bear on 13-3-22.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProcess.h"
@interface StringUtils : NSObject

+(NSString*)getAppException4MOS:(NSString*)errMsg;

+(BOOL)isExcetionInfo:(NSString*)str;

+(NSString*)getExceptionDesc:(NSString*)result;

+(NSString*)getUrl:(NSString*)subUrl;
//判断字符串是否为空
+(BOOL) isBlankString:(NSString *)string;
//double数字四舍五入为字符串
+(NSString *) doubleToPercentStr:(double)src format:(NSString *)format;
//MD5加密
+ (NSString *)md5:(NSString *)str;
@end
