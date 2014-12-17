//
//  Prompt.h
//  mos
//
//  Created by Mos on 13-3-26.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface Prompt : NSObject
//弹出提示信息（文字）
+(void)makeText:(NSString*)text target:(id)target;
@end
