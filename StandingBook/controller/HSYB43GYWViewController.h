//
//  HSYB43GYWViewController.h
//  zsjf
//呼市月报3G业务月报
//  Created by xieyunchao on 13-12-1.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "LeveyPopListView.h"
#import "BaseViewController.h"


@interface HSYB43GYWViewController :BaseViewController<UIActionSheetDelegate,LeveyPopListViewDelegate>{
    int col;
    NSString *reportFlag;
    UIDatePicker *datePicker;
    Boolean showwgFlag;//是否请求网格列表数据，用于查询条件列表的展示。只请求一次
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

@property (strong, nonatomic) NSArray *options;


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;


@end
