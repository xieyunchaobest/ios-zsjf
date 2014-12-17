//
//  MosVersionJson.h
//  mos
//  数据库中存放的版本信息
//  Created by xuewei on 13-7-22.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MosVersionJson : NSObject

@property (nonatomic,retain) NSString *isForce;
@property (nonatomic,retain) NSString *publishPath;
@property (nonatomic,retain) NSString *remarks;
@property (nonatomic,retain) NSString *versionDesc;
@property (nonatomic,retain) NSString *versionId;
@property (nonatomic,retain) NSString *versionNum;

+(MosVersionJson*)initWithObject:(id)object;

@end
