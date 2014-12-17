//
//  DataProcess.m
//  mos
//
//  Created by maxun on 13-3-18.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "DataProcess.h"
#import "StringUtils.h"

@implementation DataProcess

static BOOL firstDeal = YES;

//解析jsonData至NSArray
+(NSArray*)getArrayListFromNSData:(NSData*)jsonData{
    NSArray *jsonArray =[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    return jsonArray;
}

//解析jsonData至NSDictionary
+(NSDictionary*)getNSDictionaryFromNSData:(NSData*)jsonData{
    NSError *error;
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    return weatherDic;
}

//转换data至jsonString，通常data为dictionary或array
+(NSString*)parseToJsonString:(id)data{
    NSError *error = nil;
    if (data!=nil) {
        if ([data isKindOfClass:[NSMutableDictionary class]]) {
            data=(NSDictionary*)data;
            NSString *staffId=[DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserId;
            if (![StringUtils isBlankString:staffId]) {
                [data setObject:staffId forKey:@"staffId"];
            }
            
            [data setObject:@"I" forKey:@"loginType"];
        }
        NSData* jsonData =[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        
        //print out the data contents
        NSString *str = [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
        return str;
    }else{
        return @"";
    }

}

//修改或增加配置文件中的选项
//Modified By Zhangyu 2013-08-01 修改了真机测试中得沙盒问题
+(void)addOrChangeConfig:(id)content forKey:(NSString*)key{
    
    NSString *configPath = nil;
    NSMutableDictionary *config = nil;
    if (firstDeal) {
        configPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
        firstDeal = NO;
        NSString* sandBoxPath = [DataProcess getFilePathFromDocument:@"config.plist"];
        NSMutableDictionary* tempDic = [[NSMutableDictionary alloc] initWithContentsOfFile:configPath];
        [tempDic writeToFile:sandBoxPath atomically:YES];
    }else{
        configPath = [DataProcess getFilePathFromDocument:@"config.plist"];
        
    }
    NSMutableDictionary* tempDic = [[NSMutableDictionary alloc] initWithContentsOfFile:configPath];
    config = [tempDic mutableCopy];
    [tempDic release];
    [config setObject:content forKey:key];
    [config writeToFile:configPath atomically:YES];
    [config release];
}

//取出配置文件中的选项
//Modified By Zhangyu 2013-08-01 修改了真机测试中得沙盒问题
+(id)getConfig:(NSString*)key{
    NSString *configPath = nil;
    NSDictionary *config = nil;
    configPath = [DataProcess getFilePathFromDocument:@"config.plist"];
    config = [[[NSDictionary alloc] initWithContentsOfFile:configPath] autorelease];
    //解决了firstDeal对于程序终止后恢复默认值问题 Modified By Zhangyuc 2013-08-06
    if (config!=nil) {
        firstDeal = NO;
    }
    if (firstDeal) {
        configPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
        firstDeal = NO;
        NSString* sandBoxPath = [DataProcess getFilePathFromDocument:@"config.plist"];
        NSMutableDictionary* tempDic = [[NSMutableDictionary alloc] initWithContentsOfFile:configPath];
        [tempDic writeToFile:sandBoxPath atomically:YES];
        [tempDic release];
    }else{
        configPath = [DataProcess getFilePathFromDocument:@"config.plist"];

    }

    config = [[[NSDictionary alloc] initWithContentsOfFile:configPath] autorelease];
    id item = [config objectForKey:key];
    return item;
}

/*Added By Zhangyu 2013-08-01
 *Desc:获得真机中沙盒Document对应文件的完整路径
 */
+(NSString*)getFilePathFromDocument:(NSString*) fileName{
    NSArray *doc = NSSearchPathForDirectoriesInDomains(
                                                       
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [ doc objectAtIndex:0 ];
    
    return [docPath stringByAppendingPathComponent:fileName];
}


//取出缓存中的SysUserExtendedMVO
+(SysUserExtendedMVO*)getSysUserExtendedMVO{
    return ((AppDelegate*)[[UIApplication sharedApplication]delegate]).sysUserExtendedMVO;
}
//得到工单列表
+(NSMutableArray*)getWoList{
    return ((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList;
}

//得到领单列表
+(NSMutableArray*)getWoList4Fetch{
    return ((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList4Fetch;
}
//得到台账设备列表
+(NSMutableArray*)getDeviceList{
    return ((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceList;
}
//全新设置工单列表
+(void)setWoList:(NSArray*)newWoList{
    if (((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList == nil) {
        NSMutableArray* tempArray = [[NSMutableArray alloc] init];
        ((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList = tempArray;
        [tempArray release];
    }
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList removeAllObjects];
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList addObjectsFromArray:newWoList];
}

//全新设置台账设备列表
+(void)setDeviceList:(NSArray*)newWoList{
    if (((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceList == nil) {
        NSMutableArray* tempArray = [[NSMutableArray alloc] init];
        ((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceList = tempArray;
        [tempArray release];
    }
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceList removeAllObjects];
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceList addObjectsFromArray:newWoList];
}


//领单界面列表
+(void)setWoList4Fetch:(NSArray*)newWoList{
    if (((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList4Fetch == nil) {
        NSMutableArray* tempArray = [[NSMutableArray alloc] init];
        ((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList4Fetch = tempArray;
        [tempArray release];
    }
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList4Fetch removeAllObjects];
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList4Fetch addObjectsFromArray:newWoList];
    
}
//向工单列表中追加列表
+(void)appendListToWoList:(NSArray*)anotherWoList{
    if (((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList == nil) {
        NSMutableArray* tempArray = [[NSMutableArray alloc] init];
        ((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList = tempArray;
        [tempArray release];
    }
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList addObjectsFromArray:anotherWoList];
}

//向领单列表中追加列表
+(void)appendListToWoList4Fetch:(NSArray*)anotherWoList{
    if (((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList4Fetch == nil) {
        NSMutableArray* tempArray = [[NSMutableArray alloc] init];
        ((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList4Fetch = tempArray;
        [tempArray release];
    }
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]).woList4Fetch addObjectsFromArray:anotherWoList];
}
//向领单列表中追加列表
+(void)appendListToDeviceList:(NSArray*)anotherWoList{
    if (((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceList == nil) {
        NSMutableArray* tempArray = [[NSMutableArray alloc] init];
        ((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceList = tempArray;
        [tempArray release];
    }
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceList addObjectsFromArray:anotherWoList];
}
//得到工单总数
+(int)getCount{
    return [((AppDelegate*)[[UIApplication sharedApplication]delegate]).count intValue];
}

//得到领单总数
+(int)getCount4Fetch{
    return [((AppDelegate*)[[UIApplication sharedApplication]delegate]).count4Fetch intValue];
}

//设置工单总数
+(void)setCount:(int)newCount{
    ((AppDelegate*)[[UIApplication sharedApplication]delegate]).count = [NSNumber numberWithInt:newCount];
}

//设置领单总数
+(void)setCount4Fetch:(int)newCount{
    ((AppDelegate*)[[UIApplication sharedApplication]delegate]).count4Fetch = [NSNumber numberWithInt:newCount];
}

//得到是否加密
+(NSString*) IsEncrypt{ 
    return ((AppDelegate*)[[UIApplication sharedApplication]delegate]).isEncrypt ;
}

//设置设备台账系统用到的字典信息
+(void)setDeviceTzDicInfo:(NSData*)data{
    if (((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceTzDicInfo == nil) {
        NSData* tempData = [[NSData alloc] init];
        ((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceTzDicInfo = tempData;
        [tempData release];
    }
    //[((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceTzDicInfo removeAllObjects];
    ((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceTzDicInfo=data;
}

//获取设备台账系统用到的字典信息
+(NSData*)getDeviceTzDicInfo{
    return ((AppDelegate*)[[UIApplication sharedApplication]delegate]).deviceTzDicInfo;
}


@end
