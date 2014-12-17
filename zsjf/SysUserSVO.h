//
//  SysUserSVO.h
//  mos
//
//  Created by Mos on 13-3-27.
//  retainright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateUtils.h"

@interface SysUserSVO : NSObject
@property (nonatomic, retain) NSString* sysUserId;

@property (nonatomic, retain) NSString* partyRoleTypeId;

@property (nonatomic, retain) NSString* partyRoleId;

@property (nonatomic, retain) NSString* sysUserName;

@property (nonatomic, retain) NSString* password;

@property (nonatomic, retain) NSDate* setPwdTime;

@property (nonatomic, retain) NSDate* updatePwdTime;

@property (nonatomic, retain) NSString* lastPwd;

@property (nonatomic, retain) NSDate* createDate;

@property (nonatomic, retain) NSString* sts;

@property (nonatomic, retain) NSDate* stsDate;

@property (nonatomic, retain) NSString* localNetId;

+(SysUserSVO*)initWithObject:(id)object;
@end
