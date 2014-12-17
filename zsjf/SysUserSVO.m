//
//  SysUserSVO.m
//  mos
//
//  Created by Mos on 13-3-27.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "SysUserSVO.h"

@implementation SysUserSVO
@synthesize sysUserId;

@synthesize partyRoleTypeId;

@synthesize partyRoleId;

@synthesize sysUserName;

@synthesize password;

@synthesize setPwdTime;

@synthesize updatePwdTime;

@synthesize lastPwd;

@synthesize createDate;

@synthesize sts;

@synthesize stsDate;

@synthesize localNetId;

+(SysUserSVO*)initWithObject:(id)object{
    SysUserSVO* sysUserSVO = [[[SysUserSVO alloc] init] autorelease];
    NSDictionary* sysUserSVODic = (NSDictionary*)object;
    sysUserSVO.sysUserId = [sysUserSVODic objectForKey:@"sysUserId"];
    sysUserSVO.partyRoleTypeId = [sysUserSVODic objectForKey:@"partyRoleTypeId"];
    sysUserSVO.partyRoleId = [sysUserSVODic objectForKey:@"partyRoleId"];
    sysUserSVO.sysUserName = [sysUserSVODic objectForKey:@"sysUserName"];
    sysUserSVO.password = [sysUserSVODic objectForKey:@"password"];
    //sysUserSVO.setPwdTime = [DateUtils getDate:[sysUserSVODic objectForKey:@"setPwdTime"]];
   // sysUserSVO.updatePwdTime = [DateUtils getDate:[sysUserSVODic objectForKey:@"updatePwdTime"]];
    sysUserSVO.lastPwd = [sysUserSVODic objectForKey:@"lastPwd"];
    //sysUserSVO.createDate = [DateUtils getDate:[sysUserSVODic objectForKey:@"createDate"]];
    sysUserSVO.sts = [sysUserSVODic objectForKey:@"sts"];
    //sysUserSVO.stsDate = [DateUtils getDate:[sysUserSVODic objectForKey:@"stsDate"]];
    sysUserSVO.localNetId = [sysUserSVODic objectForKey:@"localNetId"];
    return sysUserSVO;
}

-(void)dealloc{
    [sysUserId release];
    [partyRoleTypeId release];
    [partyRoleId release];
    [sysUserName release];
    [password release];
    [setPwdTime release];
    [updatePwdTime release];
    [lastPwd release];
    [createDate release];
    [sts release];
    [stsDate release];
    [localNetId release];
    [super dealloc];
}
@end
