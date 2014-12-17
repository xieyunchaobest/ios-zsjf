//
//  2GYWRBViewController.h
//  zsjf
//  2G业务日报
//  Created by xieyunchao on 13-11-14.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"

@interface G2YWRBViewController : UIViewController{
    int col;
    NSString *reportFlag;
    int tableviewy;//报表的y坐标
    UIDatePicker *datePicker;
    
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

- (IBAction)showReport:(UIButton*)sender;
@property (retain, nonatomic) IBOutlet UIButton *switchCommon2GButton;
@property (retain, nonatomic) IBOutlet UIButton *swithOCS2GButton;
@property (retain, nonatomic) IBOutlet UIView *datepickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;


@property (retain, nonatomic) IBOutlet UITextView *textView;

@end
