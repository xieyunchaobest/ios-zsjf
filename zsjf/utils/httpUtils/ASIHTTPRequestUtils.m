//
//  ASIHTTPRequestUtils.m
//  TestASIHTTPRequest
//
//  Created by zhangyuc on 13-3-18.
//  Copyright (c) 2013年 zhangyuc. All rights reserved.
//

#import "ASIHTTPRequestUtils.h"
#import "ASIHTTPRequest.h"
#import "LFCGzipUtillity.h"
#import "NSString+ThreeDES.h"

@implementation ASIHTTPRequestUtils
@synthesize handle; 
@synthesize HUD;

//单例
+(ASIHTTPRequestUtils*) shareInstance
{
    static ASIHTTPRequestUtils* iSelf = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iSelf = [[ASIHTTPRequestUtils alloc] init];
    });
    return iSelf;
}

-(ASIHTTPRequestUtils*) initWithHandle:(id)handler{
    self = [super init];
    if(self){
        self.handle=handler;
    }
    return [self autorelease];
    
}

//非自动释放
-(ASIHTTPRequestUtils*) initWithHandleWithoutAutoRelease:(id)handler{
    self = [super init];
    if(self){
        self.handle=handler;
    }
    return self;
}



-(void)submit:(NSString*)url param:(NSString*)param action:(SEL) action{
    UIViewController* vc=(UIViewController*)handle;
    HUD = [[MBProgressHUD alloc] initWithView:vc.navigationController.view];
	[vc.navigationController.view addSubview:HUD];
	HUD.delegate = handle;
	HUD.labelText = @"加载中...";
    //取消不可编辑状态
    HUD.userInteractionEnabled = NO;
    //显示进度条
    [HUD show:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        
        //        NSDictionary *aa = [[NSDictionary alloc] init] 
        NSString *responseString = [self doPost:url sendContext:param];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
        [handle performSelector:action withObject:responseString];
        });
    });
}
//请求数据，默认显示进度条
//subUrl:子Url
//data:向服务器发送的数据
//action:请求数据后执行的方法
-(void)requestData:(NSString*)subUrl data:(id)data action:(SEL) action{
    
    UIViewController* viewController=(UIViewController*)handle;
    HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
	[viewController.navigationController.view addSubview:HUD];
	HUD.delegate = handle;
	HUD.labelText = @"加载中...";
    //取消不可编辑状态
    HUD.userInteractionEnabled = NO;
    //显示进度条
    [HUD show:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString* wholeUrl = [StringUtils getUrl:subUrl];
        
        NSString* dataStr = [DataProcess parseToJsonString:data];
        //加密
        if ([[DataProcess IsEncrypt] isEqualToString:@"Y"]) {
            dataStr = [NSString encrypt:dataStr];
        }
        NSString *responseString = [self doPost:wholeUrl sendContext:dataStr];
        NSData *responseData= [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //隐藏进度条
            if (HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            // 更新界面
            if ([StringUtils isBlankString:responseString]) {
                [Prompt makeText:@"服务端无响应结果！" target:handle];
            }else if ([StringUtils isExcetionInfo:responseString]) {
                [Prompt makeText:[StringUtils getExceptionDesc:responseString] target:handle];
            }else{
                [handle performSelector:action withObject:responseData];
            }
        });
    });
}


