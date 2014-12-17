//
//  HomePageViewController.m
//  mos
//
//  Created by mymac on 13-10-25.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "HomePageViewController.h"
#import "SSettingViewController.h" 
#import "dayReportViewController.h"
#import "ReportTableViewController.h"
#import "HSYBViewController.h"
#import "SSettingViewController.h"
#import "JTRB4WGJLZDGZViewController.h"
#import "EditPasswordViewController.h"
#import "ZdgzReportListViewController.h"
#import "GCJGTJReportViewController.h"
#import "ProjectBuildViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController
@synthesize aSIHTTPRequestUtils;
@synthesize isForce;
@synthesize versionDesc;
@synthesize mosVersionJson;
@synthesize publishPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self.navigationItem setHidesBackButton:YES];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"掌上通报";
     isForce = @"N";
    // Do any additional setup after loading the view from its nib.
    //初始化缓存数据
    //[self getCacheDicInfo];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
       //// self.edgesForExtendedLayout = UIExtendedEdgeNone;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    if (IS_IPHONE5) {
//        [_imageBg setFrame:CGRectMake(0, 0, 320.0, 504)];
//        [_imageBg setImage:[UIImage imageNamed:@"home_page_background_586"]];
//    }
  
   // _imageBg.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    
    //设置下一页面的返回按钮
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = nil;
    [temporaryBarButtonItem release];
    [self getResponse];
    [self modifyPwdConfirm];
    
}

//初次使用密码提示用户修改
-(void)modifyPwdConfirm{
  NSString *sysUserId=[DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserId;
  NSString* pwdModified=  [DataProcess getConfig:sysUserId];
    if([StringUtils isBlankString:pwdModified]){
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"修改密码" message:@"初次使用，强烈建议您修改密码!" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"修改", nil] autorelease];
        alert.tag=100;
        [alert show];
    }else{
        
    }

}


/**
 获得最新版本号
 **/
-(void)getLastVersion:(id)data{
    NSDictionary* mosVersionDic = [DataProcess getNSDictionaryFromNSData:data];
    if ([mosVersionDic isEqual:[NSNull null]]) {
        return;
    }
    mosVersionJson = [MosVersionJson initWithObject:mosVersionDic];
    versionDesc = mosVersionJson.versionDesc;
    publishPath = [mosVersionJson.publishPath retain];
    isForce = [mosVersionJson.isForce retain];
    NSString *currentVersion = [self getCurrentVersion];
    int currentVersionInt = 0;
    int lastVersionInt =0;
    if (currentVersion!=nil) {
        currentVersionInt = [currentVersion intValue];
    }
    if (mosVersionJson.versionNum
        !=nil) {
        lastVersionInt = [mosVersionJson.versionNum intValue];
    }
    if (currentVersionInt<lastVersionInt) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"更新" message:versionDesc delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil] autorelease];
        [alert show];
    }
}

/**
 获得当前版本号
 **/
-(NSString*)getCurrentVersion{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return appVersion;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==100){
        if(buttonIndex==1)
        {
            EditPasswordViewController *g2V = [[EditPasswordViewController alloc] initWithNibName:@"EditPasswordViewController" bundle:nil];
            [self.navigationController pushViewController:g2V animated:YES];
            [g2V release];
        }
         NSString *sysUserId=[DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserId;
        [DataProcess addOrChangeConfig:@"Y" forKey:sysUserId];
    }else{
        if(buttonIndex==1)
        {
            NSString *path = publishPath;
            NSURL *url = [NSURL URLWithString:path];
            [[UIApplication sharedApplication]openURL:url];
        }else if([isForce isEqualToString:@"Y"]){
            exit(0); // 退出整个程序
        }
    }
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}


-(void)getResponse{
    NSString* url=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=getLateVersion4MOS"] autorelease];
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    NSMutableDictionary* requestQueryDirData = [[NSMutableDictionary alloc] init];
    
    [requestQueryDirData setObject:@"IOS" forKey:@"whichApp"];
    [aSIHTTPRequestUtils requestData:url data:requestQueryDirData action:@selector(getLastVersion:) isShowProcessBar:NO]; 
}


-(void)onCheckVersion:(NSString *)currentVersion
{ 
     NSString *URL = @"http://itunes.apple.com/lookup?id=741995308";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];

    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    [self getResponse];
    if ([StringUtils isExcetionInfo:results]||[results isEqual:[NSNull null]]||[results isEqualToString:@""]) { 
        return;
    }else{
        NSDictionary *dic = [DataProcess getNSDictionaryFromNSData:recervedData];
        NSArray *infoArray = [dic objectForKey:@"results"];
        if ([infoArray count]) {
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];

            if (![lastVersion isEqualToString:currentVersion]) {
                trackViewURL = [[releaseInfo objectForKey:@"trackViewUrl"] retain];
                UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"更新" message:versionDesc delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"更新", nil] autorelease];
                [alert show];
            }
        }

    }

   }
 







- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

//初始化缓存数据
-(void) getCacheDicInfo{
    ASIHTTPRequestUtils* tempASIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandleWithoutAutoRelease:self];
    
    NSString* tempSubUrl=[[[NSString alloc] initWithString:@"tz/TZDeviceAction.do?method=getCacheInfoAfterLogin"] autorelease];
    NSMutableDictionary* tempRequestData = [[NSMutableDictionary alloc] init];
    [tempRequestData setValue:@"any" forKey:@"any"];
    
    [tempASIHTTPRequestUtils requestData:tempSubUrl data:tempRequestData action:@selector(doAfterFetchTZDevieCache:) isShowProcessBar:YES];
    [tempASIHTTPRequestUtils  release];
}



-(void)doAfterFetchTZDevieCache:(NSData*)responseData{
    [DataProcess setDeviceTzDicInfo:responseData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(NSMutableArray*) getFuncTreeDic:(int) parentNodeTreeId{
      NSMutableArray* tempArray =[DataProcess getSysUserExtendedMVO].arrFuncNodeTree;
    NSMutableArray *data = [[NSMutableArray alloc]initWithCapacity : 2];
    
    for (int i=0; i<tempArray.count ;i++) {
        NSDictionary *treeDic=(NSDictionary*)tempArray[i];
        NSString* aparentNodeTreeId=[treeDic objectForKey:@"parentNodeTreeId"];
        NSString *nodeTreeName=[treeDic objectForKey:@"nodeTreeName"];

        if([aparentNodeTreeId isEqualToString:@"0"]){
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
            [dict setObject:nodeTreeName forKey:@"groupname"];
            
            NSMutableArray *arr1=[treeDic objectForKey:@"userFuncNodeList"];
            
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity : 2];
            for (int j=0; j<arr1.count; j++) {
                NSDictionary* d=(NSDictionary*)arr1[j];
                NSString *nodeName=[d objectForKey:@"funcNodeName"];
                [arr addObject:nodeName];    
            }
            [dict setObject:arr forKey:@"users"];
            [data addObject:dict];
            [dict release];
        }
    }
    return [data autorelease];
    
}






- (IBAction)forwar:(UIButton *)sender{
    if(sender.tag==1){
        dayReportViewController *vController = [[dayReportViewController alloc] initWithNibName:@"dayReportViewController" bundle:nil];
        [self.navigationController pushViewController:vController animated:YES];
        //vController.navigationItem.backBarButtonItem.title=@"返回";
    
        [vController release];

    }else if(sender.tag==2){
        HSYBViewController *viewController = [[HSYBViewController alloc] initWithNibName:@"HSYBViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if(sender.tag==3){
//        NSMutableArray* arr=[self getFuncTreeDic:1];
//        if(arr.count>0){
//            //根据权限判断走哪张报表，领导或网格经理
//            if([self forwardWhich]){
//                ReportTableViewController *viewController = [[ReportTableViewController alloc] initWithNibName:@"ReportTableViewController" bundle:nil];
//                viewController.whickReportFlag=@"zdgz";//重点关注日报通报和呼市日报之日通报共用一个报表，只是显示的地区不一样
//                [self.navigationController pushViewController:viewController animated:YES];
//                [viewController release];
//            }else{
//                JTRB4WGJLZDGZViewController *viewController = [[JTRB4WGJLZDGZViewController alloc] initWithNibName:@"JTRB4WGJLZDGZViewController" bundle:nil];
//                [self.navigationController pushViewController:viewController animated:YES];
//                [viewController release];
//            }
//            
//        }
        
        ZdgzReportListViewController *viewController = [[ZdgzReportListViewController alloc] initWithNibName:@"ZdgzReportListViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
        
        

       
    }else if(sender.tag==4){
        SSettingViewController *viewController = [[SSettingViewController alloc] initWithNibName:@"SSettingViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if(sender.tag==5){
        
        ProjectBuildViewController *viewController = [[ProjectBuildViewController alloc] initWithNibName:@"ProjectBuildViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    

    
}

- (IBAction)goNextView:(UIButton *)sender {
     

    
}

//扫描出结果后执行该段代码
-(void)imagePickerController:(UIImagePickerController *)reader
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
}
- (void)dealloc {
    [_imv_bg release];
    [super dealloc];
}
@end
