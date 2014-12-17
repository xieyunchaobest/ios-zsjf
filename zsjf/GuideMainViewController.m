//
//  GuideMainViewController.m
//  mos
//
//  Created by xieyunchao on 13-1-27.
//  Copyright (c) 2013年 xieyunchao. All rights reserved.
//

#import "GuideMainViewController.h"

@interface GuideMainViewController ()

@end

@implementation GuideMainViewController
@synthesize chooseServerViewController;
@synthesize aSIHTTPRequestUtils;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    screenHeight=size.height;
    
    
     //隐藏导航栏 added by zhangyuc
    [self.navigationController setNavigationBarHidden:YES];
    
    /*
     * 1.为了知道当前所指向图片，程序设置为三页面pageWidth*4，而默认为第0页（0，1，2,3）
     * 2.为了%3所以为，3331（几个333自己控制）
     */

    curentImage = 0;
    
    pageWidth = 320;
    //----------------------------------------------------------------------------------------------初始化
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight)];
    [myScrollView setDelegate:self];
    [myScrollView setContentSize:CGSizeMake(pageWidth*4, 460)];
    //[myScrollView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    [myScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:myScrollView];
    
    //-翻页
    [myScrollView setPagingEnabled:YES];
    
    //加上图片，看看效果
    [self loadScrollViewSubViews];
    
    //----------------------------------------------------------------------------------------------myScrollView，初始到中间
    [myScrollView setContentOffset:CGPointMake(0, 0)];
    
    //-为了显示效果，去掉进度条
    [myScrollView setShowsHorizontalScrollIndicator:NO];

    //-增加PageControl直观显示当前滑动位置
    [self addMyPageControl];
    
    //    //初始化请求,可以改内存，但是点击确定后，出错。
    ASIHTTPRequestUtils *asiTemp =[[ASIHTTPRequestUtils alloc] initWithHandleWithoutAutoRelease:self];
    self.aSIHTTPRequestUtils = asiTemp;
    [asiTemp release];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark 加上ImageView看看效果
- (void)loadScrollViewSubViews
{
    //创建4个帮助图片
    imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_0.png"]];
    imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_1.png"]];
    imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_2.png"]];
    imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_3.png"]];
       
    //设置每个帮助图片的边界
    [imageView1 setFrame:CGRectMake(          0, 0, pageWidth, screenHeight )];
    [imageView2 setFrame:CGRectMake(  pageWidth, 0, pageWidth, screenHeight)];
    [imageView3 setFrame:CGRectMake(2*pageWidth, 0, pageWidth, screenHeight)];
    [imageView4 setFrame:CGRectMake(3*pageWidth, 0, pageWidth, screenHeight)];
    
    //最后一个帮助图片种【立即体验】按钮正常和点击后的背景图片
    imageGoIn= [UIImage imageNamed:@"use_soon"];
    imageGoInPress=[UIImage imageNamed:@"use_soon_press"];
    
    //创建并设置【立即体验】按钮的大小和位置
    gonInButton = [ UIButton buttonWithType:UIButtonTypeCustom];
    [gonInButton setBackgroundImage:imageGoIn forState:UIControlStateNormal];
    [gonInButton setBackgroundImage:imageGoInPress forState:UIControlStateHighlighted];
    gonInButton.frame = CGRectMake(75.5,screenHeight-100,169,43.5);
    
    imageView4.userInteractionEnabled =YES;
    [imageView4 addSubview:gonInButton];
    
   //设置【立即体验】点击后执行的方法
    [gonInButton addTarget:self action:@selector(useSoon) forControlEvents:UIControlEventTouchUpInside];
    
    //把图片添加到父视图
    [myScrollView addSubview:imageView1];
    [myScrollView addSubview:imageView2];
    [myScrollView addSubview:imageView3];
    [myScrollView addSubview:imageView4];
}

-(void) useSoon{

    //发请求，是否加密，并保存
//    NSString* url=[[[NSString alloc] initWithString:@"sm/loginAction.do?method=encryptConfig4MOS"] autorelease];
//
//    [aSIHTTPRequestUtils requestData:url data:nil action:@selector(gotoService:) isShowProcessBar:YES];
    [DataProcess addOrChangeConfig:[NSNumber numberWithBool:NO] forKey:@"isFirstRun"];
    
    //    LoginViewController *g2V = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    //    self.loginViewController = g2V;
    //    [self.navigationController pushViewController:self.loginViewController animated:YES];
    
    ChooseServerViewController *g2V = [[ChooseServerViewController alloc] initWithNibName:@"ChooseServerViewController" bundle:nil];
    self.chooseServerViewController = g2V;
    [self.navigationController pushViewController:self.chooseServerViewController animated:YES];
    //  [self presentModalViewController:g2V animated:NO];
    [g2V release];
    
}
- (void)gotoService:(NSData*)data{
    
     NSString *str = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"detailInfoMap is : \n%@",str);
    
    //把数值放入缓存中
    ((AppDelegate*)[[UIApplication sharedApplication]delegate]).isEncrypt =str;
    
    [DataProcess addOrChangeConfig:[NSNumber numberWithBool:NO] forKey:@"isFirstRun"];
    //    LoginViewController *g2V = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    //    self.loginViewController = g2V;
    //    [self.navigationController pushViewController:self.loginViewController animated:YES];
    
    ChooseServerViewController *g2V = [[ChooseServerViewController alloc] initWithNibName:@"ChooseServerViewController" bundle:nil];
    self.chooseServerViewController = g2V;
    [self.navigationController pushViewController:self.chooseServerViewController animated:YES];
    //  [self presentModalViewController:g2V animated:NO];
    [g2V release];
    
}


//界面控制，用于显示当前帮助图片是第几张
- (void)addMyPageControl
{
    myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(110, screenHeight-40, 100, 20)];
    [myPageControl setNumberOfPages:4];
    
    [myPageControl setCurrentPage:curentImage];
    [self.view addSubview:myPageControl];
}



#pragma mark -
- (void)dealloc
{
    [super dealloc];
    
    [myScrollView removeGestureRecognizer:tap];
    [myScrollView removeFromSuperview];
    [myScrollView release];
    
    [imageView1 removeFromSuperview];
    [imageView1 release];
    
    [imageView2 removeFromSuperview];
    [imageView2 release];
    
    [imageView3 removeFromSuperview];
    [imageView3 release];
    
    [tap release];
    
    [myPageControl removeFromSuperview];
    [myPageControl release];
   
    [imageGoIn release];
    [imageGoInPress release];
    [gonInButton release];
}

//划动动作停止后所执行的动作
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x>=0){
        [myPageControl setCurrentPage:0];
    }
    if(scrollView.contentOffset.x>=pageWidth){
        [myPageControl setCurrentPage:1];
    }
    if(scrollView.contentOffset.x>=2*pageWidth){
        [myPageControl setCurrentPage:2];
    }
    if(scrollView.contentOffset.x>=3*pageWidth){
        [myPageControl setCurrentPage:3];
    }

}


@end
