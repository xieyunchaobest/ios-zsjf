//
//  Prompt.m
//  mos
//
//  Created by Mos on 13-3-26.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "Prompt.h"

@implementation Prompt
//弹出提示信息（文字）
+(void)makeText:(NSString*)text target:(id)target{
    UIViewController* viewController = (UIViewController*)target;
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:viewController.view];
    [viewController.view addSubview:HUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    HUD.yOffset = 150.0f;
    HUD.margin = 8.0f;
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [HUD removeFromSuperview];
        [HUD release];
    }];
}
@end
