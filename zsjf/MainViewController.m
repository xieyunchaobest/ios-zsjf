//
//  MainViewController.m
//  mos
//
//  Created by zhangyuc on 13-1-30.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"主界面";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置一个名字为style的按钮
    UIBarButtonItem *btnStyle = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(onClick:)];
    self.navigationItem.rightBarButtonItem = btnStyle;
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 弹出UIAlert信息
- (void)onClick:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"刷新功能" message:@"暂未开放" delegate:self cancelButtonTitle:@"Cancel按钮" otherButtonTitles:@"OK", nil] show];
}

@end
