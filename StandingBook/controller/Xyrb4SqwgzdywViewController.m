//
//  ViewController.m
//  Custom
//
//  Created by tan on 13-1-22.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "Xyrb4SqwgzdywViewController.h"
#import "CustomTableView.h"
#import "DateUtils.h"

@interface Xyrb4SqwgzdywViewController ()

@end

@implementation Xyrb4SqwgzdywViewController
@synthesize aSIHTTPRequestUtils;
@synthesize reslist;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //self.edgesForExtendedLayout = UIExtendedEdgeNone;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //self.title=@"网格重点业务日报";
    col=5;
    tableviewy=84;
    reportFlag=@"ptw2g";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStylePlain target:self action:@selector(showDateSelectView)];
    [self initSwitchButton];
    [self setcurrentSwitchStyle:self.switch2fButton];
    
    self.scroll_view.contentSize=CGSizeMake(600,46);
    [self.scroll_view setScrollEnabled:YES];
    [self.scroll_view setShowsHorizontalScrollIndicator:NO];
    
    self.pickerView.frame = CGRectMake(0, 480, 320, 300);
    
    NSString *date=[DateUtils getYesterdayStr];
    [super setWrapTitle:@"商企网格重点业务日报" date:date];
    [self initData:date];
    [self initToolBar4zsjf];
}



-(NSMutableArray*)transDataType:(NSArray*) arr{
    NSMutableArray *newArr= [NSMutableArray arrayWithCapacity:0];
    for(int i=0;i<arr.count;i++){
        NSDictionary *dd=arr[i];
        NSString *dq=[dd objectForKey:@"wgMc"];
        if(![@"合计" isEqualToString:dq ]){
            NSMutableDictionary *md=[[NSMutableDictionary alloc] initWithDictionary:dd];
            
            NSString *g2s=[dd objectForKey:@"pt2gDylj"];
            int a=[g2s intValue];
            [md setValue:[NSNumber numberWithInt:a] forKey:@"pt2gDylj"];
            
            NSString *g3s=[dd objectForKey:@"pt3gDylj"];
            int b=[g3s intValue];
            [md setValue:[NSNumber numberWithInt:b] forKey:@"pt3gDylj"];
            
            NSString *kdfzrb=[dd objectForKey:@"ocs3gDylj"];
            int c=[kdfzrb intValue];
            [md setValue:[NSNumber numberWithInt:c] forKey:@"ocs3gDylj"];
            
            NSString *zdywKdcjdylj=[dd objectForKey:@"kdDylj"];
            int d=[zdywKdcjdylj intValue];
            [md setValue:[NSNumber numberWithInt:d] forKey:@"kdDylj"];
            
            NSString *a2g3gfz=[dd objectForKey:@"kdcDylj"];
            int e=[a2g3gfz intValue];
            [md setValue:[NSNumber numberWithInt:e] forKey:@"kdcDylj"];
            
            NSString *zdywKdcjdylj1=[dd objectForKey:@"g2g3dylj"];
            int f=[zdywKdcjdylj1 intValue];
            [md setValue:[NSNumber numberWithInt:f] forKey:@"g2g3dylj"];
            
            NSString *a2g3gfz1=[dd objectForKey:@"g4dylj"];
            int g=[a2g3gfz1 intValue];
            [md setValue:[NSNumber numberWithInt:g] forKey:@"g4dylj"];
            
            
            [newArr addObject:md];
            [md release];
            
        }
        
        
    }
    return newArr ;
}



