//
//
//  zsjf
// 4G日报-4g业务日报
//  Created by xieyunchao on 13-11-19.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"
#import "LeveyPopListView.h"

@interface HSRB44gywrbViewController : BaseViewController<UIActionSheetDelegate,LeveyPopListViewDelegate>{
    int col;
    NSString *reportFlag;
    UIDatePicker *datePicker;
    Boolean showwgFlag;//是否请求网格列表数据，用于查询条件列表的展示。只请求一次
}

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property (retain,nonatomic) NSDictionary *reslist;

@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (retain,nonatomic) NSString *whickReportFlag;
@property (retain,nonatomic) NSMutableDictionary* reqdic; //存储请求数据

@property (strong, nonatomic) NSArray *options;
@property (strong, nonatomic) NSArray *optionsOther; //两个列表查询条件的时候会用


- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;


@end