//请求数据
//subUrl:子Url
//data:向服务器发送的数据
//action:请求数据后执行的方法
//isShowProcessBar:是否显示进度条
-(void)requestDataWithBlock:(NSString*)subUrl data:(id)data blockData:(void(^)(NSData* resData)) aBlock isShowProcessBar:(BOOL)isShowProcessBar{
    if(isShowProcessBar){//是否显示进度条
        UIViewController* viewController=(UIViewController*)handle;
        HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
        //        [viewController.navigationController.view addSubview:HUD];
        //导航栏加到当前视图 Modified by Zhang Yu 2013-07-24
        [viewController.view addSubview:HUD];
        HUD.delegate = handle;
        HUD.labelText = @"加载中...";
        //取消不可编辑状态
        HUD.userInteractionEnabled = NO;
        //显示进度条
        [HUD show:YES];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString* wholeUrl = [StringUtils getUrl:subUrl];
        
        NSString* dataStr = [DataProcess parseToJsonString:data];
        //加密
        
        if ([[DataProcess IsEncrypt] isEqualToString:@"Y"]) {
            dataStr = [NSString encrypt:dataStr];
        }
        
        
        NSString *responseString = [self doPost:wholeUrl sendContext:dataStr];
        //        [dataStr release];
        
        NSData *responseData= [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //隐藏进度条
            if (isShowProcessBar&&HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            // 更新界面
            if ([StringUtils isBlankString:responseString]) {
                [Prompt makeText:@"服务端无响应结果！" target:handle];
            }else if ([StringUtils isExcetionInfo:responseString]) {
                [Prompt makeText:[StringUtils getExceptionDesc:responseString] target:handle];
            }else{
                aBlock(responseData);
            }
        });
    });
}




//请求数据
//subUrl:子Url
//data:向服务器发送的数据
//action:请求数据后执行的方法
//isShowProcessBar:是否显示进度条
-(void)requestData:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar{
    if(isShowProcessBar){//是否显示进度条
        UIViewController* viewController=(UIViewController*)handle;
        HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
//        [viewController.navigationController.view addSubview:HUD];
        //导航栏加到当前视图 Modified by Zhang Yu 2013-07-24
        [viewController.view addSubview:HUD];
        HUD.delegate = handle;
        HUD.labelText = @"加载中...";
        //取消不可编辑状态
        HUD.userInteractionEnabled = NO;
        //显示进度条
        [HUD show:YES];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString* wholeUrl = [StringUtils getUrl:subUrl];
        NSLog(@"请求url路径为：====>%@",wholeUrl);
        
        NSString* dataStr = [DataProcess parseToJsonString:data];
        //加密
        
        
        
        NSString *responseString = [self doPost:wholeUrl sendContext:dataStr];
//        [dataStr release];
        
        NSData *responseData= [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //隐藏进度条
            if (isShowProcessBar&&HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            // 更新界面
            if ([StringUtils isBlankString:responseString]) {
                [Prompt makeText:@"服务端无响应结果！" target:handle];
            }else if ([StringUtils isExcetionInfo:responseString]) {
                [Prompt makeText:[StringUtils getExceptionDesc:responseString] target:handle];
            }else{
                [handle performSelector:action withObject:responseData];
            }
        });
    });
}

//请求数据
//subUrl:子Url
//data:向服务器发送的数据，不加密，不压缩
//action:请求数据后执行的方法
//isShowProcessBar:是否显示进度条
-(void)requestDataEnc:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar{
    if(isShowProcessBar){//是否显示进度条
        UIViewController* viewController=(UIViewController*)handle;
        HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
        //        [viewController.navigationController.view addSubview:HUD];
        //导航栏加到当前视图 Modified by Zhang Yu 2013-07-24
        [viewController.view addSubview:HUD];
        HUD.delegate = handle;
        HUD.labelText = @"加载中...";
        //取消不可编辑状态
        HUD.userInteractionEnabled = NO;
        //显示进度条
        [HUD show:YES];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString* wholeUrl = [StringUtils getUrl:subUrl];
        
        NSString* dataStr = [DataProcess parseToJsonString:data];
        
        NSString *responseString = [self doPostEnc:wholeUrl sendContext:dataStr];
        //        [dataStr release];
        
        NSData *responseData= [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //隐藏进度条
            if (isShowProcessBar&&HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            // 更新界面
            if ([StringUtils isBlankString:responseString]) {
                [Prompt makeText:@"服务端无响应结果！" target:handle];
            }else if ([StringUtils isExcetionInfo:responseString]) {
                [Prompt makeText:[StringUtils getExceptionDesc:responseString] target:handle];
            }else{
                [handle performSelector:action withObject:responseData];
            }
        });
    });
}




