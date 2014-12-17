//
//  WorkAreaMVO.m
//  mos
//
//  Created by Mos on 13-3-27.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "WorkAreaMVO.h"

@implementation WorkAreaMVO
@synthesize workTypeName;
@synthesize workType;
@synthesize workAreaId;
@synthesize coMeth;
@synthesize name;
@synthesize workTypeId;
@synthesize localNetId;
@synthesize workMode;

/**
 * 当前登录员工参与人所属本地网名称
 */
@synthesize localNetName;

/**
 * 当前登陆员工参与人所属本地网是否为中心本地网
 */

@synthesize localNetIscenter;
@synthesize areaId;

/**
 * 当前登录员工参与人所属服务区名称
 */
@synthesize areaName;

/**
 * 当前登录员工参与人所属服务区是否为中心服务区
 */
@synthesize areaIscenter;
@synthesize servDeptId;

/**
 * 当前登录员工参与人所属营维中心名称
 */
@synthesize servDeptName;
@synthesize branchId;

/**
 * 当前登录员工参与人所属支局名称
 */
@synthesize branchName;
@synthesize dispatchLevel;
@synthesize parentWorkAreaId;
@synthesize parentWorkAreaName;
@synthesize standardCode;
@synthesize sts;
@synthesize stsDate;
@synthesize createDate;
@synthesize adminFlag;

+(WorkAreaMVO*)initWithObject:(id)object{
    WorkAreaMVO* workAreaMVO = [[[WorkAreaMVO alloc] init] autorelease];
    NSDictionary* workAreaMVODic = (NSDictionary*)object;
    workAreaMVO.workAreaId = [workAreaMVODic objectForKey:@"workAreaId"];
    workAreaMVO.name = [workAreaMVODic objectForKey:@"name"];
    workAreaMVO.workTypeId = [workAreaMVODic objectForKey:@"workTypeId"];
    workAreaMVO.workTypeName = [workAreaMVODic objectForKey:@"workTypeName"];
    workAreaMVO.workMode = [workAreaMVODic objectForKey:@"workMode"];
    workAreaMVO.localNetId = [workAreaMVODic objectForKey:@"localNetId"];
    workAreaMVO.localNetName = [workAreaMVODic objectForKey:@"localNetName"];
    workAreaMVO.localNetIscenter = [workAreaMVODic objectForKey:@"localNetIscenter"];
    workAreaMVO.areaId = [workAreaMVODic objectForKey:@"areaId"];
    workAreaMVO.areaName = [workAreaMVODic objectForKey:@"areaName"];
    workAreaMVO.areaIscenter = [workAreaMVODic objectForKey:@"areaIscenter"];
    workAreaMVO.servDeptId = [workAreaMVODic objectForKey:@"servDeptId"];
    workAreaMVO.servDeptName = [workAreaMVODic objectForKey:@"servDeptName"];
    workAreaMVO.branchId = [workAreaMVODic objectForKey:@"branchId"];
    workAreaMVO.branchName = [workAreaMVODic objectForKey:@"branchName"];
    workAreaMVO.dispatchLevel = [workAreaMVODic objectForKey:@"dispatchLevel"];
    workAreaMVO.parentWorkAreaId = [workAreaMVODic objectForKey:@"parentWorkAreaId"];
    workAreaMVO.standardCode = [workAreaMVODic objectForKey:@"standardCode"];
    workAreaMVO.sts = [workAreaMVODic objectForKey:@"sts"];
    workAreaMVO.stsDate = [DateUtils getDate:[workAreaMVODic objectForKey:@"stsDate"]];
    workAreaMVO.workType = [workAreaMVODic objectForKey:@"workType"];
    workAreaMVO.adminFlag = [workAreaMVODic objectForKey:@"adminFlag"];
    return workAreaMVO;
}

-(void)dealloc{
    [workTypeName release];
    [workType release];
    [workAreaId release];
    [coMeth release];
    [name release];
    [workTypeId release];
    [localNetId release];
    [workMode release];
    [localNetName release];
    [localNetIscenter release];
    [areaId release];
    [areaName release];
    [areaIscenter release];
    [servDeptId release];
    [servDeptName release];
    [branchId release];
    [branchName release];
    [dispatchLevel release];
    [parentWorkAreaId release];
    [parentWorkAreaName release];
    [standardCode release];
    [sts release];
    [stsDate release];
    [createDate release];
    [adminFlag release];
    [super dealloc];
}
@end
