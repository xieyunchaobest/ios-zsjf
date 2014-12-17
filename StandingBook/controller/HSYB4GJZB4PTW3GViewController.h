//
//  HSYB4GJZB4PTW3GViewController.h
//  zsjf
//呼市月报 关键指标月通报 普通网3g
//  Created by xieyunchao on 13-11-24.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"

@interface HSYB4GJZB4PTW3GViewController : BaseViewController{
    int col;
    NSString *reportFlag;
    UIDatePicker *datePicker;
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

- (IBAction)showReport:(UIButton*)sender;
@property (retain, nonatomic) IBOutlet UIButton *switchdyfzButton;
@property (retain, nonatomic) IBOutlet UIButton *switchczsrButton;
@property (retain, nonatomic) IBOutlet UIButton *swithczyhsButton;
@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (retain,nonatomic) NSMutableDictionary* reqdic; //存储请求数据


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;


@end