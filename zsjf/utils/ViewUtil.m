//
//  ViewUtil.m
//  zsjf
//
//  Created by xieyunchao on 13-12-15.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "ViewUtil.h"
#import "HomePageViewController.h"
#import "dayReportViewController.h"
#import "HSYBViewController.h"

@implementation ViewUtil

+(void)initToolBar4zsjf:(UIViewController*) vc{
    //int y=self.view.frame.size.height-44;
    float toolbary=370.0;
    if(IS_IPHONE5){
        toolbary=458.0;
    }
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, toolbary, vc.view.frame.size.width, 44.0)];
    toolBar.tag=1000;
    toolBar.tintColor=[UIColor whiteColor];
    
    UIButton *EditBtn,*PhotoBtn,*TwoCodeBtn,*PollingBtn;
    
    
    EditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [EditBtn setFrame:CGRectMake(0, 0, 80, 44)];
    [EditBtn setBackgroundImage:[UIImage imageNamed:@"tool_bar_home_normal"] forState:UIControlStateNormal];
    [EditBtn setBackgroundImage:[UIImage imageNamed:@"tool_bar_home_pressed"] forState:UIControlStateHighlighted];
    [EditBtn addTarget:self action:@selector(forwardView:) forControlEvents:UIControlEventTouchUpInside];
    EditBtn.tag=1;
    
    PhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [PhotoBtn setFrame:CGRectMake(80, 0, 80, 44)];
    [PhotoBtn setBackgroundImage:[UIImage imageNamed:@"tool_bar_day_report_normal"] forState:UIControlStateNormal];
    [PhotoBtn setBackgroundImage:[UIImage imageNamed:@"tool_bar_day_report_pressed"] forState:UIControlStateHighlighted];
    [PhotoBtn addTarget:self action:@selector(forwardView:) forControlEvents:UIControlEventTouchUpInside];
    PhotoBtn.tag=2;
    
    TwoCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [TwoCodeBtn setFrame:CGRectMake(80*2, 0, 80, 44)];
    [TwoCodeBtn setBackgroundImage:[UIImage imageNamed:@"tool_bar_month_report_normal"] forState:UIControlStateNormal];
    [TwoCodeBtn setBackgroundImage:[UIImage imageNamed:@"tool_bar_month_report_pressed"] forState:UIControlStateHighlighted];
    [TwoCodeBtn addTarget:self action:@selector(forwardView:) forControlEvents:UIControlEventTouchUpInside];
    TwoCodeBtn.tag=3;
    
    PollingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [PollingBtn setFrame:CGRectMake(80*3, 0, 80, 44)];
    [PollingBtn setBackgroundImage:[UIImage imageNamed:@"tool_bar_import_view_normal"] forState:UIControlStateNormal];
    [PollingBtn setBackgroundImage:[UIImage imageNamed:@"tool_bar_import_view_pressed"] forState:UIControlStateHighlighted];
    [PollingBtn addTarget:self action:@selector(forwardView:) forControlEvents:UIControlEventTouchUpInside];
    PollingBtn.tag=4;
    
    UIBarButtonItem* btnHome=[[UIBarButtonItem alloc] init];
    UIBarButtonItem* btnDayReport=[[UIBarButtonItem alloc] init];
    UIBarButtonItem* btnMonthReport=[[UIBarButtonItem alloc] init];
    UIBarButtonItem* btnImportgz=[[UIBarButtonItem alloc] init];
    btnHome.width=68;
    btnDayReport.width=68;
    btnMonthReport.width=68;
    btnImportgz.width=68;
    
    [btnHome setCustomView:EditBtn];
    [btnDayReport setCustomView:PhotoBtn];
    [btnMonthReport setCustomView:TwoCodeBtn];
    [btnImportgz setCustomView:PollingBtn];
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    [btnArray addObject:btnHome];
    [btnArray addObject:btnDayReport];
    [btnArray addObject:btnMonthReport];
    [btnArray addObject:btnImportgz];
    
    
    [toolBar setItems:btnArray];
    [vc.view insertSubview:toolBar atIndex:1];
    
    [btnHome release];
    [btnDayReport release];
    [btnMonthReport release];
    [btnImportgz release];
    [btnArray release];
    [toolBar release];
}

-(void)forwardView:(UIButton*) sender viewController: (UIViewController*) vc {
    if(sender.tag==1){
        NSString *pageView=@"HomePageViewController";
        if (IS_IPHONE5) {
            pageView=@"HomePageViewController_i5";
        }
        HomePageViewController *checkViewController = [[HomePageViewController alloc]initWithNibName:pageView bundle:nil];
        [vc.navigationController pushViewController:checkViewController animated:YES];
    }else if(sender.tag==2){
        dayReportViewController *checkViewController = [[dayReportViewController alloc]initWithNibName:@"dayReportViewController" bundle:nil];
        [vc.navigationController pushViewController:checkViewController animated:YES];
    }else if(sender.tag==3){
        HSYBViewController *checkViewController = [[HSYBViewController alloc]initWithNibName:@"HSYBViewController" bundle:nil];
        [vc.navigationController pushViewController:checkViewController animated:YES];
    }else {
        
    }
}

@end
