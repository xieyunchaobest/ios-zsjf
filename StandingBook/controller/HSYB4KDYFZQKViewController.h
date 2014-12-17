//
//  HSYB4KDYFZQKViewController.h
//  zsjf
//呼市月报 宽带月发展情况
//  Created by xieyunchao on 13-12-1.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"

@interface HSYB4KDYFZQKViewController : BaseViewController{
    int col;
    NSString *reportFlag;
    UIDatePicker *datePicker;
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (retain,nonatomic) NSMutableDictionary* reqdic; //存储请求数据


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;


@end