//
//  GCJSFilterViewController.h
//  zsjf
//  工程竣工筛选界面
//  Created by xieyunchao on 14-3-26.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYPassValueDelegate.h"

@interface GCJSFilterViewController : UIViewController{

    NSString *ActiveFlag;//当前操作的是哪个button
}
@property (retain, nonatomic) IBOutlet UILabel *lblStartTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *lblStartTimeValue;
@property (retain, nonatomic) IBOutlet UIButton *btnStartTime;
@property (retain, nonatomic) IBOutlet UILabel *lblEndTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *lblEndTimeValue;
@property (retain, nonatomic) IBOutlet UIButton *btnEndTime;
@property (retain, nonatomic) IBOutlet UITextField *txtsqr;

- (IBAction)reQuery:(id)sender;



- (IBAction)showDatePicker:(id)sender;
- (IBAction)removePickerView:(id)sender;
- (IBAction)chooseDate:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *myDatePicker;

@property(nonatomic,assign) NSObject<ZYPassValueDelegate> *delegate;



@end
