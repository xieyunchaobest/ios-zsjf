//
//  ViewController.m
//  Custom
//欠费日报-欠费日通报
//  Created by tan on 13-1-22.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "Qfrb4QfrtbViewController.h"
#import "CustomTableView.h"
#import "DateUtils.h"
#import "LeveyPopListView.h"

@interface Qfrb4QfrtbViewController ()

@end

@implementation Qfrb4QfrtbViewController
@synthesize aSIHTTPRequestUtils;
@synthesize reslist;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title=@"网点业务发展日报";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        ////self.edgesForExtendedLayout = UIExtendedEdgeNone;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    col=5;
    tableviewy=95;
    reportFlag=@"gw";//固网
    showwgFlag=YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(showActionSheet)];
    [self initSwitchButton];
    [self setcurrentSwitchStyle:self.switchGwButton];
    
    self.pickerView.frame = CGRectMake(0, 480, 320, 300);
    
    NSString *date=[DateUtils getYesterdayStr];
    [super setWrapTitle:@"欠费日通报" date:date];
     _reqdic = [[NSMutableDictionary alloc] init];
    [_reqdic setObject:date forKey:@"date"];
    [_reqdic setObject:@"全部" forKey:@"wg"];
    [self initData:_reqdic];
    [self initToolBar4zsjf];
}



-(void)showDateSelectView{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    CGRect mainBounds = [[UIScreen mainScreen] bounds];
    self.pickerView.frame = CGRectMake(0, mainBounds.size.height-300, 320, 300);
    [self.myDatePicker setDate:[DateUtils getYesterday]];
    self.myDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.pickerView];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
}

-(void)initData:(NSMutableDictionary*)requestDic{
    if (showwgFlag==YES) {
        [requestDic setObject:@"ANY" forKey:@"showwgFlag"];
    }
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=qfrb4qfrtb"] autorelease];
    [requestDic setObject:[DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserId forKey:@"staffId"];
    [aSIHTTPRequestUtils requestData:subUrl data:requestDic action:@selector(doAfterinitData:) isShowProcessBar:YES]; 
}

-(void)initSwitchButton{
    [self.switchGwButton setTitle:@"固网" forState:UIControlStateNormal];
    [self.swith2gButton setTitle:@"2G" forState:UIControlStateNormal];
    [self.switch3gButton setTitle:@"3G" forState:UIControlStateNormal];
    [self.switch4gButton setTitle:@"4G" forState:UIControlStateNormal];
    [self setSwitchButtonStyle:self.switchGwButton];
    [self setSwitchButtonStyle:self.swith2gButton];
    [self setSwitchButtonStyle:self.switch3gButton];
    [self setSwitchButtonStyle:self.switch4gButton];
    
}




-(void)showActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"筛选条件"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"选择客户群", @"选择日期",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self showListView];
        NSLog(@"xxxxxxxxxxxx");
    }else if (buttonIndex==1){
        [self showDateSelectView];
    }
}



- (void)showListView {
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"选择客户群" options:self.options handler:^(NSInteger anIndex) {
        NSDictionary* dqdic=_options[anIndex];
        NSString* dq=[dqdic objectForKey:@"diqu"];
        NSLog(@"vvvvvvvvv%@",_options[anIndex]);
        [_reqdic setObject:dq forKey:@"diqu"];
        [self initData:_reqdic];
        
    }];
    //lplv.delegate = self;
    [lplv showInView:self.view animated:YES];
}



-(void)setSwitchButtonStyle:(UIButton*) button{
    [button setTitleColor:[UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0]
                 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0]
                 forState:UIControlStateNormal];
    button.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    button.titleLabel.textAlignment=NSTextAlignmentCenter;
    
}


//初始化网格列表，用于展示查询条件
-(void)initwgList:(NSDictionary*) dic{
    if(showwgFlag==YES){
        //初始化并关闭开关
        NSMutableArray* array=[self.reslist objectForKey:@"wglist"];
        self.options=array;
        showwgFlag=NO;
        [_reqdic setObject:@"" forKey:@"showwgFlag"];
    }
}




//登录成功后执行方法
-(void) doAfterinitData:(NSData*)responseData {
    //解析服务器返回数据
    if (responseData!=nil) {
        NSDictionary* list = [DataProcess getNSDictionaryFromNSData:responseData];
        if(reportFlag==nil || [reportFlag isEqualToString:@"gw"] || [reportFlag isEqualToString:@"2g"]||[reportFlag isEqualToString:@"3g"] || [reportFlag isEqualToString:@"4g"]){
            [self initTableTitle42g3g];
        }else{
            [self initTableTitle4wyhlwgx];
        }
        self.reslist=list;
         [self initwgList:list];
    }
    
    NSMutableArray* array=[self.reslist objectForKey:@"list"];
    
    NSMutableDictionary *trDict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableArray *leftKeys = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *rightKeys = [NSMutableArray arrayWithCapacity:0];
    int leftNumber = 1;
    for (int i = 0; i < col; i++) {//列数
        NSString *key = [NSString stringWithFormat:@"%d", i];
        [trDict setValue:[NSNumber numberWithFloat:320/col+1] forKey:key];//每一列的宽度
        if (i < leftNumber) {
            [leftKeys addObject:key];
        } else {
            [rightKeys addObject:key];
        }
    }
    
    NSMutableArray *dArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < [array  count]; i ++) {//行数
        NSDictionary* vo=array[i];
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:0];
        for (NSString *key in trDict) {
            if([reportFlag isEqualToString:@"gw"] || reportFlag==nil){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"gwDyqfcz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"gwDyqfje"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"gwDyqfhsl"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"gwYqqf"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"2g"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"g2Dyqfcz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"g2Dyqfje"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"g2Dyqfhsl"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"g2Yqqf"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"3g"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"g3Dyqfcz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"g3Dyqfje"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"g3Dyqfhsl"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"g3Yqqf"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"4g"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"g4Dyqfcz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"g4Dyqfje"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"g4Dyqfhsl"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"g4Yqqf"];
                }
                [data setValue:rfa forKey:key];
            }
        }
        [dArray addObject:data];
    }
    
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[CustomTableView class]]){
            [view removeFromSuperview];
        }
    }
    
    CustomTableView *view = [[CustomTableView alloc] initWithData:dArray trDictionary:trDict size:CGSizeMake(self.view.frame.size.width, 400) scrollMethod:kScrollMethodWithRight leftDataKeys:leftKeys rightDataKeys:rightKeys];
    CGRect frame = view.frame;
    frame.origin = CGPointMake(0, tableviewy);
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    [view release];
    
    
}


