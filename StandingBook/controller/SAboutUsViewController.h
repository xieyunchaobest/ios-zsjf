//
//  AboutUsViewController.h
//  mos
//  关于界面 
//  Created by xuewei on 13-2-21.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAboutUsViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *versionNbr;
@property (retain, nonatomic) IBOutlet UILabel *versionName;


- (IBAction)showReport:(id)sender;

@end
