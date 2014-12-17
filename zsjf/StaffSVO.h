//
//  StaffSVO.h
//  mos
//
//  Created by Mos on 13-3-27.
//  retainright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateUtils.h"

@interface StaffSVO : NSObject
@property (nonatomic, retain) NSString* staffId;
@property (nonatomic, retain) NSString* deptId;
@property (nonatomic, retain) NSString* position;
@property (nonatomic, retain) NSString* standardCode;
@property (nonatomic, retain) NSString* sts;
@property (nonatomic, retain) NSDate* stsDate;
@property (nonatomic, retain) NSDate* createDate;
@property (nonatomic, retain) NSString* partyId;
@property (nonatomic, retain) NSString* simSysUserName;
@property (nonatomic, retain) NSString* simPassword;
@property (nonatomic, retain) NSString* deptType;
@property (nonatomic, retain) NSString* companyCode;
@property (nonatomic, retain) NSString* telNbr;
@property (nonatomic, retain) NSString* localNetId;

+(StaffSVO*)initWithObject:(id)object;
@end
