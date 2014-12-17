//
//  ViewController.h
//  Custom
//重点业务日通报
//  Created by tan on 13-1-22.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"

@interface ReportTableViewController : BaseViewController{
    int col;
    NSString *reportFlag;
    int tableviewy;//报表的y坐标
    UIDatePicker *datePicker;
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

- (IBAction)showReport:(UIButton*)sender;
@property (retain, nonatomic) IBOutlet UIButton *switch2fButton;
@property (retain, nonatomic) IBOutlet UIButton *swith3gButton;
@property (retain, nonatomic) IBOutlet UIButton *swith4gButton;
@property (retain, nonatomic) IBOutlet UIButton *switch2g2gButton;
@property (retain, nonatomic) IBOutlet UIButton *switchkdinstallButton;
@property (retain, nonatomic) IBOutlet UIButton *switchunistallButton;

@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (retain,nonatomic) NSString *fromPageFlag;//标志从哪个界面跳入该界面的，如果是登录后直接跳入该界面，则没有返回按钮


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnHome;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnDayReport;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnMonthReport;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnImportgz;

@property (retain, nonatomic) IBOutlet UIScrollView *scroll_view;


@end
