//
//  HSRB4zdywlzViewController.h
//  zsjf
//重点业务缆桩日报
//  Created by xieyunchao on 13-11-20.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"

@interface Xyrb4SqwgzdywViewController : BaseViewController{
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
@property (retain, nonatomic) IBOutlet UIButton *switchocs3gButton;
@property (retain, nonatomic) IBOutlet UIButton *switchkdButton;
@property (retain, nonatomic) IBOutlet UIButton *switchkdcButton;//宽带拆
@property (retain, nonatomic) IBOutlet UIButton *switch2g3gButton;//2g3g融合
@property (retain, nonatomic) IBOutlet UIButton *switch4gButton;//4融合

@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (retain, nonatomic) IBOutlet UIScrollView *scroll_view;


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;



@end