-(void)setDefaultSwitchImage:(UIButton*)btn{
    for(UIView *view in self.view.subviews){
        NSLog(@"tagtagtagtag%d",view.tag);
        if(view.tag>=200 && view.tag<=205){
            if(view.tag!=btn.tag+200){
                [view setHidden:YES];
            }else{
                [view setHidden:NO];
            }
        }
    }
}





-(void)setcurrentSwitchStyle:(UIButton*) button{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UIButton class]]){
            UIButton *btn =(UIButton*)view;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    [button setTitleColor:[UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0]
                 forState:UIControlStateNormal];
    [self setDefaultSwitchImage:button];
}

- (IBAction)showReport:(UIButton*)sender{
    [self setcurrentSwitchStyle:sender];
    if(sender.tag==0){
        reportFlag=@"gw";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }else if(sender.tag==1){
        reportFlag=@"2g";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }else if(sender.tag==2){
        reportFlag=@"3g";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }else if(sender.tag==3){
        reportFlag=@"4g";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }
    [self doAfterinitData:nil];
    
}

-(void)removeTitle{
    for(UIView *view in self.view.subviews){
        if(view.tag>=100  && view.tag<200){
            [view removeFromSuperview];
        }
    }
}


//初始化表头
-(void)initTableTitle42g3g{
    [self removeTitle];//删除原来表头，重建表头
    CGRect rectdq = CGRectMake(0, 60, 52, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=100;
    labeldq.text = @"部门";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(53, 60, 68, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"欠费出账";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(122, 60, 67, 23);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"欠费金额";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(190, 60, 81, 23);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"欠费回收率";
    [self setLabelStyle:labelsytqlj];
    
    CGRect rectzzs = CGRectMake(272, 60, 49, 23);
    UILabel *labelzzs = [[UILabel alloc] initWithFrame:rectzzs];
    labelzzs.tag=104;
    labelzzs.text = @"欠费总额";
    [self setLabelStyle:labelzzs];
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelsytqlj];
    [self.view addSubview:labelzzs]; 
    
    // [super viewDidLoad];
    
}

-(void)initTableTitle4wyhlwgx{
    [self removeTitle];//删除原来表头，重建表头
    CGRect rectdq = CGRectMake(0, 60, 79, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=100;
    labeldq.text = @"片区";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(80, 60, 79, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"日发展";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(160, 60, 79, 23);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"当月累计";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(240, 60, 80, 23);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"当月累计拆";
    [self setLabelStyle:labelsytqlj];
    
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelsytqlj];
}

-(void)setLabelStyle:(UILabel*)label{
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    // 设置字体颜色
    label.textColor = [UIColor whiteColor];
    // 设置背景色
    label.backgroundColor = [UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0]; 
    //label.backgroundColor = [UIColor redColor];
    // 文字换行
    //label.numberOfLines = 2;
    
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    
    label.enabled = YES;
    
}


- (IBAction)removePickerView:(id)sender {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    CGRect mainBounds = [[UIScreen mainScreen] bounds];
    self.pickerView.frame = CGRectMake(0, mainBounds.size.height, 320, 300);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

- (IBAction)chooseDate:(UIDatePicker*)sender {
    NSDate *select = [self.myDatePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (self.myDatePicker.datePickerMode == UIDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *selectDate =  [dateFormatter stringFromDate:select];
        NSLog(@"selectDateselectDate%@",selectDate);
        
        // self.myTimeLabel.text = selectDate;
        [self removePickerView:nil];
        // _timeTag = YES;
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *selectDate =  [dateFormatter stringFromDate:select];
        [super setWrapTitle:@"欠费日通报" date:selectDate];
        NSLog(@"selectDateselectDate%@",selectDate);
        //self.myDateLabel.text = selectDate;
        [_reqdic setObject:selectDate forKey:@"date"];
        [self initData:_reqdic];
        [self removePickerView:nil];
        //_dateTag = YES;
    }
}


- (void)dealloc {
    [aSIHTTPRequestUtils release];
    [reslist release];
    [_swith2gButton release];
    [_switch3gButton release];
    [_switchGwButton release];
    [_whickReportFlag release];
    [_reqdic release];
    [_options release];
    [_switch4gButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    
    [self setSwitch4gButton:nil];
    [super viewDidUnload];
}

#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex {
    //_infoLabel.text = [NSString stringWithFormat:@"You have selected %@",_dq_options[anIndex]];
}
- (void)leveyPopListViewDidCancel {
    //_infoLabel.text = @"You have cancelled";
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
