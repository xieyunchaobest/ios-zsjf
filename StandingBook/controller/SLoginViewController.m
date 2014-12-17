//
//  SLoginViewController.m
//  mos
//
//  Created by zhangyuc on 13-08-16.
//  Copyright (c) 2013年 cattsoft. All rights reserved.
//
//

#import "SLoginViewController.h"
#import "StringUtils.h"
#import "Prompt.h"
#import "SysConfigCacheMVO.h"
#import "ReportTableViewController.h"

@interface SLoginViewController ()

@end

@implementation SLoginViewController
@synthesize userNameTextField;
@synthesize passwordTextField;
@synthesize userName;
@synthesize password;
@synthesize aSIHTTPRequestUtils;
@synthesize isCiphertext,autoLogin,rememberPwd;
@synthesize btnRemember;
@synthesize lblRemeberPwd;
@synthesize btnAutoLogin;
@synthesize lblAutoLogin;
@synthesize imagebtnNormal;
@synthesize imagebtnPress;
@synthesize img_chk_checked;
@synthesize img_chk_normal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //设置导航栏标题
        self.title = @"掌上通报";
        //[Prompt makeText:[DateUtils getLastMonthEndDayStr] target:self];
    }
    return self;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //added by zhangyuc 2013-08-16
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        ////self.edgesForExtendedLayout = UIExtendedEdgeNone;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //设置导航栏背景图案
    // NavigationBar background
    // * iOS 5 only *
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1]];
        
    }
    
    //设置导航栏样式
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    //隐藏本页面的返回按钮
    [self.navigationItem setHidesBackButton:YES];
   
    
    UIImageView  *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0, IS_IPHONE5?504.0:480.0)];
    if (IS_IPHONE5) {
        [imgView setImage:[UIImage imageNamed:@"login_background_i5@2x.png"]];
    }else{
         [imgView setImage:[UIImage imageNamed:@"login_background@2x.png"]];
    }
   
    
    NSLog(@"dddddddd=%f",self.view.bounds.size.height);
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:imgView atIndex:0];
    


    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    [self.view addGestureRecognizer:gesture];
    
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rememberPwd:)];
    [lblRemeberPwd addGestureRecognizer:tapGestureTel];
    
    
    UITapGestureRecognizer *tapGestureauto = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(autoLogin:)];
    [lblAutoLogin addGestureRecognizer:tapGestureauto];
    

    
    [tapGestureTel release];
    [tapGestureauto release];
    [self.btnLogin setBackgroundImage:[UIImage imageNamed:@"btn_login_background_pressed"] forState:UIControlStateHighlighted];
}

-(void)viewWillAppear:(BOOL)animated{
    //加载登录信息
    [self loadLoginInfo];
    //自动登录
    if (autoLogin) {
        [self login];
    }
}

//记住密码事件
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
//自动登录事件
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

//隐藏键盘方法
-(void)hideKeyboard:(id)sender{
    [userNameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}


- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}
 

- (IBAction)loginBtnPressed:(id)sender{
    NSLog(@"开始123");
    
    
//    if (!self->isCiphertext) {
        self.userName = userNameTextField.text;
        self.password = passwordTextField.text;
        
//        userName = @"130000000";
//        password = @"111111";

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

-(void)login{
    NSLog(@"开始登录……");
    
    
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=login"] autorelease];
    NSMutableDictionary* requestData = [[NSMutableDictionary alloc] init];
    [requestData setObject:self.userName forKey:@"userName"];
    [requestData setObject:self.password forKey:@"password"];
    if ([[DataProcess getConfig:@"rememberPwd"] boolValue]) {
        [requestData setObject:@"false" forKey:@"isCiphertext"];
        self.password = [DataProcess getConfig:@"password"];
        self.passwordTextField.text = self.password;
        [requestData setObject:self.password forKey:@"password"];
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

    
    //跳转到首页
    if([self forwardWhich]){//通过判断是否有重点关注4领导的权限判断，如果有，则则直接到重点关注领导界面
        ReportTableViewController *viewController = [[ReportTableViewController alloc] initWithNibName:@"ReportTableViewController" bundle:nil];
        viewController.fromPageFlag=@"ANY";
        viewController.whickReportFlag=@"zdgz";//重点关注日报通报和呼市日报之日通报共用一个报表，只是显示的地区不一样
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else{
        NSString *pageName=@"HomePageViewController";
        if (IS_IPHONE5) {
            pageName=@"HomePageViewController_i5";
        }
        HomePageViewController *viewController = [[HomePageViewController alloc] initWithNibName:pageName bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    
}

//初始化缓存
-(void)initCache:(NSDictionary*)dic{
    //本地缓存数据
    ((AppDelegate*)[[UIApplication sharedApplication]delegate]).sysUserExtendedMVO = [SysUserExtendedMVO initWithObject:[dic objectForKey:@"suveJsonObject"]];
//   ((AppDelegate*)[[UIApplication sharedApplication]delegate]).sysConfigCacheMVO = [SysConfigCacheMVO initWithObject:[dic objectForKey:@"sysConfigCache"]];
    
}

//保存用户名密码等登录信息
-(void)saveLoginInfo{
    self.userNameTextField.text = self.userName;
    [DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserName = self.userName;
    [DataProcess addOrChangeConfig:[DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserName forKey:@"userName"];
    [DataProcess addOrChangeConfig:self.userName forKey:@"userName"];
    //从后台取回来的是加密后的密码，因此要用用户输入的密码作为缓存数据
    self.passwordTextField.text = self.password;
    [DataProcess getSysUserExtendedMVO].sysUserSVO.password = self.password;
    [DataProcess addOrChangeConfig:[DataProcess getSysUserExtendedMVO].sysUserSVO.password  forKey:@"password"];
    [DataProcess addOrChangeConfig:self.password forKey:@"password"];
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
    rememberPwd=[[DataProcess getConfig:@"rememberPwd"] boolValue];
    autoLogin=[[DataProcess getConfig:@"autoLogin"] boolValue];
    if (rememberPwd) {
        self.userName = [DataProcess getConfig:@"userName"];
        self.password = [DataProcess getConfig:@"password"];
        self.userNameTextField.text = self.userName;
        if (![StringUtils isBlankString:self.password]) {
            isCiphertext = NO;
            self.passwordTextField.text = @"******";
        }
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

- (void)dealloc {
    [_btnLogin release];
    [lblRemeberPwd release];
    [btnRemember release];
    [lblAutoLogin release];
    [btnAutoLogin release];
    [userNameTextField release];
    [passwordTextField release];
    [aSIHTTPRequestUtils release];
    [userName release];
    [password release];
    [imagebtnNormal release];
    [imagebtnPress release];
    [img_chk_normal release];
    [img_chk_checked release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBtnLogin:nil];
    [self setLblRemeberPwd:nil];
    [self setBtnRemember:nil];
    [self setLblAutoLogin:nil];
    [self setBtnAutoLogin:nil];
    [self setUserNameTextField:nil];
    [self setPasswordTextField:nil];
    [self setASIHTTPRequestUtils:nil];
    [self setUserName:nil];
    [self setPassword:nil];
    [self setImagebtnNormal:nil];
    [self setImagebtnPress:nil];
    [self setImg_chk_normal:nil];
    [self setImg_chk_checked:nil];
    [super viewDidUnload];
}


@end
