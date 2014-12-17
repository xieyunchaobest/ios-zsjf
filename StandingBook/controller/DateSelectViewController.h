//
//  DateSelectViewController.h
//  mos 日期选择视图，用于选择日期
//
//  Created by Mos on 13-8-23.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYPassValueDelegate.h" 

@interface DateSelectViewController : UIViewController


//这里用assign而不用retain是为了防止引起循环引用。
@property(nonatomic,assign) NSObject<ZYPassValueDelegate> *delegate; 
@property(assign,nonatomic) int tag;


//保存日期信息并携带值到基本信息
- (IBAction)saveToDeviceInfoView:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIView *pickerView;


@property (retain, nonatomic) IBOutlet UIDatePicker *dataPicker;





@end
