//
//  ASIHTTPRequestUtils.h
//  TestASIHTTPRequest
//
//  Created by zhangyuc on 13-3-18.
//  Copyright (c) 2013年 zhangyuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProcess.h"
#import "StringUtils.h"
#import "MBProgressHUD.h"
#import "Prompt.h"

@interface ASIHTTPRequestUtils : NSObject{
    id handle;  
    MBProgressHUD *HUD;
}

@property (retain, nonatomic) MBProgressHUD *HUD;
-(ASIHTTPRequestUtils*) initWithHandle:(id)handle;

//post方式使用http协议访问url
-(NSString *) doPost:(NSString *) urlString sendContext:(NSString *) jsonString;
-(void)submit:(NSString*)url param:(NSString*)param action:(SEL) action;
-(void)requestData:(NSString*)subUrl data:(id)data action:(SEL) action;
-(void)requestData:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar;
-(void)requestDataEnc:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar;

-(void)requestDataXML:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar;
-(void)requestDataWithNoResponse:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar;
-(void)requestDataWithExceptionHandling:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar doAfterException:(SEL)doAfterException;
-(void)requestDataWholeUrl:(NSString*)wholeUrl action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar doAfterException:(SEL)doAfterException;
-(void)requestDataForWoDetailCallLog:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar;
-(void)requestIsConnectedData:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar;
@property (nonatomic,retain) id handle; 
-(void)initWithBackBarButtonItem:(id)target;
-(ASIHTTPRequestUtils*) initWithHandleWithoutAutoRelease:(id)handler;

-(void)requestDataFromWholeUrl:(NSString*)url data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar;

-(void)requestDataWithBlock:(NSString*)subUrl data:(id)data blockData:(void(^)(NSData* resData))block isShowProcessBar:(BOOL)isShowProcessBar;
@end
