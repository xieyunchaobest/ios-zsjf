//
//  LoginViewController.m
//  mos
//
//  Created by xieyunchao on 13-1-29.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import "SLoginViewController.h"


@interface SLoginViewController ()
- (IBAction)loginBtnPressed:(id)sender;
- (IBAction)rememberPwd:(UIButton *)sender;
- (IBAction)autoLogin:(id)sender;




@end

@implementation SLoginViewController
@synthesize btnLogin;
@synthesize funcNavMainViewControl;
@synthesize btnRemember;
@synthesize lblRemeberPwd;
@synthesize btnAutoLogin;
@synthesize lblAutoLogin;
@synthesize userNameTextField;
@synthesize passwordTextField;
@synthesize aSIHTTPRequestUtils;
@synthesize userName,password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //设置导航栏标题
        self.title = @"台账系统";
    }
    return self;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //added by zhangyuc start 2013-01-31
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO];
    //设置导航栏背景图案
    // NavigationBar background
    // * iOS 5 only *
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:239.0/255 green:0.0/255 blue:3.0/255 alpha:1]];
    }
    
    //设置导航栏样式
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    //隐藏本页面的返回按钮
    [self.navigationItem setHidesBackButton:YES];
   
    //added by zhangyuc end
    
    [self loadLoginInfo];
    
    imagebtnNormal= [UIImage imageNamed:@"btn_login_bg_normal"];
//    imagebtnPress=[UIImage imageNamed:@"btn_login_bg_press"];
    
    [btnLogin setBackgroundImage:imagebtnNormal forState:UIControlStateNormal];
//    [btnLogin setBackgroundImage:imagebtnPress forState:UIControlStateHighlighted];
    
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rememberPwd:)];
    [lblRemeberPwd addGestureRecognizer:tapGestureTel];
    
    
    UITapGestureRecognizer *tapGestureauto = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(autoLogin:)];
    [lblAutoLogin addGestureRecognizer:tapGestureauto];
    
    //自动登录
    if (autoLogin) {
        [self login];
    }
    
    [tapGestureTel release];
    [tapGestureauto release];
    
    
}

-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [img_chk_checked release];
    [img_chk_normal release];
    [btnRemember release];
    [btnAutoLogin release];
    [lblRemeberPwd release];
    [lblAutoLogin release];
    [btnAutoLogin release];
    [userNameTextField release];
    [passwordTextField release];
    [aSIHTTPRequestUtils release];
    [HUD release];
    [super dealloc];
}
- (void)viewDidUnload {
    
    [self setBtnLogin:nil];
    [self setBtnRemember:nil];
    [self setLblRemeberPwd:nil];
    [self setBtnAutoLogin:nil];
    [self setLblAutoLogin:nil];
    [self setUserNameTextField:nil];
    [self setPasswordTextField:nil];
    [self setASIHTTPRequestUtils:nil];
    rememberPwd = NO;
    autoLogin = NO;
    HUD = nil;
    [super viewDidUnload];
}


- (IBAction)loginBtnPressed:(id)sender {
    NSLog(@"开始123");
   
    
    if (!self->isCiphertext) {
        self.userName = userNameTextField.text;
        self.password = passwordTextField.text;
        
        userName = @"130000000";
        password = @"111111";
//         userName = @"B0000596";
//        password = @"pf12!@";
//        userName = @"BD000494";
//        password = @"pf12!@";
        
    }
    if ([StringUtils isBlankString:self.userName]&&[StringUtils isBlankString:self.password]) {
        [Prompt makeText:@"用户名和密码不能为空！" target:self];
    }else if ([StringUtils isBlankString:self.userName]){
        [Prompt makeText:@"用户名不能为空！" target:self];
    }else if ([StringUtils isBlankString:self.password]){
        [Prompt makeText:@"密码不能为空！" target:self];
    }else{
        [self login];
    }
}

- (IBAction)rememberPwd:(id)sender {
    img_chk_normal=[UIImage imageNamed:@"checkbox-normal"];
    img_chk_checked=[UIImage imageNamed:@"checkbox-choose"];
    NSLog(@"mmmmmm");
    if (rememberPwd==YES) {
        NSLog(@"nnnnnn");
        [self cleanLoginInfo];
        isCiphertext = NO;
        [btnRemember setBackgroundImage:img_chk_normal forState:UIControlStateNormal];
        rememberPwd=NO;
        [btnAutoLogin setBackgroundImage:img_chk_normal forState:UIControlStateNormal];
        autoLogin=NO;
        
    }else{
        [btnRemember setBackgroundImage:img_chk_checked forState:UIControlStateNormal];
        rememberPwd=YES;       
    }    
}

