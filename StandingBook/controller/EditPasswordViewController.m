//
//  EditPasswordViewController.m
//  zsjf
//
//  Created by xieyunchao on 13-12-21.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "EditPasswordViewController.h"
#import "StringUtils.h"
#import "Prompt.h"
#import "SSettingViewController.h"

@interface EditPasswordViewController ()

@end

@implementation EditPasswordViewController
@synthesize aSIHTTPRequestUtils;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"修改密码";
    }
    return self;
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)modifyPassword:(id)sender {
    NSString* oldPwd=self.oldPwd.text;
    NSString* newPwd=self.newPwd.text;
    NSString* newPwdConfirm=self.newPwdConfirm.text;
    if ([StringUtils isBlankString:oldPwd]){
        [Prompt makeText:@"原密码不能为空！" target:self];
        return ;
    }else if([StringUtils isBlankString:newPwd]){
        [Prompt makeText:@"新密码不能为空！" target:self];
        return ;
    }else if([StringUtils isBlankString:newPwdConfirm]){
        [Prompt makeText:@"密码确认不能为空！" target:self];
        return;
    }else if(![newPwd isEqualToString:newPwdConfirm]){
        [Prompt makeText:@"两次密码输入不一致！" target:self];
        return ;
    }
    
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=modifyPwd"] autorelease];
    NSMutableDictionary *reqdic=[[NSMutableDictionary alloc] init];
    [reqdic setObject:oldPwd forKey:@"oldPwd"];
    [reqdic setObject:newPwd forKey:@"newPwd"];
    [reqdic setObject:newPwdConfirm forKey:@"newPwdConfirm"];
    [reqdic setObject:[DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserId forKey:@"staffId"];
    
    [aSIHTTPRequestUtils requestData:subUrl data:reqdic action:@selector(doAfterModifyPwd:) isShowProcessBar:YES];
    
    [reqdic release];
}


-(void) doAfterModifyPwd:(NSData*)responseData {
    if (responseData!=nil) {
        NSDictionary* respDic = [DataProcess getNSDictionaryFromNSData:responseData];
        NSString *flag=[respDic objectForKey:@"flag"];
        if([@"1" isEqualToString:flag]){
            [Prompt makeText:@"密码修改成功！" target:self];
//            SSettingViewController *g2V = [[SSettingViewController alloc] initWithNibName:@"SSettingViewController" bundle:nil];
//            
//            
//            [self.navigationController pushViewController:g2V animated:YES];
//            //[self.view removeFromSuperview];
//            [g2V release];
            [self performSelector:@selector(myPopView) withObject:[NSNumber numberWithBool:YES] afterDelay:1.0f];
        }else{
            [Prompt makeText:@"密码修改失败，请联系维护人员！" target:self];
        }
    }
}


-(void)myPopView
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_oldPwd release];
    [_newPwd release];
    [_newPwdConfirm release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setOldPwd:nil];
    [self setNewPwd:nil];
    [self setNewPwdConfirm:nil];
    [super viewDidUnload];
}
@end
