//
//  ViewController.m
//  Custom
//
//  Created by tan on 13-1-22.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "Xyrb4XywgzdywViewController.h"
#import "CustomTableView.h"
#import "DateUtils.h"
#import "HomePageViewController.h"
#import "dayReportViewController.h"

@interface Xyrb4XywgzdywViewController ()

@end

@implementation Xyrb4XywgzdywViewController
@synthesize aSIHTTPRequestUtils;
@synthesize reslist;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(![StringUtils isBlankString:self.fromPageFlag]){
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.hidesBackButton=YES;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //self.edgesForExtendedLayout = UIExtendedEdgeNone;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }

    col=5;
    tableviewy=84;
    reportFlag=@"2gfzrb";//2g发展日报
   
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStylePlain target:self action:@selector(showDateSelectView)];
    [self initSwitchButton];
    [self setcurrentSwitchStyle:self.switch2fButton];
    
     self.pickerView.frame = CGRectMake(0, 480, 320, 300);
    

    NSString *date=[DateUtils getYesterdayStr];
    [self initData:date];
    
    [super setWrapTitle:@"校园网格重点业务日报" date:date];

    self.scroll_view.contentSize=CGSizeMake(500,
                                            46);
    [self.scroll_view setScrollEnabled:YES];
    
    //[self initToolBarItem];
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

-(void)initData:(NSString*)adate{
    
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=xyrb4xywgzdywrb"] autorelease];

    NSMutableDictionary* requestData = [[NSMutableDictionary alloc] init];
    [requestData setObject:adate forKey:@"date"];
    [aSIHTTPRequestUtils requestData:subUrl data:requestData action:@selector(doAfterinitData:) isShowProcessBar:YES];
    [requestData  release];
    
    

}

-(void)initSwitchButton{
    [self.switch2fButton setTitle:@"普通2G" forState:UIControlStateNormal];
    [self.swith3gButton setTitle:@"OCS2G" forState:UIControlStateNormal];
    [self.swith4gButton setTitle:@"3G" forState:UIControlStateNormal];
    [self.switchkdinstallButton setTitle:@"4G" forState:UIControlStateNormal];
    [self.switchunistallButton setTitle:@"OCS3G" forState:UIControlStateNormal];
    [self.switch2g2gButton setTitle:@"2G3G" forState:UIControlStateNormal];
    [self setSwitchButtonStyle:self.switch2fButton];
    [self setSwitchButtonStyle:self.swith3gButton];
    [self setSwitchButtonStyle:self.swith4gButton];
    [self setSwitchButtonStyle:self.switchkdinstallButton];
    [self setSwitchButtonStyle:self.switchunistallButton];
    [self setSwitchButtonStyle:self.switch2g2gButton];
    

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
        if(reportFlag==nil || [reportFlag isEqualToString:@"2gfzrb"] || [reportFlag isEqualToString:@"3gfzrb"] || [reportFlag isEqualToString:@"4gfzrb"] || [reportFlag isEqualToString:@"2g3gfz"]
           ){
             [self initTableTitle42g3g];
        }else{
            [self initTableTitle4kdfz];
        }
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
            if([reportFlag isEqualToString:@"2gfzrb"] || reportFlag==nil){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"pt2gRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"pt2gDylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"pt2gSytq"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"pt2gZzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"3gfzrb"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"ocs2gRxs"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"ocs2gRjh"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"ocs2gDyljsx"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"ocs2gSyljjh"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"4gfzrb"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"pt3gRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"pt3gDylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"pt3gSytq"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"pt3gZzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"kdfzrb"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"pt4gRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"pt4gDgyl"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"pt4gSytq"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"pt4gZzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"kdcjrb"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"ocs3gRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"ocs3gDylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"ocs3gSytq"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"ocs3gZzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"2g3gfz"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"rh2g3gRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"rh2g3gDylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"rh2g3gSytq"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"rh2g3gZzs"];
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
        NSDictionary *d=arr[arr.count-1];
      
        if (reportFlag==nil ||[@"2gfzrb" isEqualToString:reportFlag]) {
            sortByCol=@"zdyw2gylj";
        }else if([@"3gfzrb" isEqualToString:reportFlag]){
              sortByCol=@"zdyw3gylj";
        }else if([@"4gfzrb" isEqualToString:reportFlag]){
            sortByCol=@"zdyw4gylj";
        }else if([@"kdfzrb" isEqualToString:reportFlag]){
              sortByCol=@"zdywKdylj";
        }else if([@"kdcjrb" isEqualToString:reportFlag]){
            sortByCol=@"zdywKdcjdylj";
        }else if([@"2g3gfz" isEqualToString:reportFlag]){
            sortByCol=@"zdyw2g3gylj";
        }
        
        
        NSSortDescriptor *descripor=[[NSSortDescriptor alloc] initWithKey:sortByCol ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&descripor count:1];
        
        [amarr sortUsingDescriptors:sortDescriptors];
        
     //   [amarr addObject:d];
        
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
    for(UIView *view in self.scroll_view.subviews){
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
        reportFlag=@"2gfzrb";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }else if(sender.tag==1){
        reportFlag=@"3gfzrb";
        col=5;
        tableviewy=84;
        [self initTableTitle4kdfz];
    }else if(sender.tag==2){
        reportFlag=@"4gfzrb";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }else if(sender.tag==4){
        reportFlag=@"kdfzrb";
        col=5;
        tableviewy=96;
        [self initTableTitle42g3g];
    }else if(sender.tag==5){
        reportFlag=@"kdcjrb";
        col=5;
        tableviewy=96;
        [self initTableTitle42g3g];
    }else if(sender.tag==3){
        reportFlag=@"2g3gfz";
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
    CGRect rectdq = CGRectMake(0, 60, 52, 34);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=100;
    labeldq.text = @"网格名称";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(53, 60, 68, 34);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"销售";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(122, 60, 67, 34);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"日激活";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(190, 60, 81, 34);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"当月累计销售";
    [self setLabelStyle:labelsytqlj];
    
    CGRect rectzzs = CGRectMake(272, 60, 49, 34);
    UILabel *labelzzs = [[UILabel alloc] initWithFrame:rectzzs];
    labelzzs.tag=104;
    labelzzs.text = @"当月累计激活";
    [self setLabelStyle:labelzzs];
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelzzs];
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
        NSLog(@"selectDateselectDate%@",selectDate);
        [super setWrapTitle:@"校园网格重点业务日报" date:selectDate];
      
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
    [_switchkdinstallButton release];
    [_switchunistallButton release];
    [_whickReportFlag release];
    [_fromPageFlag release];
    [_swith4gButton release];
    [_scroll_view release];
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
