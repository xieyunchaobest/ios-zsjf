//
//  HSYBViewController.h
//  zsjf
//呼市月报
//  Created by xieyunchao on 13-11-24.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSYBViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    
	UITableView *tbView;
	NSMutableArray *data;
}

@end
