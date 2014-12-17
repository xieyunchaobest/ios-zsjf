//
//  SSettingViewController.h
//  mos
//
//  Created by zhangyu on 13-8-16.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLoginViewController.h"


@interface SSettingViewController : UITableViewController{
    
    NSArray *settingSection;
    NSString *serverNameStr;
}
@property(nonatomic,strong) NSDictionary *settingContent;
@property(nonatomic,strong) NSArray *settingSection;
@property(nonatomic,retain) UITableViewCell *setCell;
@property(nonatomic,retain) SLoginViewController *sLoginViewController;
@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;
@property(nonatomic,strong) NSString *publishPath;

@end
