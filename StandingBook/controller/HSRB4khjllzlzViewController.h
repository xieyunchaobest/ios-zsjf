//
//  HSRB4khjllzlzViewController.h
//  zsjf
//  呼市日报之客户经理缆桩日报
//  Created by xieyunchao on 13-11-21.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "LeveyPopListView.h"
#import "BaseViewController.h"


@interface HSRB4khjllzlzViewController :BaseViewController<UIActionSheetDelegate,LeveyPopListViewDelegate>{
    int col;
    NSString *reportFlag;
    UIDatePicker *datePicker;
    Boolean showwgFlag;//是否请求网格列表数据，用于查询条件列表的展示。只请求一次
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

- (IBAction)showReport:(UIButton*)sender;
@property (retain, nonatomic) IBOutlet UIButton *switch2gButton;
@property (retain, nonatomic) IBOutlet UIButton *switch3gButton;
@property (retain, nonatomic) IBOutlet UIButton *switch4gButton;
@property (retain, nonatomic) IBOutlet UIButton *swithkdButton;
@property (retain, nonatomic) IBOutlet UIButton *swithghButton;
@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (retain,nonatomic) NSMutableDictionary* reqdic; //存储请求数据
@property (strong, nonatomic) NSArray *options;


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;


@end
