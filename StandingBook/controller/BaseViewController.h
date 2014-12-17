//
//  BaseViewController.h
//  zsjf
//
//  Created by xieyunchao on 13-12-15.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewController : UIViewController

-(void)initToolBar4zsjf;

-(BOOL*) forwardWhich;
-(void)setWrapTitle:(NSString*)title date:(NSString*)adate;

@end