//请求数据
//subUrl:子Url
//data:向服务器发送的数据
//action:请求数据后执行的方法
//isShowProcessBar:是否显示进度条
-(void)requestDataFromWholeUrl:(NSString*)url data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar{
    if(isShowProcessBar){//是否显示进度条
        UIViewController* viewController=(UIViewController*)handle;
        HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
        //        [viewController.navigationController.view addSubview:HUD];
        //导航栏加到当前视图 Modified by Zhang Yu 2013-07-24
        [viewController.view addSubview:HUD];
        HUD.delegate = handle;
        HUD.labelText = @"加载中...";
        //取消不可编辑状态
        HUD.userInteractionEnabled = NO;
        //显示进度条
        [HUD show:YES];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString* wholeUrl = url;
        
        NSString* dataStr = [DataProcess parseToJsonString:data];
        
        NSString *responseString = [self doPost:wholeUrl sendContext:dataStr];
        //        [dataStr release];
        
        NSData *responseData= [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //隐藏进度条
            if (isShowProcessBar&&HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            // 更新界面
            if ([StringUtils isBlankString:responseString]) {
                [Prompt makeText:@"服务端无响应结果！" target:handle];
            }else if ([StringUtils isExcetionInfo:responseString]) {
                [Prompt makeText:[StringUtils getExceptionDesc:responseString] target:handle];
            }else{
                [handle performSelector:action withObject:responseData];
            }
        });
    });
}


//请求数据
//subUrl:子Url
//data:向服务器发送的xml数据
//action:请求数据后执行的方法
//isShowProcessBar:是否显示进度条
-(void)requestDataXML:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar{
    if(isShowProcessBar){//是否显示进度条
        UIViewController* viewController=(UIViewController*)handle;
        HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
        [viewController.navigationController.view addSubview:HUD];
        HUD.delegate = handle;
        HUD.labelText = @"加载中...";
        //取消不可编辑状态
        HUD.userInteractionEnabled = NO;
        //显示进度条
        [HUD show:YES];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString* wholeUrl = [StringUtils getUrl:subUrl];
        
        //加密
        NSString*  dataStr;
        if ([[DataProcess IsEncrypt] isEqualToString:@"Y"]) {
           dataStr = [NSString encrypt:data];
        }else {
            dataStr = data;
        }
        

        NSString *responseString = [self doPost:wholeUrl sendContext:dataStr];
        
        NSData *responseData= [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //隐藏进度条
            if (isShowProcessBar&&HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            // 更新界面
            if ([StringUtils isBlankString:responseString]) {
                [Prompt makeText:@"服务端无响应结果！" target:handle];
            }else if ([StringUtils isExcetionInfo:responseString]) {
                [Prompt makeText:[StringUtils getExceptionDesc:responseString] target:handle];
            }else{
                [handle performSelector:action withObject:responseData];
            }
        });
    });
}
//请求数据
//subUrl:子Url
//data:向服务器发送的数据
//action:请求数据后执行的方法
//isShowProcessBar:是否显示进度条
-(void)requestIsConnectedData:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar{
    if(isShowProcessBar){//是否显示进度条
        UIViewController* viewController=(UIViewController*)handle;
        HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
        [viewController.navigationController.view addSubview:HUD];
        HUD.delegate = handle;
        HUD.labelText = @"加载中...";
        //取消不可编辑状态
        HUD.userInteractionEnabled = NO;
        //显示进度条
        [HUD show:YES];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString* wholeUrl = [StringUtils getUrl:subUrl];
        
        NSString* dataStr = [DataProcess parseToJsonString:data];
        //加密
        
        if ([[DataProcess IsEncrypt] isEqualToString:@"Y"]) {
            dataStr = [NSString encrypt:dataStr];
        }
        
        NSString *responseString = [self doPost:wholeUrl sendContext:dataStr];
        
        NSData *responseData= [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //隐藏进度条
            if (isShowProcessBar&&HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            
            [handle performSelector:action withObject:responseData];
        });
    });
}

  
//请求数据，用于无返回值的情况
//subUrl:子Url
//data:向服务器发送的数据
//action:请求数据后执行的方法
//isShowProcessBar:是否显示进度条
-(void)requestDataWithNoResponse:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar{
    if(isShowProcessBar){//是否显示进度条
        UIViewController* viewController=(UIViewController*)handle;
        HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
        [viewController.navigationController.view addSubview:HUD];
        HUD.delegate = handle;
        HUD.labelText = @"加载中...";
        //取消不可编辑状态
        HUD.userInteractionEnabled = NO;
        //显示进度条
        [HUD show:YES];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString* wholeUrl = [StringUtils getUrl:subUrl];
        
        NSString* dataStr = [DataProcess parseToJsonString:data];
        //加密
        if ([[DataProcess IsEncrypt] isEqualToString:@"Y"]) {
            dataStr = [NSString encrypt:dataStr];
        }
        
        NSString *responseString = [self doPost:wholeUrl sendContext:dataStr];
        
      
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //隐藏进度条
            if (isShowProcessBar&&HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            // 更新界面
            if ([StringUtils isExcetionInfo:responseString]) {
                [Prompt makeText:[StringUtils getExceptionDesc:responseString] target:handle];
            }else{
                [handle performSelector:action];
            }
        });
    });
}

