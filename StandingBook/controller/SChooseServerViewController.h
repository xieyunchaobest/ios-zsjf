//
//  SChooseServerViewController.h
//  mos
//
//  Created by zhangyu on 13-9-9.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "SLoginViewController.h"
@interface SChooseServerViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *serverName;
@property (retain, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextAction:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;

@property (nonatomic,retain) NSString *serverNameStr;
@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;
@property(nonatomic,retain)SLoginViewController *sloginViewController;
@property (nonatomic,retain) NSString *str;
@end
