//
//  AppDelegate.m
//  mos
//
//  Created by xieyunchao on 13-1-25.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideMainViewController.h" 
#import "SLoginViewController.h"
#import "SChooseServerViewController.h"

@implementation AppDelegate
@synthesize window;
@synthesize woList;
@synthesize woList4Fetch;
@synthesize deviceList;
@synthesize sysUserExtendedMVO;
@synthesize sysConfigCacheMVO;
@synthesize count;
@synthesize count4Fetch;
@synthesize deviceTzDicInfo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        //[ [ UINavigationBar appearance] setBarTintColor :[UIColor colorWithRed:239.0/255 green:0.0/255 blue:3.0/255 alpha:1] ] ;
        [ [ UINavigationBar appearance] setBarTintColor :[UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1] ] ;
    }
    
    [self.window makeKeyAndVisible];
    if ([[DataProcess getConfig:@"projectTag"] isEqualToString:@"StandingBook"]) {
        if ([[DataProcess getConfig:@"isFirstRun"] boolValue]) {
            sloginViewController = [[SLoginViewController alloc] init];
            //增加导航栏 added by zhangyuc
            self.navController = [[UINavigationController alloc] initWithRootViewController:sloginViewController];
            self.window.rootViewController = _navController;
            
//            sChooseServerViewController = [[SChooseServerViewController alloc] init];
//            //增加导航栏 added by zhangyuc
//            self.navController = [[UINavigationController alloc] initWithRootViewController:sChooseServerViewController];
//            self.window.rootViewController = _navController;
            
        }else{
            sloginViewController = [[SLoginViewController alloc] init];
            //增加导航栏 added by zhangyuc
            self.navController = [[UINavigationController alloc] initWithRootViewController:sloginViewController];
            self.window.rootViewController = _navController;
        }
    }else{
        
    }
    [NSThread sleepForTimeInterval:1.0];//欢迎页显示时间
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    { //Check if our iOS version supports multitasking I.E iOS 4
        if ([[UIDevice currentDevice] isMultitaskingSupported])
        { //Check if device supports mulitasking
            UIApplication *application = [UIApplication sharedApplication]; //Get the shared application instance
            
            __block UIBackgroundTaskIdentifier background_task; //Create a task object
            
            background_task = [application beginBackgroundTaskWithExpirationHandler: ^{
                /*
                 当应用程序后台停留的时间为0时，会执行下面的操作（应用程序后台停留的时间为600s，可以通过backgroundTimeRemaining查看）
                 */
                [application endBackgroundTask: background_task]; //Tell the system that we are done with the tasks
                background_task = UIBackgroundTaskInvalid; //Set the task to be invalid
                
                //System will be shutting down the app at any point in time now
            }];
            
            // Background tasks require you to use asyncrous tasks
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //Perform your tasks that your application requires
                NSLog(@"--------time remain:%f", application.backgroundTimeRemaining);
                [application endBackgroundTask: background_task]; //End the task so the system knows that you are done with what you need to perform
                background_task = UIBackgroundTaskInvalid; //Invalidate the background_task
            });
        }
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (application.applicationIconBadgeNumber>0) {
      
    }
    
    NSLog(@"[UIApplication sharedApplication].applicationIconBadgeNumber==%ld",(long)[UIApplication sharedApplication].applicationIconBadgeNumber);
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    [DataProcess addOrChangeConfig:deviceToken forKey:@"deviceToken"];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

-(void) application:(UIApplication *) application  didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //当用户打开程序时候收到远程通知后执行
    if (application.applicationState == UIApplicationStateActive) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"新消息提示"
                                                            message:[NSString stringWithFormat:@"\n%@",
                                                                     [[userInfo objectForKey:@"aps"] objectForKey:@"alert"]]
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        
        
        
        [alertView show];
        [alertView release];
        
        
        
    }
    
    
}

-(void)dealloc{
    [sysUserExtendedMVO release];
    [count release];
    [count4Fetch release];
    [woList release];
    [woList4Fetch release];
    [guideMainViewController release];
    [loginViewController release];
    [sysConfigCacheMVO release];
    [deviceTzDicInfo release];
    [super dealloc];
}

@end
