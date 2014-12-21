//
//  QDRB4QdwgzdywrbViewController.h
//  zsjf
//渠道日报 渠道客户经理日报
//  Created by xieyunchao on 14-2-16.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"
#import "LeveyPopListView.h"

@interface QDRB4QdwgzdywrbViewController : BaseViewController<UIActionSheetDelegate,LeveyPopListViewDelegate>{
    int col;
    NSString *reportFlag;
    int tableviewy;//报表的y坐标
    UIDatePicker *datePicker;
    BOOL showwgFlag;
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

- (IBAction)showReport:(UIButton*)sender;
@property (retain, nonatomic) IBOutlet UIButton *switchptw2gButton;
@property (retain, nonatomic) IBOutlet UIButton *swithocs2gButton;
@property (retain, nonatomic) IBOutlet UIButton *switch3gButton;
@property (retain, nonatomic) IBOutlet UIButton *switchocs3gjhButton;
@property (retain, nonatomic) IBOutlet UIButton *switchg2g3rhButton;
@property (retain, nonatomic) IBOutlet UIButton *switch4gButton;
@property (retain, nonatomic) IBOutlet UIScrollView *scroll_view;

@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (strong, nonatomic) NSArray *options;
@property (retain,nonatomic) NSMutableDictionary* reqdic; //存储请求数据


- (IBAction)removePickerView:(id)sender; 
- (IBAction)chooseDate:(id)sender; 


@end
