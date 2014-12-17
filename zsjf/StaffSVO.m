//
//  StaffSVO.m
//  mos
//
//  Created by Mos on 13-3-27.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "StaffSVO.h"

@implementation StaffSVO
@synthesize staffId;
@synthesize deptId;
@synthesize position;
@synthesize standardCode;
@synthesize sts;
@synthesize stsDate;
@synthesize createDate;
@synthesize partyId;
@synthesize simSysUserName;
@synthesize simPassword;
@synthesize deptType;
@synthesize companyCode;
@synthesize telNbr;
@synthesize localNetId;

+(StaffSVO*)initWithObject:(id)object{
    StaffSVO* staffSVO = [[[StaffSVO alloc] init] autorelease];
    NSDictionary* staffSVODic = (NSDictionary*)object;
    staffSVO.createDate = [DateUtils getDate:[staffSVODic objectForKey:@"createDate"]];
    staffSVO.deptId = [staffSVODic objectForKey:@"deptId"];
    staffSVO.partyId = [staffSVODic objectForKey:@"partyId"];
    staffSVO.position = [staffSVODic objectForKey:@"position"];
    staffSVO.staffId = [staffSVODic objectForKey:@"staffId"];
    staffSVO.standardCode = [staffSVODic objectForKey:@"standardCode"];
    staffSVO.sts = [staffSVODic objectForKey:@"sts"];
    staffSVO.stsDate = [DateUtils getDate:[staffSVODic objectForKey:@"stsDate"] ];
    staffSVO.companyCode = [staffSVODic objectForKey:@"companyCode"];
    staffSVO.deptType = [staffSVODic objectForKey:@"deptType"];
    staffSVO.telNbr = [staffSVODic objectForKey:@"telNbr"];
    return staffSVO;
}

-(void)dealloc{
    [staffId release];
    [deptId release];
    [position release];
    [standardCode release];
    [sts release];
    [stsDate release];
    [createDate release];
    [partyId release];
    [simSysUserName release];
    [simPassword release];
    [deptType release];
    [companyCode release];
    [telNbr release];
    [localNetId release];
    [super dealloc];
}
@end
