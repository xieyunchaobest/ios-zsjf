//
//  MenuViewController.m
//  AlertViewAnimation
//
//  Created by zhangyu on 13-9-17.
//  Copyright (c) 2013年 steven. All rights reserved.
//

#import "MenuViewController.h"
#import "WoDetailViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize superViewController;
@synthesize firstMenuViewController;
@synthesize myDetailScrollView;
@synthesize secondMenuViewController;

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

    pageWidth = 320;
    myDetailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 219, 320, 145)];
    myDetailScrollView.delegate = self;
    
    if (self.mutableMosWoDetailFuncNodeSVOList.count>8) {
        [myDetailScrollView setContentSize:CGSizeMake(pageWidth*2, 0)];
    }else{
        [myDetailScrollView setContentSize:CGSizeMake(pageWidth, 0)];
        self.normalButton.hidden = YES;
        self.cusorImage.hidden = YES;
        self.moreButton.frame = CGRectMake(0, 35, 320, 35);
        self.moreButton.enabled = NO;
    }
    [myDetailScrollView setBackgroundColor:[UIColor whiteColor]];
    //加上图片，看看效果
    [self loadScrollViewSubViews];
    [self.view addSubview:myDetailScrollView];
    //-翻页
    [myDetailScrollView setPagingEnabled:YES];
    myDetailScrollView.directionalLockEnabled=YES ;
    myDetailScrollView.alwaysBounceVertical=NO;
    

    
    //----------------------------------------------------------------------------------------------myScrollView，初始到中间
//    [myDetailScrollView setContentOffset:CGPointMake(0, 0)];
    
    //-为了显示效果，去掉进度条
    [myDetailScrollView setShowsHorizontalScrollIndicator:NO];
    [myDetailScrollView setShowsVerticalScrollIndicator:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeAllObjects];
    [myDetailScrollView release];
    [_cusorImage release];
    [_normalButton release];
    [_moreButton release];
    [super dealloc];
}

#pragma mark -自定义方法

- (void)show{
    self.view.center = self.superViewController.view.center;
    [self.superViewController.view addSubview:self.view];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.view.layer addAnimation:popAnimation forKey:nil];
}

- (IBAction)hideAlertAction{
    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    hideAnimation.duration = 0.4;
    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.00f, 0.00f, 0.00f)]];
    hideAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f];
    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    hideAnimation.delegate = self;
    [self.view.layer addAnimation:hideAnimation forKey:nil];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.view removeFromSuperview];
}

//动态添加主视图模块方法
/*
 *imageName 图片名称
 *location 位置结构体
 *srcDic 结构控制节点源数组
 *Added By Zhang Yu 2013-10-12
 */
-(void)addSubFuncNode:(NSString *)imageName location:(CGRect) rect srcDic:(NSDictionary*) srcDic
{
    UIButton* myButton = [UIButton buttonWithType:UIButtonTypeCustom];//设置按钮样式为圆角矩形
    myButton.frame = rect;
    
    if ([imageName isEqualToString:@"func_nav_gis_normal"]) {
        NSString* imageNameChange = @"detail_resourses_check_normal";
        [myButton setBackgroundImage:[UIImage imageNamed:imageNameChange] forState:UIControlStateNormal];//正常状态下时候的标题
    }
    else
        [myButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];//正常状态下时候的标题
    //子视图加入到Second还是First的标志
    if (_tag) {
        [self.secondMenuViewController.view addSubview:myButton];
    }else
        [self.firstMenuViewController.view addSubview:myButton];
    NSDictionary* mosFuncNodeMethodDic = ((AppDelegate*)[[UIApplication sharedApplication]delegate]).mosFuncNodeMethodDic;
    NSString *methodName = [mosFuncNodeMethodDic objectForKey:[srcDic objectForKey:@"shortName"]];
    if ([self dealFuncNode:srcDic]) {
        if ([imageName isEqualToString:@"func_nav_gis_normal"]) {
            NSString* methodNameChange = @"unknowMethod:";
            [myButton addTarget:self action:NSSelectorFromString(methodNameChange) forControlEvents:UIControlEventTouchDown];
        }else
            [myButton addTarget:self action:NSSelectorFromString(methodName) forControlEvents:UIControlEventTouchDown];
    }else
        [myButton addTarget:self action:NSSelectorFromString(@"prompUnuseFul") forControlEvents:UIControlEventTouchDown];
}

//判断是否为授权功能   Added By Zhang Yu 2013-10-12
-(BOOL)dealFuncNode:(NSDictionary *)srcDic
{
    NSString *funccLevel = [srcDic objectForKey:@"funccLevel"];
    if ([@"V" isEqualToString:funccLevel]) {
        return NO;
    }else{
        return YES;
    }
}
//非可用功能提示不可用   Added By Zhang Yu 2013-10-12
-(void)prompUnuseFul{
    [Prompt makeText:@"该功能暂未开放" target:self];
}