//请求数据，用于有返回值并且自定义异常处理的情况
//subUrl:子Url
//data:向服务器发送的数据
//action:请求数据后执行的方法
//isShowProcessBar:是否显示进度条
//doAfterException发生异常后执行的操作
-(void)requestDataWithExceptionHandling:(NSString*)subUrl data:(id)data action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar doAfterException:(SEL)doAfterException{
    if(isShowProcessBar){//是否显示进度条
        UIViewController* viewController=(UIViewController*)handle;
        HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
        [viewController.navigationController.view addSubview:HUD];
        HUD.delegate = handle;
        HUD.labelText = @"加载中...";
        //取消不可编辑状态
        HUD.userInteractionEnabled = NO;
        //显示进度条
        [HUD show:YES];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString* wholeUrl = [StringUtils getUrl:subUrl];
        
        NSString* dataStr = [DataProcess parseToJsonString:data];
        //加密
        if ([[DataProcess IsEncrypt] isEqualToString:@"Y"]) {
            dataStr = [NSString encrypt:dataStr];
        }
        
        NSString *responseString = [self doPost:wholeUrl sendContext:dataStr];
//        [dataStr release];
        
        NSData *responseData= [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //隐藏进度条
            if (isShowProcessBar&&HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            // 更新界面
            if ([StringUtils isBlankString:responseString]) {
                [Prompt makeText:@"服务端无响应结果！" target:handle];
            }else if ([StringUtils isExcetionInfo:responseString]) {
                [Prompt makeText:[StringUtils getExceptionDesc:responseString] target:handle];
                [handle performSelector:doAfterException];
            }else{
                [handle performSelector:action withObject:responseData];
            }
        });
    });
}



