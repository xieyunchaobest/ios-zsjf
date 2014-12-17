//
//  GCJSFilterViewController.m
//  zsjf
//
//  Created by xieyunchao on 14-3-26.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import "GCJSFilterViewController.h"
#import "DateUtils.h"
#import "StringUtils.h"
#import "Prompt.h"
#import "StringUtils.h"

@interface GCJSFilterViewController ()

@end

@implementation GCJSFilterViewController

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
    self.title=@"筛选条件";
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

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)reQuery:(id)sender {
    if (![self valdate]) return;
    NSMutableDictionary *md=[[NSMutableDictionary alloc] init];
    NSString *startTime=self.lblStartTimeValue.text;
     NSString *sqr=self.txtsqr.text;
    NSString *endTime=self.lblEndTimeValue.text  ;
    if(![StringUtils isBlankString:startTime]){
        [md setObject:startTime  forKey:@"startDate"];
    }
    if(![StringUtils isBlankString:endTime]){
         [md setObject:endTime  forKey:@"endDate"];
    }
    
    if(![StringUtils isBlankString:sqr]){
        [md setObject:self.txtsqr.text forKey:@"sqr"];
    }
    
    [self.delegate passValue:md];
    [self.navigationController popViewControllerAnimated:true];
    [md release];
    
}

-(void)showDatePicker:(id)sender{
    UIButton *b=(UIButton*)sender;
    if (b.tag==1) {
        ActiveFlag=@"S";//StartTime,即开始时间
    }else{
         ActiveFlag=@"E";//EndTime,即结束时间
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    CGRect mainBounds = [[UIScreen mainScreen] bounds];
    self.pickerView.frame = CGRectMake(0, mainBounds.size.height-300, 320, 300);
    [self.myDatePicker setDate:[DateUtils getYesterday]];
    self.myDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.pickerView];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
}

- (IBAction)removePickerView:(id)sender {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    CGRect mainBounds = [[UIScreen mainScreen] bounds];
    self.pickerView.frame = CGRectMake(0, mainBounds.size.height, 320, 300);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

- (IBAction)chooseDate:(id)sender {
    NSDate *select = [self.myDatePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (self.myDatePicker.datePickerMode == UIDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *selectDate =  [dateFormatter stringFromDate:select];
        NSLog(@"selectDateselectDate%@",selectDate);
        
        // self.myTimeLabel.text = selectDate;
        [self removePickerView:nil];
        // _timeTag = YES;
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *selectDate =  [dateFormatter stringFromDate:select];
        NSLog(@"selectDateselectDate%@",selectDate);
        if([@"S" isEqualToString:ActiveFlag]){
           [ self.lblStartTimeValue setText: selectDate];
        }else{
            [self.lblEndTimeValue setText:selectDate];
        }
        //self.myDateLabel.text = selectDate;
        //[self initData:selectDate];
        [self removePickerView:nil];
        //_dateTag = YES;
    }
}

-(BOOL)valdate{
    NSString *startDate=self.lblStartTimeValue.text;
    NSString *endDate=self.lblEndTimeValue.text;
    NSString *sqr=self.txtsqr.text;
    if([StringUtils isBlankString:startDate]  &&
       [StringUtils isBlankString:endDate] &&
       [StringUtils isBlankString:sqr]
       ){
        [Prompt makeText:@"请输入查询条件！" target:self];
        return false;
    }
    return true;
}



- (void)dealloc {
    [_lblStartTimeLabel release];
    [_lblStartTimeValue release];
    [_btnStartTime release];
    [_lblEndTimeLabel release];
    [_lblEndTimeValue release];
    [_btnEndTime release];
    [_pickerView release];
    [_myDatePicker release];
    [_txtsqr release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLblStartTimeLabel:nil];
    [self setLblStartTimeValue:nil];
    [self setBtnStartTime:nil];
    [self setLblEndTimeLabel:nil];
    [self setLblEndTimeValue:nil];
    [self setBtnEndTime:nil];
    [self setPickerView:nil];
    [self setMyDatePicker:nil];
    [self setTxtsqr:nil];
    [super viewDidUnload];
}
@end
