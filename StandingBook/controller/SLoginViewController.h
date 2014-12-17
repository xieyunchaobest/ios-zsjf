//
//  SLoginViewController.h
//  mos
//
//  Created by zhangyuc on 13-08-16.
//  Copyright (c) 2013年 cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "ASIHTTPRequestUtils.h"
#import "HomePageViewController.h"

/*
 *Desc:台账登陆页面
 *Added By zhangyuc 2013-08-16
 */
@interface SLoginViewController : BaseViewController

@property (retain, nonatomic) IBOutlet UIButton *btnLogin;
@property (retain, nonatomic) IBOutlet UILabel *lblRemeberPwd;
@property (retain, nonatomic) IBOutlet UIButton *btnRemember;
@property (retain, nonatomic) IBOutlet UILabel *lblAutoLogin;
@property (retain, nonatomic) IBOutlet UIButton *btnAutoLogin;
@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
//通讯类
@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;
//用户名密码
@property (copy,nonatomic) NSString *userName;
@property (copy,nonatomic) NSString *password;
//表示是否记住密码
@property BOOL isCiphertext;
//表示是否自动登陆
@property BOOL autoLogin;
//记住密码
@property BOOL rememberPwd;

@property (retain, nonatomic) UIImage *imagebtnNormal;
@property (retain, nonatomic) UIImage *imagebtnPress;
@property (retain, nonatomic) UIImage *img_chk_normal;
@property (retain, nonatomic) UIImage *img_chk_checked;

//跳到主界面
//- (IBAction)goToMainView:(id)sender;
//登陆事件
- (IBAction)loginBtnPressed:(id)sender;
//文本框键盘消失
- (IBAction)textFieldDoneEditing:(id)sender;
//记住密码事件
- (IBAction)rememberPwd:(id)sender;
//自动登录事件
- (IBAction)autoLogin:(id)sender;

@end
