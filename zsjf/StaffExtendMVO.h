//
//  StaffExtendMVO.h
//  mos
//
//  Created by Mos on 13-3-27.
//  retainright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaffSVO.h"

@interface StaffExtendMVO : NSObject
/**
 * 当前登录员工信息
 */
@property (nonatomic, retain) StaffSVO* staffSVO;
/**
 * 当前登录员工参与人ID
 */
@property (nonatomic, retain) NSString* partyId;

/**
 * 当前登录员工参与人名称
 */
@property (nonatomic, retain) NSString* partyName;

/**
 * 当前登录员工参与人所属本地网
 */
@property (nonatomic, retain) NSString* localNetId;

/**
 * 当前登录员工参与人所属本地网名称
 */
@property (nonatomic, retain) NSString* localNetName;

/**
 * 当前登录员工参与人所属本地网是否为中心本地网
 */
@property (nonatomic, retain) NSString* localNetIscenter;

/**
 * 当前登录员工参与人所属服务区
 */
@property (nonatomic, retain) NSString* areaId;

/**
 * 当前登录员工参与人所属服务区名称
 */
@property (nonatomic, retain) NSString* areaName;

/**
 * 当前登录员工参与人所属服务区是否为中心服务区
 */
@property (nonatomic, retain) NSString* areaIscenter;

/**
 * 当前登录员工参与人所属营维中心
 */
@property (nonatomic, retain) NSString* servDeptId;

/**
 * 当前登录员工参与人所属营维中心名称
 */
@property (nonatomic, retain) NSString* servDeptName;

/**
 * 当前登录员工参与人所属支局
 */
@property (nonatomic, retain) NSString* branchId;

/**
 * 当前登录员工参与人所属支局名称
 */
@property (nonatomic, retain) NSString* branchName;

/**
 * 当前登录员工参与人状态
 */
@property (nonatomic, retain) NSString* partySts;

/**
 * 当前登录员工参与人类型
 */
@property (nonatomic, retain) NSString* partyType;

+(StaffExtendMVO*)initWithObject:(id)object;
@end
