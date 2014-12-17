    //
//  main.m
//  mos
//
//  Created by xieyunchao on 13-1-25.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{	
    @autoreleasepool {
       @try {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
       }@catch (NSException *exception) {
           NSLog ( @"Stack Trace: %@" , [exception callStackSymbols ]);
       }
    }
}
