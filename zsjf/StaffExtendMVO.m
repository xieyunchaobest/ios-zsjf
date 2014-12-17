//
//  StaffExtendMVO.m
//  mos
//
//  Created by Mos on 13-3-27.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "StaffExtendMVO.h"

@implementation StaffExtendMVO

@synthesize staffSVO;
@synthesize partyId;
@synthesize partyName;
@synthesize localNetId;
@synthesize localNetName;
@synthesize localNetIscenter;
@synthesize areaId;
@synthesize areaName;
@synthesize areaIscenter;
@synthesize servDeptId;
@synthesize servDeptName;
@synthesize branchId;
@synthesize branchName;
@synthesize partySts;
@synthesize partyType;

+(StaffExtendMVO*)initWithObject:(id)object{
    StaffExtendMVO* staffExtendMVO = [[[StaffExtendMVO alloc] init] autorelease];
    NSDictionary* staffExtendMVODic = (NSDictionary*)object;
    staffExtendMVO.staffSVO = [StaffSVO initWithObject:[staffExtendMVODic objectForKey:@"staffSVO"]];
    staffExtendMVO.partyId = [staffExtendMVODic objectForKey:@"partyId"];
    staffExtendMVO.partyName = [staffExtendMVODic objectForKey:@"partyName"];
    staffExtendMVO.partySts = [staffExtendMVODic objectForKey:@"partySts"];
    staffExtendMVO.partyType = [staffExtendMVODic objectForKey:@"partyType"];
    staffExtendMVO.localNetId = [staffExtendMVODic objectForKey:@"localNetId"];
    staffExtendMVO.localNetName = [staffExtendMVODic objectForKey:@"localNetName"];
    staffExtendMVO.localNetIscenter = [staffExtendMVODic objectForKey:@"localNetIscenter"];
    staffExtendMVO.areaId = [staffExtendMVODic objectForKey:@"areaId"];
    staffExtendMVO.areaName = [staffExtendMVODic objectForKey:@"areaName"];
    staffExtendMVO.areaIscenter = [staffExtendMVODic objectForKey:@"areaIscenter"];
    staffExtendMVO.servDeptId = [staffExtendMVODic objectForKey:@"servDeptId"];
    staffExtendMVO.servDeptName = [staffExtendMVODic objectForKey:@"servDeptName"];
    staffExtendMVO.branchId = [staffExtendMVODic objectForKey:@"branchId"];
    staffExtendMVO.branchName = [staffExtendMVODic objectForKey:@"branchName"];
    return staffExtendMVO;
}

-(void)dealloc{
    [staffSVO release];
    [partyId release];
    [partyName release];
    [localNetId release];
    [localNetName release];
    [localNetIscenter release];
    [areaId release];
    [areaName release];
    [areaIscenter release];
    [servDeptId release];
    [servDeptName release];
    [branchId release];
    [branchName release];
    [partySts release];
    [partyType release];
    [super dealloc];
}
@end
