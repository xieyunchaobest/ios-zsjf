//
//  HSRB4KDYWViewController.h
//  zsjf
//呼市日报之宽带业务日报
//  Created by xieyunchao on 13-11-19.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"

@interface HSRB4KDYWViewController : BaseViewController{
    int col;
    NSString *reportFlag;
    UIDatePicker *datePicker;
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

- (IBAction)showReport:(UIButton*)sender;
@property (retain, nonatomic) IBOutlet UIButton *switchkdzButton;
@property (retain, nonatomic) IBOutlet UIButton *swithkdcButton;
@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (retain,nonatomic) NSMutableDictionary* reqdic; //存储请求数据


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;


@end
