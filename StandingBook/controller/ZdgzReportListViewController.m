//
//  ZdgzReportListViewController.m
//  zsjf
//
//  Created by xieyunchao on 14-2-16.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import "ZdgzReportListViewController.h"
#import "DataProcess.h"
#import "ReportTableViewController.h"
#import "HSRB42GYWViewController.h"
#import "HSRB43GYWViewController.h"
#import "HSRB4KDYWViewController.h"
#import "HSRB42g3grhViewController.h"
#import "HSRB4zdywlzViewController.h"
#import "HSRB4khjllzlzViewController.h"
#import "JTRB4QSYWFZRB.h"
#import "JTRB4HYBYWFZRBViewController.h"
#import "QDRB4GWDYWFZRBViewController.h"
#import "QDRB4QdwgzdywrbViewController.h"
#import "Xyrb4SqwgzdywViewController.h"


@interface ZdgzReportListViewController ()

@end

@implementation ZdgzReportListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.title=@"重点关注";
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        ////self.edgesForExtendedLayout = UIExtendedEdgeNone;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
//    UIButton *btn1=[self createReportButton:@"           报表一"];
//    btn1.frame=CGRectMake(10, 100, 303, 45);
//    
//    UIButton *btn2=[self createReportButton:@"           报表二三四五六"];
//    btn2.frame=CGRectMake(10, 200, 303, 45);
//    
//    [self.view addSubview:btn1];
//    [self.view addSubview:btn2];
    int y=30;
    NSMutableArray *arr=[self getReportList4zdgz];
    NSString *blank=@"      ";
    
    for (int i=0; i<arr.count; i++) {
        NSDictionary *d= arr[i];
        NSString *funcNodeName=[d objectForKey:@"funcNodeName"];
        
        UIButton *btn=[self createReportButton:[blank stringByAppendingString:funcNodeName]];
        btn.frame=CGRectMake(10, y, 303, 45);
        [btn addTarget:self action:@selector(forwardView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        y=y+55;
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
}



-(NSMutableArray*)getReportList4zdgz{
    NSMutableArray *arr=[self getReportListByUser];
    NSMutableArray *arrRes = [[NSMutableArray alloc] initWithCapacity : 2];
    
    for (int i=0; i<arr.count; i++) {
        NSDictionary *d= arr[i];
        NSString *funcNodeName=[d objectForKey:@"funcNodeName"];
        if([funcNodeName isEqualToString:@"重点业务发展日报（按客户群）"]){
            [arrRes addObject:d];
        }else if([funcNodeName isEqualToString:@"重点业务发展日报 "]){
            [arrRes addObject:d];
        }else if([funcNodeName isEqualToString:@"网格重点业务日报"]){
            [arrRes addObject:d];
        }else if([funcNodeName isEqualToString:@"渠道网格重点业务日报"]){
            [arrRes addObject:d];
        }else if([funcNodeName isEqualToString:@"行业部业务发展日报"]){
            [arrRes addObject:d];
        }else if([funcNodeName isEqualToString:@"区级、市级业务发展日报"]){
            [arrRes addObject:d];
        }
        
    }
    return arrRes;
}



//根据用户权限获取该用户能看到报表列表
-(NSMutableArray*)getReportListByUser{
    NSMutableArray* tempArray =[DataProcess getSysUserExtendedMVO].arrFuncNodeTree;
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity : 2];
    for (int i=0; i<tempArray.count ;i++) {
        NSDictionary *treeDic=(NSDictionary*)tempArray[i];  
        NSMutableArray *arr1=[treeDic objectForKey:@"userFuncNodeList"];
        for (int j=0; j<arr1.count; j++) {
            NSDictionary* d=(NSDictionary*)arr1[j];
            //NSString *nodeName=[d objectForKey:@"funcNodeName"];
            [arr addObject:d];
        }  
    }
    
    return arr;

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIButton*) createReportButton:reportTitle{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:reportTitle forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setBackgroundImage:[UIImage imageNamed:@"bg_report_bg"] forState:UIControlStateNormal];
        return btn;
}

-(void)forwardView :(UIButton* )button{
    NSString *title=button.titleLabel.text;
    title=[title stringByReplacingOccurrencesOfString:@"      " withString:@""];
    
    if([title isEqualToString:@"重点业务发展日报 "]){
        ReportTableViewController *viewController = [[ReportTableViewController alloc] initWithNibName:@"ReportTableViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([title isEqualToString:@"重点业务发展日报（按客户群）"]){
        ReportTableViewController *viewController = [[ReportTableViewController alloc] initWithNibName:@"ReportTableViewController" bundle:nil];
        viewController.whickReportFlag=@"zdgz";
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([title isEqualToString:@"2G业务日报"]){
        HSRB42GYWViewController *g2ywrbview= [[HSRB42GYWViewController alloc] initWithNibName:@"HSRB42GYWViewController" bundle:nil];
        [self.navigationController pushViewController:g2ywrbview animated:YES];
        [g2ywrbview release];
    }else if([title isEqualToString:@"3G业务日报"]){
        HSRB43GYWViewController *g3ywrbview= [[HSRB43GYWViewController alloc] initWithNibName:@"HSRB43GYWViewController" bundle:nil];
        [self.navigationController pushViewController:g3ywrbview animated:YES];
        [g3ywrbview release];
    }else if([title isEqualToString:@"宽带业务日报"]){
        HSRB4KDYWViewController *kdywrbview= [[HSRB4KDYWViewController alloc] initWithNibName:@"HSRB4KDYWViewController" bundle:nil];
        [self.navigationController pushViewController:kdywrbview animated:YES];
        [kdywrbview release];
    }else if([title isEqualToString:@"2G3G融合业务日报"]){
        HSRB42g3grhViewController *g2g3ywrbview= [[HSRB42g3grhViewController alloc] initWithNibName:@"HSRB42g3grhViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }else if(([title isEqualToString:@"网格重点业务日报"])){
        HSRB4zdywlzViewController *g2g3ywrbview= [[HSRB4zdywlzViewController alloc] initWithNibName:@"HSRB4zdywlzViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }else if((([title isEqualToString:@"客户经理揽装日报"]))){
        HSRB4khjllzlzViewController *g2g3ywrbview= [[HSRB4khjllzlzViewController alloc] initWithNibName:@"HSRB4khjllzlzViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
        
    }else if((([title isEqualToString:@"区级、市级业务发展日报"]))){
        JTRB4QSYWFZRB *g2g3ywrbview= [[JTRB4QSYWFZRB alloc] initWithNibName:@"JTRB4QSYWFZRB" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
        
    }else if([title isEqualToString:@"行业部业务发展日报"]){
        JTRB4HYBYWFZRBViewController *g2g3ywrbview= [[JTRB4HYBYWFZRBViewController alloc] initWithNibName:@"JTRB4HYBYWFZRBViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }else if([title isEqualToString:@"各网点业务发展日报"]){
        QDRB4GWDYWFZRBViewController *g2g3ywrbview= [[QDRB4GWDYWFZRBViewController alloc] initWithNibName:@"QDRB4GWDYWFZRBViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }else if([title isEqualToString:@"渠道网格重点业务日报"]){
        QDRB4QdwgzdywrbViewController *g2g3ywrbview= [[QDRB4QdwgzdywrbViewController alloc] initWithNibName:@"QDRB4QdwgzdywrbViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }


}


@end
