//
//  AboutUsViewController.m
//  mos
//  关于界面
//  Created by xuewei on 13-2-21.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import "SAboutUsViewController.h"

@interface SAboutUsViewController ()

@end

@implementation SAboutUsViewController
@synthesize versionNbr;
@synthesize versionName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"关于";
        UIImageView  *imageView=nil;
        if(IS_IPHONE5){
            imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
            [imageView setImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
        }else{
            imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
            [imageView setImage:[UIImage imageNamed:@"Default@2x.png"]];
        }
        [self.view addSubview:imageView];
        
        UILabel *versionLabel=[[UILabel alloc] initWithFrame:CGRectMake(210.0, 149.0, 33.0, 21.0)];
        versionLabel.text=@"v1.0";
        [self.view addSubview:versionLabel];

        [imageView release];
        [versionLabel release];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib. 
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [versionNbr release];
    [versionName release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setVersionNbr:nil];
    [self setVersionName:nil];
    [super viewDidUnload];
}
@end
