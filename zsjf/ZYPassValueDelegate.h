//
//  ZYPassValueByDelegate.h
//  mos
//
//  Created by zhangyuc on 13-4-16.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZYPassValueDelegate <NSObject>

@optional
-(void)passValue:(NSMutableDictionary*)passData;
-(void)addPassValue:(NSMutableDictionary*)passData;
-(void)deletePassValue:(NSMutableDictionary*)passData;
-(void)deleteValues;
@end
