//
//  SSettingViewController.m
//  mos
//
//  Created by zhangyu on 13-8-16.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "SSettingViewController.h"
#import "SAboutUsViewController.h"
#import "EditPasswordViewController.h"
#import "ReportIntrouctionViewController.h"
#import "ReportIntrouctionDetailViewController.h"

@interface SSettingViewController ()

@end

@implementation SSettingViewController
@synthesize settingContent,settingSection;
@synthesize setCell;
@synthesize sLoginViewController;
@synthesize aSIHTTPRequestUtils;
@synthesize publishPath;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    NSArray *setting =  [[NSArray alloc] initWithObjects:
                         @"关于",@"修改密码",@"报表说明",@"注销",nil];
    settingContent = [[NSDictionary alloc] initWithObjectsAndKeys:setting,@"setting",nil];
    settingSection = [[settingContent allKeys] retain];
    [setting release];
    self.navigationController.navigationBar.translucent = NO;
    //设置下级页面的返回按钮
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
         [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
     }
    
    [temporaryBarButtonItem release];
    ASIHTTPRequestUtils* tempASIHTTPRequestUtils= [[ASIHTTPRequestUtils alloc] initWithHandleWithoutAutoRelease:self];
    self.aSIHTTPRequestUtils = tempASIHTTPRequestUtils;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [settingSection objectAtIndex:section];
    NSArray *content = [settingContent objectForKey:key];
    
    return [content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    NSString *keys = [settingSection objectAtIndex:section];
    NSArray *content = [settingContent objectForKey:keys];
     
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    static NSString *CellIdentifier = @"SettingInfoCell";
    UINib *nib = [UINib nibWithNibName:@"SettingInfoCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier]; 
    
    if([[content objectAtIndex:row] isEqual:@"关于"]||
       [[content objectAtIndex:row] isEqual:@"注销"]||
       [[content objectAtIndex:row] isEqual:@"报表说明"] ||
       [[content objectAtIndex:row] isEqual:@"修改密码"]){
        
        setCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
        setCell.textLabel.text = [content objectAtIndex:row];
        setCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return setCell;
    }else{
        return nil;
    }

}


//设置Section的Header
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *result = nil;
    if ([tableView isEqual:self.view]&&section==0) {
        result = @"";
    }
    return result;
}
//设置Section的Footer
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString *result = nil;
    if ([tableView isEqual:self.view]&& section==0) {
        result = @"";
    }
    return result;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    NSString *keys = [settingSection objectAtIndex:section];
    NSArray *content = [settingContent objectForKey:keys];
    
    if ([[content objectAtIndex:row] isEqual:@"注销"]){
        NSLog(@"goToAboutUs");
        ((AppDelegate*)[[UIApplication sharedApplication]delegate]).sysUserExtendedMVO = nil;
        SLoginViewController *loginViewController = nil;
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[SLoginViewController class]]) {
                
                loginViewController = (SLoginViewController*)controller;
                
                //清除密码项和缓存中的密码项
                loginViewController.passwordTextField.text = nil;
                //                loginViewController->password = nil;
                //为NO会重新读取文本信息
                loginViewController.isCiphertext = NO;
                loginViewController.rememberPwd = NO;
                loginViewController.autoLogin = NO;
                [DataProcess addOrChangeConfig:[NSNumber numberWithBool:NO] forKey:@"rememberPwd"];
                [DataProcess addOrChangeConfig:[NSNumber numberWithBool:NO] forKey:@"autoLogin"];
                [DataProcess addOrChangeConfig:[NSNumber numberWithBool:NO] forKey:@"autoLogin"];
                
                //清除领单、工单列表的数据 
                [DataProcess setDeviceTzDicInfo:nil];
                [self.navigationController popToViewController:loginViewController animated:YES];
            }
        }
        
    }else if ([[content objectAtIndex:row] isEqual:@"关于"]){
        NSLog(@"returnLogin");
        SAboutUsViewController *g2V = [[SAboutUsViewController alloc] initWithNibName:@"SAboutUsViewController" bundle:nil];
        [self.navigationController pushViewController:g2V animated:YES];
        [g2V release];
        
    }else if ([[content objectAtIndex:row] isEqual:@"报表说明"]){
        ReportIntrouctionDetailViewController *g2V = [[ReportIntrouctionDetailViewController alloc] initWithNibName:@"ReportIntrouctionDetailViewController" bundle:nil];
        [self.navigationController pushViewController:g2V animated:YES];
        [g2V release];
        
    }else if ([[content objectAtIndex:row] isEqual:@"修改密码"])
    {
        EditPasswordViewController *g2V = [[EditPasswordViewController alloc] initWithNibName:@"EditPasswordViewController" bundle:nil];
        [self.navigationController pushViewController:g2V animated:YES];
        [g2V release];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"更新"]) {
        if(buttonIndex==1)
        {
            NSString *path = publishPath;
            NSURL *url = [NSURL URLWithString:path];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
    if ([alertView.title isEqualToString:@"设置接入点"]) {
        if(buttonIndex==1)
        {
            UITextField *serverName=[alertView textFieldAtIndex:0];//获得弹出框上的输入框
            if ([StringUtils isBlankString:serverName.text]) {
                [Prompt makeText:@"接入点不能为空！" target:self];
                return;
            }
            [DataProcess addOrChangeConfig:serverName.text forKey:@"serverURL"];
            serverNameStr = [serverName.text retain];
            [aSIHTTPRequestUtils requestIsConnectedData:@"loginAction.do?method=isConnected4MOS" data:nil action:@selector(doAfterNextAction:) isShowProcessBar:YES];
        }
    }
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)doAfterNextAction:(id)data{
    NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([resultStr isEqualToString:@"success"]) {
        
        [DataProcess addOrChangeConfig:serverNameStr forKey:@"serverURL"];
        
        SLoginViewController *g2V = [[SLoginViewController alloc] initWithNibName:@"SLoginViewController" bundle:nil];
        self.sLoginViewController = g2V;
        [self.navigationController pushViewController:self.sLoginViewController animated:YES];
        
        [serverNameStr release];
        [g2V release];
        [Prompt makeText:@"修改成功！" target:self.navigationController];
    }else{
        [DataProcess addOrChangeConfig:@"" forKey:@"serverURL"];
        [Prompt makeText:@"接入点输入错误或网络异常！" target:self];
    }
    [resultStr release];
}

-(void)dealloc{
    [aSIHTTPRequestUtils release];
    [settingContent release];
    [settingSection release];
    [setCell release];
    [sLoginViewController release];
    [super dealloc];
}
-(void)viewDidUnload{
    [self setASIHTTPRequestUtils:nil];
    [self setSettingContent:nil];
    [self setSettingSection:nil];
    [self setSetCell:nil];
    [self setSLoginViewController:nil];
    [super viewDidUnload];
}

@end
