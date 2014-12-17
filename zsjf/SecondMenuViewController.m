//
//  SecondMenuViewController.m
//  AlertViewAnimation
//
//  Created by zhangyu on 13-9-17.
//  Copyright (c) 2013年 steven. All rights reserved.
//

#import "SecondMenuViewController.h"

@interface SecondMenuViewController ()

@end

@implementation SecondMenuViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhote:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kTakePhoteMethod object:self];
}

- (IBAction)gisdeal:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kGisdealMethod object:self];
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
