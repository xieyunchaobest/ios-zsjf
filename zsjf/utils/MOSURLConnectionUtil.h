//
//  MOSHttpUtil.h
//  WebServices
//
//  Created by zhangyuc on 13-3-4.
//  Copyright (c) 2013年 zhangyuc. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 *Describe:用于处理URL请求服务的处理工具类
 *Author:  zhangyuc
 */
@interface MOSURLConnectionUtil : NSObject<NSURLConnectionDelegate>

//post方式使用http协议访问url
-(NSString *) doPost:(NSString *) urlString sendContext:(NSString *) jsonString;

@end