- (IBAction)autoLogin:(id)sender {
    img_chk_normal=[UIImage imageNamed:@"checkbox-normal"];
    img_chk_checked=[UIImage imageNamed:@"checkbox-choose"];
    NSLog(@"jjjjjj");
    if (autoLogin==YES) {
        NSLog(@"kkkkk");
        [btnAutoLogin setBackgroundImage:img_chk_normal forState:UIControlStateNormal];
        autoLogin=NO;
    }else{
        [btnAutoLogin setBackgroundImage:img_chk_checked forState:UIControlStateNormal];
        autoLogin=YES;
        [btnRemember setBackgroundImage:img_chk_checked forState:UIControlStateNormal];
        rememberPwd=YES;        
    }
}

-(void)login{
    NSLog(@"开始登录……");
    
    
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    
    NSString* subUrl=[[[NSString alloc] initWithString:@"loginAction.do?method=spslogin4MOS"] autorelease];
    NSMutableDictionary* requestData = [[NSMutableDictionary alloc] init];
    [requestData setObject:userName forKey:@"userName"];
    [requestData setObject:password forKey:@"password"];
    if ([[DataProcess getConfig:@"rememberPwd"] boolValue]) {
        [requestData setObject:@"true" forKey:@"isCiphertext"];
    }else{
        [requestData setObject:@"false" forKey:@"isCiphertext"];
    }
    
    NSLog(@"Dictionary is : \n%@",requestData);
    
    [aSIHTTPRequestUtils requestData:subUrl data:requestData action:@selector(doAfterLogin:) isShowProcessBar:YES];
    [requestData  release];
}
//登录成功后执行方法
-(void) doAfterLogin:(NSData*)responseData {
    //解析服务器返回数据
    NSDictionary* suveDic = [DataProcess getNSDictionaryFromNSData:responseData];
    NSLog(@"data is : \n%@",suveDic);
    //装填缓存
    [self initCache:suveDic];
    //保存用户名密码，自动登录等
    if (rememberPwd) {
        [self saveLoginInfo];
    }else{
        [self cleanLoginInfo];
    }
    //根据设备判断采取哪一个nib文件 Added By Zhangyu 2013-07-29
    NSString* nibName;
    if(IS_IPHONE5){
        nibName = @"FuncNavMainViewControllerForIP5";
    }else{
        nibName = @"FuncNavMainViewController";
    }
    //跳转至主界面
    FuncNavMainViewController *viewController = [[FuncNavMainViewController alloc] initWithNibName:nibName bundle:nil];
    self.funcNavMainViewControl = viewController;
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}
//保存用户名密码等登录信息
-(void)saveLoginInfo{
    [DataProcess addOrChangeConfig:[DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserName forKey:@"userName"];
    [DataProcess addOrChangeConfig:[DataProcess getSysUserExtendedMVO].sysUserSVO.password  forKey:@"password"];
    [DataProcess addOrChangeConfig:[NSNumber numberWithBool:rememberPwd] forKey:@"rememberPwd"];
    [DataProcess addOrChangeConfig:[NSNumber numberWithBool:autoLogin] forKey:@"autoLogin"];
}
//清除用户名密码等登录信息
-(void)cleanLoginInfo{
    [DataProcess addOrChangeConfig:@"" forKey:@"userName"];
    [DataProcess addOrChangeConfig:@"" forKey:@"password"];
    [DataProcess addOrChangeConfig:[NSNumber numberWithBool:NO] forKey:@"rememberPwd"];
    [DataProcess addOrChangeConfig:[NSNumber numberWithBool:NO] forKey:@"autoLogin"];
}
//加载用户名密码等登录信息
-(void)loadLoginInfo{
    self.userName = [DataProcess getConfig:@"userName"];
    self.password = [DataProcess getConfig:@"password"];
    rememberPwd=[[DataProcess getConfig:@"rememberPwd"] boolValue];
    autoLogin=[[DataProcess getConfig:@"autoLogin"] boolValue];
    userNameTextField.text = userName;
    if (![StringUtils isBlankString:self.password]) {
        isCiphertext = YES;
        passwordTextField.text = @"**********";
    }
    if (rememberPwd) {
        [btnRemember setBackgroundImage:[UIImage imageNamed:@"checkbox-choose"] forState:UIControlStateNormal];
    }else{
        [btnRemember setBackgroundImage:[UIImage imageNamed:@"checkbox-normal"] forState:UIControlStateNormal];
    }
    if (autoLogin) {
        [btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"checkbox-choose"] forState:UIControlStateNormal];
    }else{
        [btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"checkbox-normal"] forState:UIControlStateNormal];
    }
}
//初始化缓存
-(void)initCache:(NSDictionary*)dic{
    //本地缓存数据
    ((AppDelegate*)[[UIApplication sharedApplication]delegate]).sysUserExtendedMVO = [SysUserExtendedMVO initWithObject:[dic objectForKey:@"suveJsonObject"]];
    ((AppDelegate*)[[UIApplication sharedApplication]delegate]).sysConfigCacheMVO = [SysConfigCacheMVO initWithObject:[dic objectForKey:@"sysConfigCache"]];
    
}

- (IBAction)loginToMainView:(id)sender {
}
@end
