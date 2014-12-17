//
//  SysUserExtendedMVO.m
//  mos
//
//  Created by Mos on 13-3-27.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "SysUserExtendedMVO.h"

@implementation SysUserExtendedMVO
@synthesize sysUserSVO;
@synthesize userSubSystems;
@synthesize staffExtendMVO;
@synthesize staffWorkAreas;
@synthesize currentWorkAreaVO;
@synthesize funcNodeAll;
@synthesize loginMode;
@synthesize userValid;
@synthesize firstFlag;
@synthesize passwordValid;
@synthesize passwordDay;
@synthesize LoginId;
@synthesize funcNodeTreeVOs;
@synthesize curFuncNodeId;
@synthesize curFuncNodeName;
@synthesize permissAppStr;
@synthesize appInfoURLStr;
@synthesize defaultApp;

+(SysUserExtendedMVO*)initWithObject:(id)object{
    SysUserExtendedMVO* sysUserExtendedMVO = [[[SysUserExtendedMVO alloc] init] autorelease];
    NSDictionary* sysUserExtendedMVODic = (NSDictionary*)object;
    sysUserExtendedMVO.sysUserSVO = [SysUserSVO initWithObject:[sysUserExtendedMVODic objectForKey:@"sysUserSVO"]];
    sysUserExtendedMVO.arrFuncNodeTree=[sysUserExtendedMVODic objectForKey:@"sysUserFuncTree"];
  
    
//    sysUserExtendedMVO.staffExtendMVO = [StaffExtendMVO initWithObject:[sysUserExtendedMVODic objectForKey:@"staffExtendMVO"]];
//    sysUserExtendedMVO.currentWorkAreaVO = [WorkAreaMVO initWithObject:[sysUserExtendedMVODic objectForKey:@"currentWorkAreaVO"]];
    return sysUserExtendedMVO;
}

-(void)dealloc{
    [sysUserSVO release];
    [userSubSystems release];
    [staffExtendMVO release];
    [staffWorkAreas release];
    [currentWorkAreaVO release];
    [funcNodeAll release];
    loginMode = 0;
    userValid =0;
    firstFlag =0;
    passwordValid =0;
    [passwordDay release];
    [LoginId release];
    [funcNodeTreeVOs release];
    [curFuncNodeId release];
    [curFuncNodeName release];
    [permissAppStr release];
    [appInfoURLStr release];
    [defaultApp release];
    [super dealloc];
}
@end
