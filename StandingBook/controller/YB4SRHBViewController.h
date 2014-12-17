//
//  YB4SRHBViewController.h
//  zsjf
//收入环比通报(按客户群)
//  Created by xieyunchao on 14-4-22.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LeveyPopListView.h"
#import "ASIHTTPRequestUtils.h"

@interface YB4SRHBViewController :  BaseViewController<UIActionSheetDelegate,LeveyPopListViewDelegate>{
    int col;
    NSString *reportFlag;
    UIDatePicker *datePicker;
    int tableviewy;
    BOOL showwgFlag;
}


@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

- (IBAction)showReport:(UIButton*)sender;
@property (retain, nonatomic) IBOutlet UIButton *switchzczsrButton;
@property (retain, nonatomic) IBOutlet UIButton *switcclyhButton;
@property (retain, nonatomic) IBOutlet UIButton *swithcjlyhsButton;
@property (retain, nonatomic) IBOutlet UIButton *swithzlyhButton;
@property (retain, nonatomic) IBOutlet UIButton *swithczjzButton;
@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (retain,nonatomic) NSMutableDictionary* reqdic; //存储请求数据
@property (strong, nonatomic) NSArray *options;


- (IBAction)removePickerView:(id)sender;

- (IBAction)chooseDate:(id)sender;

@end
