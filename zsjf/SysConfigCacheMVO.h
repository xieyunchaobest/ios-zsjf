//
//  SysConfigCacheMVO.h
//  mos
//  存储工单列表业务筛选列表
//  Created by xuewei on 13-7-12.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SysConfigCacheMVO : NSObject

@property (nonatomic,retain) NSString *functionVisiable;
+(SysConfigCacheMVO*)initWithObject:(id)object;

@end
