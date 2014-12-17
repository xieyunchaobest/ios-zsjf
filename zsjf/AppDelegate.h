//
//  AppDelegate.h
//  mos
//
//  Created by xieyunchao on 13-1-25.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;
@class GuideMainViewController;
@class SysUserExtendedMVO;
@class SysConfigCacheMVO;
@class AllTaskListViewController;
@class SLoginViewController;
@class SChooseServerViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{

    GuideMainViewController *guideMainViewController;
    LoginViewController *loginViewController;
    SLoginViewController *sloginViewController;
    SChooseServerViewController *sChooseServerViewController; 

}

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, retain) LoginViewController *guideMainViewController;
//增加导航栏 added by zhangyuc
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) SysUserExtendedMVO *sysUserExtendedMVO;
@property (strong,nonatomic) SysConfigCacheMVO *sysConfigCacheMVO;
@property (strong,nonatomic) NSDictionary *mosFuncNodeSVOList;
@property (strong,nonatomic) NSMutableArray *mosMainFuncNodeSVOList;//主界面某块集合
@property (strong,nonatomic) NSMutableArray *mosWoDetailFuncNodeSVOList;//工单详情集合
@property (strong,nonatomic) NSDictionary *mosFuncNodeImageViewDic;//权限名称与图片名称Mapping
@property (strong,nonatomic) NSDictionary *mosFuncNodeMethodDic;//权限名称与方法名称Mapping
@property(nonatomic,assign) int secNavNodeCount;//模块个数

@property (strong, nonatomic) NSMutableArray *woList;
@property (strong, nonatomic) NSMutableArray *woList4Fetch;//领单列表
@property (strong, nonatomic) NSMutableArray *deviceList;//台账设备列表
@property (strong, nonatomic) NSNumber *count;
@property (strong, nonatomic) NSNumber *count4Fetch; 
@property (nonatomic, retain) NSTimer  *showTimer;
@property (nonatomic, retain) NSString *isEncrypt;
@property (nonatomic, retain) NSData *deviceTzDicInfo; //登录成功后用于缓存字典数据

@end
