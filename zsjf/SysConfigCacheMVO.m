//
//  SysConfigCacheMVO.m
//  mos
//
//  Created by xuewei on 13-7-12.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "SysConfigCacheMVO.h"

@implementation SysConfigCacheMVO

+(SysConfigCacheMVO*)initWithObject:(id)object{
    SysConfigCacheMVO* sysConfigCacheMVO = [[[SysConfigCacheMVO alloc] init] autorelease];
    NSDictionary* sysConfigCacheMVODic = (NSDictionary*)object;
    
    sysConfigCacheMVO.functionVisiable = [sysConfigCacheMVODic objectForKey:@"functionVisiable"];
    return sysConfigCacheMVO;
}

-(void)dealloc{
    
    [super dealloc];
}
@end
