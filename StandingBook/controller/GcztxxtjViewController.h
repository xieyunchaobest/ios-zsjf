//
//  GcztxxtjViewController.h
//  zsjf
//工程在途信息统计
//  Created by xieyunchao on 14-4-7.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestUtils.h"
#import "BaseViewController.h"
#import "ZYPassValueDelegate.h"

@interface GcztxxtjViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,ZYPassValueDelegate>

@property (nonatomic, retain) NSMutableArray *listContent;

@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) NSMutableDictionary* reqdic; //存储请求数据

@end
