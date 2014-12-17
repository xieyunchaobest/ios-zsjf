//
//  LoginViewController.h
//  mos
//
//  Created by xieyunchao on 13-1-29.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FuncNavMainViewController.h"
//#import "MainViewController.h"
#import "WoSuccessReturnViewController.h"
#import "MBProgressHUD.h"
#import "ASIHTTPRequestUtils.h"
#import "StringUtils.h"
#import "Prompt.h"
#import "SysUserExtendedMVO.h"
#import "SysConfigCacheMVO.h"
#import "DataProcess.h"

@interface SLoginViewController : UIViewController<MBProgressHUDDelegate>{
    UIImage *imagebtnNormal;
    UIImage *imagebtnPress;
    FuncNavMainViewController *funcNavMainViewControl;
    
    @public BOOL rememberPwd;
    @public BOOL autoLogin;
    
    UIImage *img_chk_normal;
    UIImage *img_chk_checked;
    MBProgressHUD *HUD;
  
    @public BOOL isCiphertext;
    
}
//增加新视图
//@property (nonatomic,retain)MainViewController *mainViewController;
- (IBAction)loginBtnPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnLogin;
@property (retain, nonatomic) IBOutlet UILabel *lblRemeberPwd;
@property (retain, nonatomic) IBOutlet UIButton *btnRemember;
@property (retain, nonatomic) IBOutlet UILabel *lblAutoLogin;
@property (retain, nonatomic) IBOutlet UIButton *btnAutoLogin;
@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;
@property (retain,nonatomic) NSString *userName;
@property (retain,nonatomic) NSString *password;


-(IBAction)textFieldDoneEditing:(id)sender;

@property(nonatomic,retain) FuncNavMainViewController *funcNavMainViewControl;
- (IBAction)goToMainView:(id)sender;
- (IBAction)loginToMainView:(id)sender;


@end