- (void)loadScrollViewSubViews{
    //向视图添加两个子视图
    
    firstMenuViewController = [[FirstMenuViewController alloc] initWithNibName:@"FirstMenuViewController" bundle:nil];
    firstMenuViewController.superViewController = self;
    firstMenuViewController.view.frame=CGRectMake(0,0,320,145);
    
//    firstMenuViewController.firstMutableMosWoDetailFuncNodeSVOList = self.mutableMosWoDetailFuncNodeSVOList;
    
    
    //读取本地文件的图片Mapping
    NSDictionary* mosFuncNodeImageViewDic = ((AppDelegate*)[[UIApplication sharedApplication]delegate]).mosFuncNodeImageViewDic;
    for (int i=0; i<self.mutableMosWoDetailFuncNodeSVOList.count; i++) {
        if (i==0) {
            CGRect rect = CGRectMake(20,16,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }else if(i==1){
            CGRect rect = CGRectMake(100,16,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }else if(i==2){
            CGRect rect = CGRectMake(180,16,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==3){
            CGRect rect = CGRectMake(260,16,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==4){
            CGRect rect = CGRectMake(20,75,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==5){
            CGRect rect = CGRectMake(100,75,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==6){
            CGRect rect = CGRectMake(180,75,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==7){
            CGRect rect = CGRectMake(260,75,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
    }
    
    
    
    secondMenuViewController = [[SecondMenuViewController alloc] initWithNibName:@"SecondMenuViewController" bundle:nil];
    secondMenuViewController.view.frame=CGRectMake(320,0,320,145);
    
    //把子视图添加到父视图
    [myDetailScrollView addSubview:firstMenuViewController.view];
    [myDetailScrollView addSubview:secondMenuViewController.view];
    for (int i=8; i<self.mutableMosWoDetailFuncNodeSVOList.count; i++) {
        if (i==8) {
            _tag = YES;
            CGRect rect = CGRectMake(20,16,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }else if(i==9){
            CGRect rect = CGRectMake(100,16,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }else if(i==10){
            CGRect rect = CGRectMake(180,16,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==11){
            CGRect rect = CGRectMake(260,16,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==12){
            CGRect rect = CGRectMake(20,75,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==13){
            CGRect rect = CGRectMake(100,75,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==14){
            CGRect rect = CGRectMake(180,75,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
        else if(i==15){
            CGRect rect = CGRectMake(260,75,50,40);
            NSString *shortName = [[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i] objectForKey:@"shortName"];
            NSString *nodeName = [mosFuncNodeImageViewDic objectForKey:shortName];
            [self addSubFuncNode:nodeName location:rect srcDic:[self.mutableMosWoDetailFuncNodeSVOList objectAtIndex:i]];
        }
    }
    
    
}



//呼叫
- (IBAction)phoneCall:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kPhoneCallMethod object:self];
}

//退单
- (IBAction)failReturn:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kFailReturnMethod object:self];
}

//回单
- (IBAction)successReturn:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kSuccessReturnMethod object:self];
}

//竣工核实
- (IBAction)returnVisit:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kReturnVisitMethod object:self];
}

//资源变更
- (IBAction)reschange:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kYwcsMethod object:self];
}
//网格维护
- (IBAction)sevDept:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kSevDeptMethod object:self];
}
//预约
- (IBAction)reservingTimeMethod:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kReservingTimeMethod object:self];
}
//转派
- (IBAction)changeWorkOrderMethod:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:KChangeWorkOrderMethod object:self];
}

#pragma -mark 未开放功能
-(IBAction)unknowMethod:(id)sender{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kYwcsMethod object:self];
}

#pragma -mark 材料回填
-(IBAction)metarilFillBack:(id)sender{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kMetarilFillBackMethod object:self];
}


#pragma mark -UIScrollView

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (flag){
        
        startX=scrollView.contentOffset.x;
        
    }
    flag =FALSE;
}

//划动动作停止后所执行的动作
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    flag=TRUE;
    endX= scrollView.contentOffset.x;
    [self changePageBar];
    
}


- (IBAction)clickCommonPage:(id)sender{
    
    
    if(myDetailScrollView.contentOffset.x==0){
        [self movePageBar:0 :0];
    }
    if(myDetailScrollView.contentOffset.x==pageWidth){
        [self movePageBar:160 :0];
    }
    [myDetailScrollView setContentOffset:CGPointMake(0, 0)];
    
}
- (IBAction)clickSeniorPage:(id)sender{
    
    //判断scrollview当前页
    
    if(myDetailScrollView.contentOffset.x==0){
        
        [self movePageBar:0 :160];
        
    }
    if(myDetailScrollView.contentOffset.x==pageWidth){
        
        [self movePageBar:160 :160];
        
    }
    [myDetailScrollView setContentOffset:CGPointMake(320, 0)];
    
}

-(void)movePageBar: (int)sX :(int)eX{
    
    _cusorImage.frame = CGRectMake(sX,65, 160, 4);
    //设定imageView要到达的点
    frame = _cusorImage.frame;
    frame.origin.x = eX;
    [UIView beginAnimations:@"PopView" context:_cusorImage];
    [UIView setAnimationDuration:0.3f];
    [_cusorImage setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [UIView commitAnimations];
    
}

-(void)changePageBar{
    if(endX== pageWidth && startX==0){
        //从1到2
        [self movePageBar:0 :160];
    }
    
    if(endX==0 && startX==pageWidth ){
        //从2到1
        
        [self movePageBar:160 :0];
    }
    
    if(startX==endX){
        if(startX==0){
            [self movePageBar:0 :0];
        }
        else if (startX==pageWidth)
        {
            [self movePageBar:160 :160];
        }
    }
    
}


@end
