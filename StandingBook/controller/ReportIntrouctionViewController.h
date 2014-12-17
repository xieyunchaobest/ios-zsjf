//
//  ReportIntrouctionViewController.h
//  zsjf
//报表说明
//  Created by xieyunchao on 14-2-15.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"


@interface ReportIntrouctionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *list;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@end