-(NSMutableArray*)sort:(NSMutableArray*)arr {
    NSMutableArray *amarr=[self transDataType:arr];
    
    NSString *sortByCol=@"";
    
    if (amarr!=nil && amarr.count>0) {
        //如果有‘合计’项，则把合计剔除，然后按照 ‘当月累计’从高到低排序
        NSDictionary *d=arr[arr.count-1];
        
        if (reportFlag==nil ||[@"ptw2g" isEqualToString:reportFlag]) {
            sortByCol=@"pt2gDylj";
        }else if([@"ptw3g" isEqualToString:reportFlag]){
            sortByCol=@"pt3gDylj";
        }else if([@"ocs3g" isEqualToString:reportFlag]){
            sortByCol=@"ocs3gDylj";
        }else if([@"kd" isEqualToString:reportFlag]){
            sortByCol=@"kdDylj";
        }else if([@"kdc" isEqualToString:reportFlag]){
            sortByCol=@"kdcDylj";
        }else if([@"2g3grh" isEqualToString:reportFlag]){
            sortByCol=@"g2g3dylj";
        }else if([@"4g" isEqualToString:reportFlag]){
            sortByCol=@"g4dylj";
        }
        
        
        NSSortDescriptor *descripor=[[NSSortDescriptor alloc] initWithKey:sortByCol ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&descripor count:1];
        
        [amarr sortUsingDescriptors:sortDescriptors];
        
        [amarr addObject:d];
        
        [descripor release];
        [sortDescriptors release];
        return amarr;
    }else{
        return arr;
    }
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

-(void)initData:(NSString*)adate{
    
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=xyrb4sqwgzdywrb"] autorelease];
    
    NSMutableDictionary* requestData = [[NSMutableDictionary alloc] init];
    [requestData setObject:adate forKey:@"date"];
    [requestData setObject:[DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserId forKey:@"staffId"];
    [aSIHTTPRequestUtils requestData:subUrl data:requestData action:@selector(doAfterinitData:) isShowProcessBar:YES];
    [requestData  release];
    
}

-(void)initSwitchButton{
    [self.switch2fButton setTitle:@"2G(含OCS)" forState:UIControlStateNormal];
    [self.swith3gButton setTitle:@"普通网3G" forState:UIControlStateNormal];
    [self.switchocs3gButton setTitle:@"OCS3G" forState:UIControlStateNormal];
    [self.switchkdButton setTitle:@"宽带装" forState:UIControlStateNormal];
    [self.switchkdcButton setTitle:@"宽带拆" forState:UIControlStateNormal];
    [self.switch2g3gButton setTitle:@"2G3G融合" forState:UIControlStateNormal];
    [self.switch4gButton setTitle:@"4G" forState:UIControlStateNormal];
    [self setSwitchButtonStyle:self.switch2fButton];
    [self setSwitchButtonStyle:self.swith3gButton];
    [self setSwitchButtonStyle:self.switchocs3gButton];
    [self setSwitchButtonStyle:self.switchkdButton];
    [self setSwitchButtonStyle:self.switchkdcButton];
    [self setSwitchButtonStyle:self.switch2g3gButton ];
    [self setSwitchButtonStyle:self.switch4gButton ];
    
    
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
       // if(reportFlag==nil || [reportFlag isEqualToString:@"2gfzrb"] || [reportFlag isEqualToString:@"3gfzrb"]){
            [self initTableTitle42g3g];
//        }else{
//            [self initTableTitle4kdfz];
//        }
        self.reslist=list;
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
            if([reportFlag isEqualToString:@"ptw2g"] || reportFlag==nil){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"pt2gRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"pt2gDylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"pt2gSytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"pt2gZzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"ptw3g"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"pt3gRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"pt3gDylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"pt3gSytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"pt3gZzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"ocs3g"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"ocs3gRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"ocs3gDylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"ocs3gSytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"ocs3gZzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"2g3grh"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"g2g3rfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"g2g3dylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"g2g3sytq"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"g2g3zzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"4g"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"g4rfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"g4dylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"g4sytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"g4zzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"kd"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"kdRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"kdDylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"kdSytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"kdZzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"kdc"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"kdcRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"kdcDylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"kdcSytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"kdcZzs"];
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
    //[self.view addSubview:view];
    [self.view insertSubview:view atIndex:0];
    [view release];
    
    
}


-(void)setDefaultSwitchImage:(UIButton*)btn{
    for(UIView *view in self.scroll_view.subviews){
        NSLog(@"tagtagtagtag%d",view.tag);
        if(view.tag>=200 && view.tag<=207){
            if(view.tag!=btn.tag+200){
                [view setHidden:YES];
            }else{
                [view setHidden:NO];
            }
            
        }
    }
}





-(void)setcurrentSwitchStyle:(UIButton*) button{
    for(UIView *view in self.scroll_view.subviews){
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
        reportFlag=@"ptw2g";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }else if(sender.tag==1){
        reportFlag=@"ptw3g";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }else if(sender.tag==2){
        reportFlag=@"ocs3g";
        col=5;
        tableviewy=96;
        [self initTableTitle42g3g];
    }else if(sender.tag==3){
        reportFlag=@"2g3grh";
        col=5;
        tableviewy=96;
        [self initTableTitle42g3g];
    }else if(sender.tag==4){
        reportFlag=@"4g";
        col=5;
        tableviewy=96;
        [self initTableTitle42g3g];
    }
    else if(sender.tag==5){
        reportFlag=@"kd";
        col=5;
        tableviewy=96;
        [self initTableTitle42g3g];
    }else if(sender.tag==6){
        reportFlag=@"kdc";
        col=5;
        tableviewy=96;
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
    labeldq.text = @"网格名称";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(53, 60, 68, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"日发展";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(122, 60, 67, 23);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"当月累计";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(190, 60, 81, 23);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"上月同期累计";
    [self setLabelStyle:labelsytqlj];
    
    CGRect rectzzs = CGRectMake(272, 60, 49, 23);
    UILabel *labelzzs = [[UILabel alloc] initWithFrame:rectzzs];
    labelzzs.tag=104;
    labelzzs.text = @"增长数";
    [self setLabelStyle:labelzzs];
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelsytqlj];
    [self.view addSubview:labelzzs];
    
    // [super viewDidLoad];
    
}

-(void)initTableTitle4kdfz{
    [self removeTitle];//删除原来表头，重建表头
    CGRect rectdq = CGRectMake(0, 60, 42, 34);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=100;
    labeldq.text = @"地区";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(43, 60, 45, 34);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"日发展";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(89, 60, 45, 34);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"当月累计";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(135, 60, 45, 34);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"上月同期累计";
    [self setLabelStyle:labelsytqlj];
    
    CGRect rectzzs = CGRectMake(181, 60, 45, 34);
    UILabel *labelzzs = [[UILabel alloc] initWithFrame:rectzzs];
    labelzzs.tag=104;
    labelzzs.text = @"增长数";
    [self setLabelStyle:labelzzs];
    
    CGRect rectqnljfz = CGRectMake(227, 60, 45, 34);
    UILabel *labelqnljfz = [[UILabel alloc] initWithFrame:rectqnljfz];
    labelqnljfz.tag=105;
    labelqnljfz.text = @"去年累计发展";
    [self setLabelStyle:labelqnljfz];
    
    CGRect rectjnljfz = CGRectMake(273, 60, 45, 34);
    UILabel *labeljnljfz = [[UILabel alloc] initWithFrame:rectjnljfz];
    labeljnljfz.tag=106;
    labeljnljfz.text = @"今年累计发展";
    [self setLabelStyle:labeljnljfz];
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelzzs];
    [self.view addSubview:labelsytqlj];
    [self.view addSubview:labelqnljfz];
    [self.view addSubview:labeljnljfz];
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
        [super setWrapTitle:@"商企网格重点业务日报" date:selectDate];
        NSLog(@"selectDateselectDate%@",selectDate);
        //self.myDateLabel.text = selectDate;
        [self initData:selectDate];
        [self removePickerView:nil];
        //_dateTag = YES;
    }
}


- (void)dealloc {
    [aSIHTTPRequestUtils release];
    [reslist release];
    [_switch2fButton release];
    [_swith3gButton release];
    [_switchkdButton release];
    [_switchocs3gButton release];
    [_whickReportFlag release];
    [_scroll_view release];
    [_switch2g3gButton release];
    [_switch4gButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    
    [self setScroll_view:nil];
    [super viewDidUnload];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
