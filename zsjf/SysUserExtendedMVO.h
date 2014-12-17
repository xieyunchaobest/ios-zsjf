//
//  SysUserExtendedMVO.h
//  mos
//
//  Created by Mos on 13-3-27.
//  retainright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SysUserSVO.h"
#import "StaffExtendMVO.h"
#import "WorkAreaMVO.h"
#import "FuncNodeTreeSVO.h"

@interface SysUserExtendedMVO : NSObject
/**
 * 当前用户的SysUserMVO
 */
@property (nonatomic, retain) SysUserSVO* sysUserSVO;

/**
 * 当前用户正访问的子系统
 */
@property (nonatomic, retain) NSString* userSubSystems;

/**
 * 当前用户对应的员工VO
 */
@property (nonatomic, retain) StaffExtendMVO* staffExtendMVO;

/**
 * 当前用户可访问的所有工区
 */
@property (nonatomic, retain) NSMutableArray* staffWorkAreas;

/**
 * 当前用户正访问的工区
 */
@property (nonatomic, retain) WorkAreaMVO* currentWorkAreaVO;

@property (nonatomic,retain) NSMutableArray* arrFuncNodeTree;

/**
 * 当前用户可访问的所有功能点
 */
@property (nonatomic, retain) NSMutableArray* funcNodeAll;

/**
 * 当前登录日志模式
 */
@property (nonatomic, assign) int loginMode;

/**
 * 当前用户失效
 */
@property (nonatomic, assign) int userValid;

/**
 * 初始登录
 */
@property (nonatomic, assign) int firstFlag;

/**
 * 密码失效
 */
@property (nonatomic, assign) int passwordValid;

/**
 * 密码距离失效天数
 */
@property (nonatomic, retain) NSString* passwordDay;

/**
 * 当前登录日志ID
 */
@property (nonatomic, retain) NSString* LoginId;

/**
 *
 * 功能树的集合（只是为了方便从后台把功能树相关数据取出供action使用，并不会把数据保存到页面上）
 */
@property (nonatomic, retain) NSMutableArray* funcNodeTreeVOs;

/**
 * 用户当前访问的功能点id
 */
@property (nonatomic, retain) NSString* curFuncNodeId;

/**
 * 用户当前访问的功能点名字
 *
 */
@property (nonatomic, retain) NSString* curFuncNodeName;
//用户能访问的系统权限
@property (nonatomic, retain) NSString* permissAppStr;

@property (nonatomic, retain) NSString* appInfoURLStr;

@property (nonatomic, retain) NSString* defaultApp;

+(SysUserExtendedMVO*)initWithObject:(id)object;
@end
