//
//  ProjectBuildViewController.m
//  zsjf
//
//  Created by xieyunchao on 14-4-7.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import "ProjectBuildViewController.h"
#import "GCJGTJReportViewController.h"
#import "GcztxxtjViewController.h"

@interface ProjectBuildViewController ()

@end

@implementation ProjectBuildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"工程建设信息";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        ////self.edgesForExtendedLayout = UIExtendedEdgeNone;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forward:(UIButton *)sender {
    if (sender.tag==0) {
        GCJGTJReportViewController *viewController = [[GCJGTJReportViewController alloc] initWithNibName:@"GCJGTJReportViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if (sender.tag==1){
        GcztxxtjViewController *viewController = [[GcztxxtjViewController alloc] initWithNibName:@"GcztxxtjViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    
}
@end
