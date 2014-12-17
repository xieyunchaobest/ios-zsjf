//
//  EditPasswordViewController.h
//  zsjf
//
//  Created by xieyunchao on 13-12-21.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"

@class SSettingViewController;

@interface EditPasswordViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *oldPwd;

@property (retain, nonatomic) IBOutlet UITextField *newPwd;

@property (retain, nonatomic) IBOutlet UITextField *newPwdConfirm;


@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@end
