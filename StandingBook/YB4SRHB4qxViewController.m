//
//  ViewController.m
//  Custom
//
//  Created by tan on 13-1-22.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "YB4SRHB4qxViewController.h"
#import "CustomTableView.h"
#import "DateUtils.h"
#import "HomePageViewController.h"

@interface YB4SRHB4qxViewController ()

@end

@implementation YB4SRHB4qxViewController
@synthesize aSIHTTPRequestUtils;
@synthesize reslist;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //self.edgesForExtendedLayout = UIExtendedEdgeNone;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    
    col=7;
    tableviewy=90;
    reportFlag=@"zczsr";//2g发展日报
    showwgFlag=YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(showActionSheet)];
    [self initSwitchButton];
    [self setcurrentSwitchStyle:self.switchzczsrButton];
    
    self.pickerView.frame = CGRectMake(0, 480, 320, 300);
    
    
    
   NSString *date=[DateUtils getLastMonthStr];
    _reqdic = [[NSMutableDictionary alloc] init];
    [_reqdic setObject:date forKey:@"date"];
    [_reqdic setObject:@"全部" forKey:@"cp"];
    [self initData:_reqdic];
    
    [super setWrapTitle:@"旗县收入环比通报" date:date];
    
    //[self initToolBarItem];
    [self initToolBar4zsjf];
}

- (void)showListView {
    NSLog(@"dddddd");
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"选择产品" options:self.options handler:^(NSInteger anIndex) {
        NSDictionary* dqdic=_options[anIndex];
        NSString* dq=[dqdic objectForKey:@"diqu"];
        NSLog(@"vvvvvvvvv%@",_options[anIndex]);
        [_reqdic setObject:dq forKey:@"cp"];
        [self initData:_reqdic];
        
    }];
    //lplv.delegate = self;
    [lplv showInView:self.view animated:YES];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self showListView];
        NSLog(@"xxxxxxxxxxxx");
    }else if (buttonIndex==1){
        [self showDateSelectView];
    }
}


-(void)showActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"筛选条件"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"选择产品", @"选择日期",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
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
        [requestDic setObject:@"ANY" forKey:@"showcpFlag"];
    }
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    NSString* subUrl=@"";
    subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=showYB4srhbtb4qx"] autorelease];
   [aSIHTTPRequestUtils requestData:subUrl data:_reqdic action:@selector(doAfterinitData:) isShowProcessBar:YES];
    
}

-(void)initSwitchButton{
    [self.switchzczsrButton setTitle:@"出账收入" forState:UIControlStateNormal];
    [self.switcclyhButton setTitle:@"存量用户" forState:UIControlStateNormal];
    [self.swithcjlyhsButton setTitle:@"减量用户" forState:UIControlStateNormal];
    [self.swithzlyhButton setTitle:@"增量用户" forState:UIControlStateNormal];
    [self.swithczjzButton setTitle:@"出账净增" forState:UIControlStateNormal];
    [self setSwitchButtonStyle:self.switchzczsrButton];
    [self setSwitchButtonStyle:self.switcclyhButton];
    [self setSwitchButtonStyle:self.swithcjlyhsButton];
    [self setSwitchButtonStyle:self.swithzlyhButton];
    [self setSwitchButtonStyle:self.swithczjzButton];
    
    
}


-(void)setSwitchButtonStyle:(UIButton*) button{
    [button setTitleColor:[UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0]
                 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0]
                 forState:UIControlStateNormal];
    button.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    button.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    
}



