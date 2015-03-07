//
//  QDRB4GWDYWFZRBViewController.h
//  zsjf
//欠费日报-欠费日通报
//  Created by xieyunchao on 13-11-23.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"
#import "LeveyPopListView.h"

@interface Qfrb4QfrtbViewController : BaseViewController<UIActionSheetDelegate,LeveyPopListViewDelegate>{
    int col;
    NSString *reportFlag;
    int tableviewy;//报表的y坐标
    UIDatePicker *datePicker;
    BOOL showwgFlag;
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

- (IBAction)showReport:(UIButton*)sender;
@property (retain, nonatomic) IBOutlet UIButton *switchGwButton;
@property (retain, nonatomic) IBOutlet UIButton *swith2gButton;
@property (retain, nonatomic) IBOutlet UIButton *switch3gButton;
@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (retain, nonatomic) IBOutlet UIButton *switch4gButton;
@property (strong, nonatomic) NSArray *options;
@property (retain,nonatomic) NSMutableDictionary* reqdic; //存储请求数据


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;



@end
