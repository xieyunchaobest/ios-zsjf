//
//  DateSelectViewController.m
//  mos
//
//  Created by Mos on 13-8-23.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "DateSelectViewController.h"

@interface DateSelectViewController ()

@end

@implementation DateSelectViewController
@synthesize  dataPicker; 
@synthesize tag;

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

- (IBAction)saveToDeviceInfoView:(UIButton *)sender{
    NSDate *date= dataPicker.date;
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    [fmt setLocale:[NSLocale currentLocale]];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr=[fmt stringFromDate:date];
      
    if(tag==15){//保修时间
            } 
     
    [fmt release];
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)dealloc {
    [dataPicker release]; 
    [super dealloc];
}
- (void)viewDidUnload {
    [self setDataPicker:nil]; 
    [super viewDidUnload];
}
@end
