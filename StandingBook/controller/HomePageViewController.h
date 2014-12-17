//
//  HomePageViewController.h
//  mos
//
//  Created by mymac on 13-10-25.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"
#import "MosVersionJson.h"

@interface HomePageViewController : BaseViewController{
    NSString *trackViewURL;


}

@property (retain, nonatomic) IBOutlet UIButton *btnSearch;
@property (retain, nonatomic) IBOutlet UIButton *btnScan;
@property (retain, nonatomic) IBOutlet UIButton *btnAdd;
@property (retain, nonatomic) IBOutlet UIButton *btnSetting;
@property (retain, nonatomic) IBOutlet UIButton *btnQuickSearch;
@property (retain, nonatomic) IBOutlet UIButton *btnSDL;
@property (retain,nonatomic) MosVersionJson *mosVersionJson;
@property (retain,nonatomic) NSString *publishPath;
@property (retain, nonatomic) IBOutlet UIImageView *imv_bg;



////掌上经分

@property (retain, nonatomic) IBOutlet UIButton *btnDayReport;//日通报
@property (retain, nonatomic) IBOutlet UIButton *btnMonthReport;//月通报

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSString *isForce;
@property (retain,nonatomic) NSString *versionDesc;


- (IBAction)forwar:(UIButton *)sender;

///




- (IBAction)goNextView:(UIButton *)sender; 

@property (retain, nonatomic) IBOutlet UIImageView *imageH1;

@property (retain, nonatomic) IBOutlet UIImageView *imageH2;

@property (retain, nonatomic) IBOutlet UIImageView *imageV1;

@property (retain, nonatomic) IBOutlet UIImageView *imageBg;

@end
