//
//  StringUtils.m
//  mos
//
//  Created by bear on 13-3-22.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "StringUtils.h"
#import "TFHppleElement.h"
#import "TFHpple.h"
#import <CommonCrypto/CommonDigest.h>

@implementation StringUtils



/**
 * 创建异常页面源码字符串，用于MOS Native替代抛出的异常页面
 * @param errMsg
 * @return
 */

+(NSString*)getAppException4MOS:(NSString*) errMsg{
    NSString *err = [NSString stringWithFormat:@"<!DOCTYPE html><html><head></head><body><span id=\"errinfospan\">%@</span></body></html>",errMsg];
    NSLog(@"err is %@", err);
    return err;
}

/**
 * 判断是否是异常信息
 * @param errMsg
 * @return
 */
+(BOOL )isExcetionInfo:(NSString *)str{
    
    //add by xieyunchao 20130718,解决服务器端由于错误界面中包含空格、回车而无法判断出是否是异常信息的问题
    str=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([str hasPrefix:@"<!DOCTYPE html"] || [str hasPrefix:@"<!DOCTYPE HTML"] || [str hasPrefix:@"<html>"]) {
        return YES ;
    }
    return NO;

}

/**
 * 获取服务器端返回的错误信息描述。当服务器端出现Exception时，客户端得到的结果是一个html 错误界面源码，该方法通过解析html，获得错误描述信息
 * @param result
 * @return
 */

+(NSString *)getExceptionDesc:(NSString *)errMsg{
    
    errMsg =[errMsg stringByReplacingOccurrencesOfString :@"gb2312" withString :@"utf-8"];
    
    NSData *htmlData=[errMsg dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    
    NSString *patern=@"//span[@id='errinfospan']";
    
    NSArray *elements  = [xpathParser searchWithXPathQuery:patern];
    [xpathParser release];
    TFHppleElement *element = nil;
    NSString *elementContent = nil;
    if ([elements count]>0) {
        element = [elements objectAtIndex:0];
        elementContent =[element text];
    }
    //add by xieyunchao 20130718,解决当服务器端报内部错误等无法识别的错误时，客户端不提示错误信息。
    if([elementContent length]==0 ||elementContent==NULL) {
        elementContent=@"服务端出现异常！";
    };
    //获取错误信息
    if ([elementContent hasPrefix:@"服务器端出现异常：调用远程webservice方法失败！"]) {
        NSRange tempRange = [elementContent rangeOfString:@"服务器端出现异常：调用远程webservice方法失败！"];
        elementContent = [elementContent substringFromIndex:tempRange.length];
    }
//    [xpathParser release];
    return elementContent;
}
//拼接url
+(NSString*)getUrl:(NSString*)subUrl{
//  return [NSString stringWithFormat:@"http://svr913.cattsoft.com:9961/web_mos/%@",subUrl];
    //jbossG
    //return [NSString stringWithFormat:@"http://192.168.105.234:8080/web_mos/%@",subUrl];
    //本机
// return [NSString stringWithFormat:@"http://192.168.1.106:8080/web_mos/%@",subUrl];
//    return [NSString stringWithFormat:@"http://10.21.3.64:8080/web_mos/%@",subUr  l];
     return [NSString stringWithFormat:@"http://192.168.1.105:8080/web_mos/%@",subUrl];
    //return [NSString stringWithFormat:@"http://60.31.254.52:8080/web_mos/%@",subUrl];
    
//    return [NSString stringWithFormat:@"http://10.21.3.64:8080/web_mos/%@",subUrl];
   //测试
    
//    return [NSString stringWithFormat:@"http://192.168.100.65:7661/web_mos/%@",subUrl];
   // return [NSString stringWithFormat:@"http://192.168.1.104:8080/web_mos/%@",subUrl];
 //   NSString *ipStr = [DataProcess ge1tConfig:@"serverURL"];//取出缓存中用户输入的接入点的值
   // NSString *serverName1 = @"http://";
    //NSString *serverName2 = @"/web_mos/";
//    NSString *serverName3 = [serverName2 stringByAppendingString:subUrl];
//    NSString *string = [serverName1 stringByAppendingString:ipStr];
//    NSString *serverName = [string stringByAppendingString:serverName3];
//    return serverName;
    
}

/*
 *Desc:MD5加密
 *Added by Zhang Yu 2013-08-09 
 */
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

/*
 *Desc：静态方法：判断字符串是否为空
 *Para：NSString
 *Retrun：BOOL
 *Autor：zhangyuc Added By 2013-03-26
 */
+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/*
 *Desc:double数字四舍五入为字符串
 *param: src原数据 s
 *       format要四舍五入的格式 例如:27.6 格式为@"0.##"可以舍为28
 *Added By zhangyuc 2013-03-28
 */
+(NSString *) doubleToPercentStr:(double)src format:(NSString *)format{
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setFormatterBehavior:format];
    NSString * ns = [fmt stringFromNumber:[NSNumber numberWithFloat:src]];
    [fmt release];
    return ns;
}

@end
