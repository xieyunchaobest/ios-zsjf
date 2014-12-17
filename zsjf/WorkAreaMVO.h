//
//  WorkAreaMVO.h
//  mos
//
//  Created by Mos on 13-3-27.
//  retainright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateUtils.h"

@interface WorkAreaMVO : NSObject
@property (nonatomic, retain) NSString* workTypeName;
@property (nonatomic, retain) NSString* workType;
@property (nonatomic, retain) NSString* workAreaId;
@property (nonatomic, retain) NSString* coMeth;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* workTypeId;
@property (nonatomic, retain) NSString* localNetId;
@property (nonatomic, retain) NSString* workMode;

/**
 * 当前登录员工参与人所属本地网名称
 */
@property (nonatomic, retain) NSString* localNetName;

/**
 * 当前登陆员工参与人所属本地网是否为中心本地网
 */

@property (nonatomic, retain) NSString* localNetIscenter;
@property (nonatomic, retain) NSString* areaId;

/**
 * 当前登录员工参与人所属服务区名称
 */
@property (nonatomic, retain) NSString* areaName;

/**
 * 当前登录员工参与人所属服务区是否为中心服务区
 */
@property (nonatomic, retain) NSString* areaIscenter;
@property (nonatomic, retain) NSString* servDeptId;

/**
 * 当前登录员工参与人所属营维中心名称
 */
@property (nonatomic, retain) NSString* servDeptName;


// 社区与网格的维护关系
@property (nonatomic, retain) NSString* workAreaObjId;
@property (nonatomic, retain) NSString* servDeptSts;
@property (nonatomic, retain) NSString* workAreaObjSts;
@property (nonatomic, retain) NSString* branchId;

/**
 * 当前登录员工参与人所属支局名称
 */
@property (nonatomic, retain) NSString* branchName;
@property (nonatomic, retain) NSString* dispatchLevel;
@property (nonatomic, retain) NSString* parentWorkAreaId;
@property (nonatomic, retain) NSString* parentWorkAreaName;
@property (nonatomic, retain) NSString* standardCode;
@property (nonatomic, retain) NSString* sts;
@property (nonatomic, retain) NSDate* stsDate;
@property (nonatomic, retain) NSDate* createDate;
@property (nonatomic, retain) NSString* channelId;
@property (nonatomic, retain) NSString* channelName;
@property (nonatomic, retain) NSString* adminFlag;

+(WorkAreaMVO*)initWithObject:(id)object;
@end