//请求数据
//wholeUrl:完整的Url
//action:请求数据后执行的方法
//isShowProcessBar:是否显示进度条
-(void)requestDataWholeUrl:(NSString*)wholeUrl action:(SEL) action isShowProcessBar:(BOOL)isShowProcessBar doAfterException:(SEL)doAfterException{
    if(isShowProcessBar){//是否显示进度条
        UIViewController* viewController=(UIViewController*)handle;
        HUD = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
        [viewController.navigationController.view addSubview:HUD];
        HUD.delegate = handle;
        HUD.labelText = @"加载中...";
        //取消不可编辑状态
        HUD.userInteractionEnabled = NO;
        //显示进度条
        [HUD show:YES];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSString *responseString ;
        
        //第一步，创建URL
        NSURL *url = [NSURL URLWithString:wholeUrl];
        //第二步，创建请求
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //设置请求超时时间
        [request setTimeOutSeconds:30];
        //第三步，连接服务器
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            NSString *response = [request responseString];
            responseString = response;
        }else{
            responseString = [StringUtils getAppException4MOS:@"网络连接异常，请检查网络设置！"];
        }
        
        NSData *responseData= [responseString dataUsingEncoding:NSUTF8StringEncoding];

        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //隐藏进度条
            if (isShowProcessBar&&HUD)
            {
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }
            // 更新界面
            if ([StringUtils isBlankString:responseString]) {
                [Prompt makeText:@"服务端无响应结果！" target:handle];
            }else if ([StringUtils isExcetionInfo:responseString]) {
                [Prompt makeText:[StringUtils getExceptionDesc:responseString] target:handle];
                [handle performSelector:doAfterException];
            }else{
                [handle performSelector:action withObject:responseData];
            }
        });
    });
}

-(NSString *) doPost:(NSString *) urlString sendContext:(NSString *) jsonString{
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    //第二步，创建请求
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //设置请求超时时间
    [request setTimeOutSeconds:60];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];//追加参数数据
    [request setRequestMethod:@"POST"];//设置请求方式
    //第三步，连接服务器
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        
        NSData *responseData = [request responseData];
        //解压
        NSData * uncompData =   [LFCGzipUtillity uncompressZippedData:responseData];
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *response= [[[NSString alloc]initWithData:uncompData encoding:enc] autorelease];
        
        //判断是否解密
        if ([[DataProcess IsEncrypt] isEqualToString:@"Y"]) {
            response = [NSString decrypt:response];
        }
        
        return response;
        
    }else{
        return [StringUtils getAppException4MOS:@"网络连接异常，请检查网络设置！"];
    }
    
    
}

-(NSString *) doPostEnc:(NSString *) urlString sendContext:(NSString *) jsonString{
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    //第二步，创建请求
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //设置请求超时时间
    [request setTimeOutSeconds:30];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];//追加参数数据
    [request setRequestMethod:@"POST"];//设置请求方式
    //第三步，连接服务器
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        
        NSString *response = [request responseString];
       
        return response;
        
    }else{        
        return [StringUtils getAppException4MOS:@"网络连接异常，请检查网络设置！"];
    }
    
        
}




- (void) dumpError:(NSError *) error {
    NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
    NSArray* detailedErrors = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
    if(detailedErrors != nil && [detailedErrors count] > 0) {
        for(NSError* detailedError in detailedErrors) {
            NSLog(@"  DetailedError: %@", [detailedError userInfo]);
        }
    }
    else {
        NSLog(@"  %@", [error userInfo]);
    }
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	handle=nil;
    HUD = nil;
    [super dealloc];
}


/*
 *Desc:中断进度条 start
 *Added By zhangyuc 2013-03-28
 */
//初始化返回按钮
-(void)initWithBackBarButtonItem:(id)target{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 32)];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    UIImage *normal = [UIImage imageNamed:@"titlebar_img_btn_back_normal.png"];
    UIImage *pressed = [UIImage imageNamed:@"titlebar_img_btn_back_pressed.png"];
    [leftButton setImage:normal forState:UIControlStateNormal];
    [leftButton setImage:pressed forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(popToPreView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton release];
    ((UIViewController *)target).navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
}
- (void)popToPreView:(id)sender
{
    //隐藏进度条
    if (HUD)
    {
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }
    //返回上一个视图
    [((UIViewController *)handle).navigationController popViewControllerAnimated:YES];
}
/*
 *Desc:中断进度条 end
 */

@end
