//
//  GuideMainViewController.h
//  mos
//
//  Created by xieyunchao on 13-1-27.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequestUtils.h"

@interface GuideMainViewController : UIViewController<UIScrollViewDelegate>
{

    int pageWidth;
    UIScrollView * myScrollView;
    
    UIImageView * imageView1;
    UIImageView * imageView2;
    UIImageView * imageView3;
    UIImageView * imageView4;
    
    UIImage * imageGoIn;
    UIImage *imageGoInPress;
    UIButton *gonInButton;
    
    int currentImageCount;
    int curentImage;
    
    UITapGestureRecognizer * tap;
    UIPageControl * myPageControl;
    CGFloat screenHeight;
    

}
@property (retain,nonatomic) ASIHTTPRequestUtils *aSIHTTPRequestUtils;

@property(nonatomic,retain)LoginViewController *loginViewController;

@end
