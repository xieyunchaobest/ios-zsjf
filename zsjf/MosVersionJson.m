//
//  MosVersionJson.m
//  mos
//
//  Created by xuewei on 13-7-22.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "MosVersionJson.h"

@implementation MosVersionJson
@synthesize isForce;
@synthesize publishPath;
@synthesize remarks;
@synthesize versionDesc;
@synthesize versionId;
@synthesize versionNum;

+(MosVersionJson*)initWithObject:(id)object{
    MosVersionJson* mosVersionJson = [[[MosVersionJson alloc] init] autorelease];
    NSDictionary* mosVersionMVODic = (NSDictionary*)object;
    mosVersionJson.isForce = [mosVersionMVODic objectForKey:@"isForce"];
    mosVersionJson.publishPath = [mosVersionMVODic objectForKey:@"publishPath"];
    mosVersionJson.remarks = [mosVersionMVODic objectForKey:@"remarks"];
    mosVersionJson.versionDesc = [mosVersionMVODic objectForKey:@"versionDesc"];
    mosVersionJson.versionId = [mosVersionMVODic objectForKey:@"versionId"];
    mosVersionJson.versionNum = [mosVersionMVODic objectForKey:@"versionNum"];
    return mosVersionJson;
}

-(void)dealloc{
    [isForce release];
    [publishPath release];
    [remarks release];
    [versionDesc release];
    [versionId release];
    [versionNum release];
    
    [super dealloc];
}

@end
