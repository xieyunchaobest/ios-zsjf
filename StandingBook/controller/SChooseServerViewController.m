//
//  SChooseServerViewController.m
//  mos
//
//  Created by zhangyu on 13-9-9.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "SChooseServerViewController.h"

@interface SChooseServerViewController ()

@end

@implementation SChooseServerViewController
@synthesize serverName;
@synthesize nextBtn;
@synthesize serverNameStr;
@synthesize aSIHTTPRequestUtils;
@synthesize sloginViewController;
@synthesize str;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //设置导航栏标题
        self.title = @"选择接入点";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO];
    //设置导航栏样式
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:239.0/255 green:0.0/255 blue:3.0/255 alpha:1]];
    }
//    serverName.text = @"192.168.105.115:7000";
    //隐藏本页面的返回按钮
    [self.navigationItem setHidesBackButton:YES];
    NSString *serverName1 = @"http://";
    NSString *serverName2 = @"/web_mos/loginAction.do?method=isConnected4MOS";
    NSString *serverName3 = serverName.text;
    NSString *string = [serverName1 stringByAppendingString:serverName3];
    serverNameStr = [string stringByAppendingString:serverName2];
    str=[serverNameStr retain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [serverName release];
    [nextBtn release];
    [serverNameStr release];
    [str release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setServerName:nil];
    [self setNextBtn:nil];
    [super viewDidUnload];
}
//测试接入点是否可以连通
- (IBAction)nextAction:(id)sender {
    if ([StringUtils isBlankString:serverName.text]) {
        [Prompt makeText:@"接入点不能为空！" target:self];
        return;
    }
    [DataProcess addOrChangeConfig:serverName.text forKey:@"serverURL"];
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    [aSIHTTPRequestUtils requestIsConnectedData:@"loginAction.do?method=isConnected4MOS" data:nil action:@selector(doAfterNextAction:) isShowProcessBar:YES];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}
-(void)doAfterNextAction:(id)data{
    NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([resultStr isEqualToString:@"success"]) {
        
        [DataProcess addOrChangeConfig:[NSNumber numberWithBool:NO] forKey:@"isFirstRun"];
        [DataProcess addOrChangeConfig:serverName.text forKey:@"serverURL"];
        
        SLoginViewController *g2V = [[SLoginViewController alloc] initWithNibName:@"SLoginViewController" bundle:nil];
        self.sloginViewController = g2V;
        [self.navigationController pushViewController:self.sloginViewController animated:YES];
        
        [g2V release];
    }else{
        [DataProcess addOrChangeConfig:@"" forKey:@"serverURL"];
        [Prompt makeText:@"接入点输入错误或网络异常！" target:self];
    }
    [resultStr release];
}
@end
