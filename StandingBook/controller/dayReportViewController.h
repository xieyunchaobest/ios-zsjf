//
//  expandListViewController.h
//  expandList
//
//  Created by zhangxi on 12-3-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dayReportViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {

	UITableView *tbView;
	NSMutableArray *data;
}
@end

