//
//  BaseViewController.m
//  zsjf
//
//  Created by xieyunchao on 13-12-15.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "HomePageViewController.h"
#import "dayReportViewController.h"
#import "HSYBViewController.h"
#import "ReportTableViewController.h"
#import "JTRB4WGJLZDGZViewController.h"

@implementation BaseViewController


-(void)initToolBar4zsjf{
    //int y=self.view.frame.size.height-44;
    float toolbary=370.0;
    if(IS_IPHONE5){
        toolbary=458.0;
    }
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, toolbary, self.view.frame.size.width, 44.0)];
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
    btnHome.width=62;
    btnDayReport.width=62;
    btnMonthReport.width=62;
    btnImportgz.width=62;
    
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
    [self.view insertSubview:toolBar atIndex:1];
    
    [btnHome release];
    [btnDayReport release];
    [btnMonthReport release];
    [btnImportgz release];
    [btnArray release];
    [toolBar release];
    
}

-(void)setWrapTitle:(NSString*)title date:(NSString*)adate{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:16];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    titleLabel.numberOfLines = 0;
    
    NSString* fullTitle=[[title stringByAppendingString:@"\n"] stringByAppendingString:adate];
    
    titleLabel.text = fullTitle;  //设置标题
    self.navigationItem.titleView = titleLabel;
    
    [titleLabel release];
    
}

-(NSMutableArray*) getFuncTreeDic:(int) parentNodeTreeId{
    NSMutableArray* tempArray =[DataProcess getSysUserExtendedMVO].arrFuncNodeTree;
    NSMutableArray *data = [[NSMutableArray alloc]initWithCapacity : 2];
    
    for (int i=0; i<tempArray.count ;i++) {
        NSDictionary *treeDic=(NSDictionary*)tempArray[i];
        NSString* aparentNodeTreeId=[treeDic objectForKey:@"parentNodeTreeId"];
        NSString *nodeTreeName=[treeDic objectForKey:@"nodeTreeName"];
        
        if([aparentNodeTreeId isEqualToString:@"0"]){
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
            [dict setObject:nodeTreeName forKey:@"groupname"];
            
            NSMutableArray *arr1=[treeDic objectForKey:@"userFuncNodeList"];
            
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity : 2];
            for (int j=0; j<arr1.count; j++) {
                NSDictionary* d=(NSDictionary*)arr1[j];
                NSString *nodeName=[d objectForKey:@"funcNodeName"];
                [arr addObject:nodeName];
            }
            [dict setObject:arr forKey:@"users"];
            [data addObject:dict];
            [dict release];
        }
    }
    return [data autorelease];
    
}


-(BOOL*) forwardWhich{
    NSMutableArray* ma=[self getFuncTreeDic:0];
    for(int i=0;i<ma.count;i++){
        NSMutableDictionary *md=(NSMutableDictionary*)ma[i];
        NSString *group=[md objectForKey:@"groupname"];
        if([@"重点关注" isEqualToString:group]){
            NSMutableArray *arr=[md objectForKey:@"users"];
            for (int j=0; j<arr.count; j++) {
                NSString* str=(NSString*)arr[j];
                if([@"重点业务发展日报（按客户群）" isEqualToString:str]){//领导看到的报表
                    return YES;
                }
            }
        }
        
        
    }
    return NO;
}




-(void)forwardView:(UIButton*) sender {
    
    NSString *pageName=@"HomePageViewController";
    if (IS_IPHONE5) {
        pageName=@"HomePageViewController_i5";
    }
    
    if(sender.tag==1){
        HomePageViewController *checkViewController = [[HomePageViewController alloc]initWithNibName:pageName bundle:nil];
        [self.navigationController pushViewController:checkViewController animated:YES];
    }else if(sender.tag==2){
        dayReportViewController *checkViewController = [[dayReportViewController alloc]initWithNibName:@"dayReportViewController" bundle:nil];
        [self.navigationController pushViewController:checkViewController animated:YES];
    }else if(sender.tag==3){
        HSYBViewController *checkViewController = [[HSYBViewController alloc]initWithNibName:@"HSYBViewController" bundle:nil];
        [self.navigationController pushViewController:checkViewController animated:YES];
    }else {
        NSMutableArray* arr=[self getFuncTreeDic:1];
        if(arr.count>0){
            //根据权限判断走哪张报表，领导或网格经理
            if([self forwardWhich]){
                ReportTableViewController *viewController = [[ReportTableViewController alloc] initWithNibName:@"ReportTableViewController" bundle:nil];
                viewController.whickReportFlag=@"zdgz";//重点关注日报通报和呼市日报之日通报共用一个报表，只是显示的地区不一样
                [self.navigationController pushViewController:viewController animated:YES];
                [viewController release];
            }else{
                JTRB4WGJLZDGZViewController *viewController = [[JTRB4WGJLZDGZViewController alloc] initWithNibName:@"JTRB4WGJLZDGZViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];
                [viewController release];
            }
            
        }
    }
}

@end
