//
//  DataProcess.h
//  mos
//
//  Created by maxun on 13-3-18.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SysUserExtendedMVO.h"
#import "AppDelegate.h"

//综合数据处理类
@interface DataProcess : NSObject

//解析JSONArray
+(NSArray*)getArrayListFromNSData:(NSData*)jsonData;
//解析JSONObject
+(NSDictionary*)getNSDictionaryFromNSData:(NSData*)jsonData;
//转换data至jsonString，通常data为dictionary或array
+(NSString*)parseToJsonString:(id)data;
//修改或增加配置文件中的选项
+(void)addOrChangeConfig:(id)content forKey:(NSString*)key;
//取出配置文件中的选项
+(id)getConfig:(NSString*)key;
//获取SysUserExtendedMVO
+(SysUserExtendedMVO*)getSysUserExtendedMVO;
//得到工单列表
+(NSMutableArray*)getWoList;
//获得领单列表
+(NSMutableArray*)getWoList4Fetch;
//全新设置工单列表
+(void)setWoList:(NSArray*)newWoList;

//领单界面列表
+(void)setWoList4Fetch:(NSArray*)newWoList;

//向工单列表中追加列表
+(void)appendListToWoList:(NSArray*)anotherWoList;

//向领单列表中追加列表
+(void)appendListToWoList4Fetch:(NSArray*)anotherWoList;
//得到工单总数
+(int)getCount;
//设置工单总数
+(void)setCount:(int)newCount;
//得到是否加密
+(NSString*) IsEncrypt;
//得到领单总数
+(int)getCount4Fetch;
//设置领单总数
+(void)setCount4Fetch:(int)newCount;
/*Added By Zhangyu 2013-08-01
 *Desc:获得真机中沙盒Document对应文件的完整路径
 */
+(NSString*)getFilePathFromDocument:(NSString*) fileName;
//获得台账设备列表
+(NSMutableArray*)getDeviceList;
//全新设置台账设备列表
+(void)setDeviceList:(NSArray*)newWoList;
//向领单列表中追加列表
+(void)appendListToDeviceList:(NSArray*)anotherWoList;

//设置设备台账系统用到的字典信息
+(void)setDeviceTzDicInfo:(NSData*)data;
//获取设备台账系统用到的字典信息
+(NSData*)getDeviceTzDicInfo;
@end
