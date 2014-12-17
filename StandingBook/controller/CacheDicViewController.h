//
//  CacheDicViewController.h
//  用于现实字典列表数据如厂商，型号
//
//  Created by Mos on 13-8-22.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYPassValueDelegate.h"
#import "ASIHTTPRequestUtils.h"

@interface CacheDicViewController : UITableViewController

@property(retain,nonatomic)NSMutableArray* dataArray;

//这里用assign而不用retain是为了防止引起循环引用。
@property(nonatomic,assign) NSObject<ZYPassValueDelegate> *delegate;
@property(assign,nonatomic) int tag;//用于表示哪个字典列表

//用于接收参数
@property (retain, nonatomic) NSMutableDictionary* requestDicData;
@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@end
