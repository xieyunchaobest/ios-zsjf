//
//  JTRB4HYBYWFZRBViewController.h
//  zsjf
//集团日报 行业部业务发展日报
//  Created by xieyunchao on 13-11-23.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"

@interface JTRB4HYBYWFZRBViewController : BaseViewController{
    int col;
    NSString *reportFlag;
    int tableviewy;//报表的y坐标
    UIDatePicker *datePicker;
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

- (IBAction)showReport:(UIButton*)sender;
@property (retain, nonatomic) IBOutlet UIButton *switch2gButton;
@property (retain, nonatomic) IBOutlet UIButton *swith3gButton;
@property (retain, nonatomic) IBOutlet UIButton *swith4gButton;
@property (retain, nonatomic) IBOutlet UIButton *switchwyButton;
@property (retain, nonatomic) IBOutlet UIButton *switchhlwgxButton;
@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;



@end
