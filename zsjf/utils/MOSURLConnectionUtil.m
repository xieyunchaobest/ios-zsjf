//
//  MOSHttpUtil.m
//  WebServices
//
//  Created by zhangyuc on 13-3-4.
//  Copyright (c) 2013年 zhangyuc. All rights reserved.
//

#import "MOSURLConnectionUtil.h"

@implementation MOSURLConnectionUtil

-(NSString *) doPost:(NSString *) urlString sendContext:(NSString *) jsonString{
    
    NSLog(@"urlString=======>%@",urlString);
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSLog(@"jsonString=======>%@",jsonString);
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *backString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"backString=========>%@",backString);
    return backString;
}

@end
