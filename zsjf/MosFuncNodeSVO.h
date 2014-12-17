//
//  MosFuncNodeSVO.h
//  mos
//
//  Created by zhangyu on 13-10-12.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//  用于记录Mos权限控制的工具类

#import <Foundation/Foundation.h>

@interface MosFuncNodeSVO : NSObject

@property(copy,nonatomic) NSString* funccLevel;//是标示提示功能不可用还是不可见效果
@property(copy,nonatomic) NSString* shortName;//模块标识
@property(copy,nonatomic) NSString* type;//为主页还是工单详情

@end
