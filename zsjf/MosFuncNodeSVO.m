//
//  MosFuncNodeSVO.m
//  mos
//
//  Created by zhangyu on 13-10-12.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "MosFuncNodeSVO.h"

@implementation MosFuncNodeSVO

@synthesize funccLevel;
@synthesize shortName;
@synthesize type;


+(MosFuncNodeSVO*)initWithObject:(id)object{
    MosFuncNodeSVO* mosFuncNodeSVO = [[[MosFuncNodeSVO alloc] init] autorelease];
    NSDictionary* mosFuncNodeSVODic = (NSDictionary*)object;
    
    mosFuncNodeSVO.funccLevel = [mosFuncNodeSVODic objectForKey:@"funccLevel"];
    mosFuncNodeSVO.shortName = [mosFuncNodeSVODic objectForKey:@"shortName"];
    mosFuncNodeSVO.type = [mosFuncNodeSVODic objectForKey:@"type"];
    
    return mosFuncNodeSVO;
}

-(void)dealloc{
    [funccLevel release];
    [shortName release];
    [type release];
    [super dealloc];
}

@end
