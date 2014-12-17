//
//  MenuViewController.h
//  AlertViewAnimation
//
//  Created by zhangyu on 13-9-17.
//  Copyright (c) 2013年 steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FirstMenuViewController.h"
#import "SecondMenuViewController.h"

@class WoDetailViewController;

@interface MenuViewController : UIViewController<UIScrollViewDelegate>{
    int pageWidth;
    BOOL flag;
    int startX;
    int endX;
    CGRect frame ;
}

@property (retain, nonatomic) IBOutlet UIImageView *cusorImage;
@property(retain,nonatomic) WoDetailViewController* superViewController;
@property(retain,nonatomic) FirstMenuViewController* firstMenuViewController;
@property(retain,nonatomic) SecondMenuViewController* secondMenuViewController;
@property (retain, nonatomic) IBOutlet UIScrollView *myDetailScrollView;
@property(retain,nonatomic) NSMutableArray* mutableMosWoDetailFuncNodeSVOList;
@property (retain, nonatomic) IBOutlet UIButton *normalButton;
@property (retain, nonatomic) IBOutlet UIButton *moreButton;
@property BOOL tag;
//显示视图
- (void)show;
//隐藏视图
- (IBAction)hideAlertAction;

@end