//登录成功后执行方法
-(void) doAfterinitData:(NSData*)responseData {
    //解析服务器返回数据
    if (responseData!=nil) {
        NSDictionary* list = [DataProcess getNSDictionaryFromNSData:responseData];
        if(reportFlag==nil || [reportFlag isEqualToString:@"zczsr"]
           ){
            [self initTableTitle4zczsr];
        }
        self.reslist=list;
        [self initcpList:list];

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
    
    NSMutableArray *sortedArr=[self sort:array];
    NSMutableArray *dArray = [NSMutableArray arrayWithCapacity:0];
    
    
    for (int i = 0; i < [sortedArr  count]; i ++) {//行数
        NSDictionary* vo=sortedArr[i];
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:0];
        for (NSString *key in trDict) {
            if([reportFlag isEqualToString:@"zczsr"] || reportFlag==nil){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"qx"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"zzSyyhs"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"zzSysr"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"zzDyyhs"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"zzDysr"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"zzHbyhs"];
                }else if([key isEqualToString:@"6"]){
                    rfa=[vo objectForKey:@"zzHbsr"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"clyh"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"qx"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"clYhs"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"clSysr"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"clDysr"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"clHbsr"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"jlyh"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"qx"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"jlYhs"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"jlSysr"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"zlyh"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"qx"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"zlYhs"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"zlDysr"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"czjz"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"qx"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"czYhs"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"czSr"];
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
    //  [self.view addSubview:view];
    [view release];
    
    
}

-(NSMutableArray*)sort:(NSMutableArray*)arr {
    NSMutableArray *amarr=[self transDataType:arr];
    
    NSString *sortByCol=@"";
    
    if (amarr!=nil && amarr.count>0) {
        //如果有‘合计’项，则把合计剔除，然后按照 ‘当月累计’从高到低排序
        //        NSDictionary *d=arr[arr.count-1];
        
        if (reportFlag==nil ||[@"zczsr" isEqualToString:reportFlag]) {
            sortByCol=@"zzDysr";
        }else if([@"clyh" isEqualToString:reportFlag]){
            sortByCol=@"clDysr";
        }else if([@"jlyh" isEqualToString:reportFlag]){
            sortByCol=@"jlYhs";
        }else if([@"zlyh" isEqualToString:reportFlag]){
            sortByCol=@"zlDysr";
        }else if([@"czjz" isEqualToString:reportFlag]){
            sortByCol=@"czYhs";
        }
        
        
        NSSortDescriptor *descripor=[[NSSortDescriptor alloc] initWithKey:sortByCol ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&descripor count:1];
        
        [amarr sortUsingDescriptors:sortDescriptors];
        
        //[amarr addObject:d];
        
        [descripor release];
        [sortDescriptors release];
        return amarr;
    }else{
        return arr;
    }
}

-(NSMutableArray*)transDataType:(NSArray*) arr{
    NSMutableArray *newArr= [NSMutableArray arrayWithCapacity:0];
    for(int i=0;i<arr.count;i++){
        NSDictionary *dd=arr[i];
        NSString *dq=[dd objectForKey:@"zdywQy"];
        if(![@"合计" isEqualToString:dq ]){
            NSMutableDictionary *md=[[NSMutableDictionary alloc] initWithDictionary:dd];
            
            NSString *g2s=[dd objectForKey:@"zdyw2gylj"];
            int a=[g2s intValue];
            [md setValue:[NSNumber numberWithInt:a] forKey:@"zdyw2gylj"];
            
            NSString *g3s=[dd objectForKey:@"zdyw3gylj"];
            int b=[g3s intValue];
            [md setValue:[NSNumber numberWithInt:b] forKey:@"zdyw3gylj"];
            
            NSString *kdfzrb=[dd objectForKey:@"zdywKdylj"];
            int c=[kdfzrb intValue];
            [md setValue:[NSNumber numberWithInt:c] forKey:@"zdywKdylj"];
            
            NSString *zdywKdcjdylj=[dd objectForKey:@"zdywKdcjdylj"];
            int d=[zdywKdcjdylj intValue];
            [md setValue:[NSNumber numberWithInt:d] forKey:@"zdywKdcjdylj"];
            
            NSString *a2g3gfz=[dd objectForKey:@"zdyw2g3gylj"];
            int e=[a2g3gfz intValue];
            [md setValue:[NSNumber numberWithInt:e] forKey:@"zdyw2g3gylj"];
            
            
            [newArr addObject:md];
            [md release];
            
        }
        
        
    }
    return newArr ;
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

//初始化网格列表，用于展示查询条件
-(void)initcpList:(NSDictionary*) dic{
    if(showwgFlag==YES){
        //初始化并关闭开关
        NSMutableArray* array=[self.reslist objectForKey:@"cplist"];
        self.options=array;
        showwgFlag=NO;
        [_reqdic setObject:@"" forKey:@"showcpFlag"];
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
        reportFlag=@"zczsr";
        col=7;
        tableviewy=84;
        [self initTableTitle4zczsr];
    }else if(sender.tag==1){
        reportFlag=@"clyh";
        col=5;
        tableviewy=84;
        [self initTableTitle4clyh];
    }else if(sender.tag==2){
        reportFlag=@"jlyh";
        col=3;
        tableviewy=96;
        [self initTableTitle4jlyh];
    }else if(sender.tag==3){
        reportFlag=@"zlyh";
        col=3;
        tableviewy=96;
        [self initTableTitle4zlyh];
    }else if(sender.tag==4){
        reportFlag=@"czjz";
        col=3;
        tableviewy=84;
        [self initTableTitle4czjz];
        
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
-(void)initTableTitle4jlyh{
    [self removeTitle];//删除原来表头，重建表头
    
    CGRect rectkhq =CGRectMake(0, 60, 107, 23);
    UILabel *labelkhq = [[UILabel alloc] initWithFrame:rectkhq];
    labelkhq.tag=100;
    labelkhq.text = @"旗县";
    [self setLabelStyle:labelkhq];
    
    CGRect rectdq =  CGRectMake(108, 60, 106, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=101;
    labeldq.text = @"用户数";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz =CGRectMake(215, 60, 105, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=102;
    labelrfz.text = @"上月出账收入";
    [self setLabelStyle:labelrfz];
    
    [self.view addSubview:labelkhq];
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
}

-(void)initTableTitle4zlyh{
    [self removeTitle];//删除原来表头，重建表头
    
    CGRect rectkhq =CGRectMake(0, 60, 107, 23);
    UILabel *labelkhq = [[UILabel alloc] initWithFrame:rectkhq];
    labelkhq.tag=100;
    labelkhq.text = @"旗县";
    [self setLabelStyle:labelkhq];
    
    CGRect rectdq = CGRectMake(108, 60, 106, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=101;
    labeldq.text = @"用户数";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz =CGRectMake(215, 60, 105, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=102;
    labelrfz.text = @"当月出账收入";
    [self setLabelStyle:labelrfz];
    
    [self.view addSubview:labelkhq];
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
}

//初始化表头
-(void)initTableTitle4czjz{
    [self removeTitle];//删除原来表头，重建表头
    
    CGRect rectkhq =CGRectMake(0, 60, 107, 23);
    UILabel *labelkhq = [[UILabel alloc] initWithFrame:rectkhq];
    labelkhq.tag=100;
    labelkhq.text = @"旗县";
    [self setLabelStyle:labelkhq];
    
    CGRect rectdq = CGRectMake(108, 60, 106, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=101;
    labeldq.text = @"用户";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz =CGRectMake(215, 60, 105, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=102;
    labelrfz.text = @"收入";
    [self setLabelStyle:labelrfz];
    
    [self.view addSubview:labelkhq];
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
}


//初始化表头
-(void)initTableTitle4clyh{
    [self removeTitle];//删除原来表头，重建表头
    
    CGRect rectkhq =CGRectMake(0, 60, 52, 23);
    UILabel *labelkhq = [[UILabel alloc] initWithFrame:rectkhq];
    labelkhq.tag=100;
    labelkhq.text = @"客户群";
    [self setLabelStyle:labelkhq];
    
    CGRect rectdq = CGRectMake(53, 60, 65, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=101;
    labeldq.text = @"用户数";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz =CGRectMake(119, 60, 72, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=102;
    labelrfz.text = @"上月出账收入";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(192, 60, 79, 23);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=103;
    labeldylj.text = @"当月出账收入";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(272, 60, 49, 23);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=104;
    labelsytqlj.text = @"收入环比";
    [self setLabelStyle:labelsytqlj];
    
    [self.view addSubview:labelkhq];
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelsytqlj];
    
}





//初始化表头
-(void)initTableTitle4zczsr{
    [self removeTitle];//删除原来表头，重建表头
    
    CGRect rectkhq = CGRectMake(0, 60, 42, 34);
    UILabel *labelkhq = [[UILabel alloc] initWithFrame:rectkhq];
    labelkhq.tag=100;
    labelkhq.text = @"旗县";
    [self setLabelStyle:labelkhq];
    
    
    CGRect rectdq = CGRectMake(43, 60, 45, 34);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=101;
    labeldq.text = @"上月用户数";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(89, 60, 45, 34);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=102;
    labelrfz.text = @"上月收入";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(135, 60, 45, 34);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=103;
    labeldylj.text = @"当月用户数";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(181, 60, 45, 34);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=104;
    labelsytqlj.text = @"当月收入";
    [self setLabelStyle:labelsytqlj];
    
    CGRect yhshb = CGRectMake(227, 60, 45, 34);
    UILabel *labelyhshb = [[UILabel alloc] initWithFrame:yhshb];
    labelyhshb.tag=105;
    labelyhshb.text = @"用户数环比";
    [self setLabelStyle:labelyhshb];
    
    CGRect rectsrhb = CGRectMake(273, 60, 45, 34);
    UILabel *labelsrhb = [[UILabel alloc] initWithFrame:rectsrhb];
    labelsrhb.tag=106;
    labelsrhb.text = @"收入环比";
    [self setLabelStyle:labelsrhb];
    
    
    [self.view addSubview:labelkhq];
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelsytqlj];
    [self.view addSubview:labelyhshb];
    [self.view addSubview:labelsrhb];
    
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

- (IBAction)chooseDate:(id)sender {
    NSDate *select = [self.myDatePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (self.myDatePicker.datePickerMode == UIDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *selectDate =  [dateFormatter stringFromDate:select];
        NSLog(@"selectDateselectDate%@",selectDate);
        [self removePickerView:nil];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *selectDate =  [dateFormatter stringFromDate:select];
        
        [super setWrapTitle:@"旗县收入环比通报" date:[selectDate substringWithRange:NSMakeRange(0,7)]];
        
        NSLog(@"selectDateselectDate%@",selectDate);
        [_reqdic setObject:selectDate forKey:@"date"];
        [self initData:_reqdic];
        [self removePickerView:nil];
    }
}





- (void)dealloc {
    [aSIHTTPRequestUtils release];
    [reslist release];
    [_switcclyhButton release];
    [_switchzczsrButton release];
    [_swithcjlyhsButton release];
    [_swithczjzButton release];
    [_swithzlyhButton release];
    [_whickReportFlag release];
    [_reqdic release];
    [super dealloc];
}
- (void)viewDidUnload {
    
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
