//
//  ReportIntrouctionDetailViewController.h
//  zsjf
//报表说明详情
//  Created by xieyunchao on 14-2-15.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"


@interface ReportIntrouctionDetailViewController : UIViewController

@property (retain,nonatomic) NSDictionary *reportDic;
@property (retain, nonatomic) IBOutlet  UITextView *tvReportDetail;

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;
@property (strong, nonatomic) NSArray *list;

@end
