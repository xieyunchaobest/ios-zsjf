//
//  ViewController.m
//  Custom
//
//  Created by tan on 13-1-22.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "ReportTableViewController.h"
#import "CustomTableView.h"
#import "DateUtils.h"
#import "G2YWRBViewController.h"

@interface G2YWRBViewController ()

@end

@implementation G2YWRBViewController
@synthesize aSIHTTPRequestUtils;
@synthesize reslist;

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.title=@"重点业务发展日报";
    col=5;
    tableviewy=84;
    reportFlag=@"2gfzrb";//2g发展日报
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStylePlain target:self action:@selector(showDateSelectView)];
    [self initSwitchButton];
    [self setcurrentSwitchStyle:self.switchCommon2GButton];
    
    self.datepickerView.frame = CGRectMake(0, 480, 320, 300);
    
    NSString *date=[DateUtils getCurrentStrDate];
    
    [self initData:date];
}



-(void)showDateSelectView{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    CGRect mainBounds = [[UIScreen mainScreen] bounds];
    self.datepickerView.frame = CGRectMake(0, mainBounds.size.height-300, 320, 300);
    [self.myDatePicker setDate:[DateUtils getYesterday]];
    self.myDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.datepickerView];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
}

-(void)initData:(NSString*)adate{
    
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=zdywfzrb"] autorelease];
    NSMutableDictionary* requestData = [[NSMutableDictionary alloc] init];
    [requestData setObject:adate forKey:@"date"];
    [aSIHTTPRequestUtils requestData:subUrl data:requestData action:@selector(doAfterinitData:) isShowProcessBar:YES];
    [requestData  release];
    
    
    
}

-(void)initSwitchButton{
    [self.switchCommon2GButton setTitle:@"普通网络2G" forState:UIControlStateNormal];
    [self.swithOCS2GButton setTitle:@"OCS2G" forState:UIControlStateNormal];
    [self setSwitchButtonStyle:self.switchCommon2GButton];
    [self setSwitchButtonStyle:self.switchCommon2GButton];
    
    
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
    NSString* aStr;
    aStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    self.textView.text=aStr;
    
    //解析服务器返回数据
    if (responseData!=nil) {
        NSDictionary* list = [DataProcess getNSDictionaryFromNSData:responseData];
        if(reportFlag==nil || [reportFlag isEqualToString:@"2gfzrb"] || [reportFlag isEqualToString:@"3gfzrb"]){
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
    
    NSMutableArray *dArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < [array  count]; i ++) {//行数
        NSDictionary* vo=array[i];
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:0];
        for (NSString *key in trDict) {
            if([reportFlag isEqualToString:@"2gfzrb"] || reportFlag==nil){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"zdywQy"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"zdyw2grfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"zdyw2gylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"zdyw2gsytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"zdyw2gzzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"3gfzrb"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"zdywQy"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"zdyw3grfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"zdyw3gylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"zdyw2gsytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"zdyw3gzzs"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"kdfzrb"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"zdywQy"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"zdywKdrqz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"zdywKdylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"zdywKdsytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"zdywKdzzs"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"zdywKdqnljfz"];
                }else if([key isEqualToString:@"6"]){
                    rfa=[vo objectForKey:@"zdywKdjnljfz"];
                }
                [data setValue:rfa forKey:key];
            }else if([reportFlag isEqualToString:@"kdcjrb"]){
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"zdywQy"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"zdywKdcjrcj"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"zdywKdcjdylj"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"zdywKdcjsytqlj"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"zdywKdcjzzs"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"zdywKdcjqnljs"];
                }else if([key isEqualToString:@"6"]){
                    rfa=[vo objectForKey:@"zdywKdcjjnljs"];
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
    //frame.origin = CGPointMake(0, tableviewy);
    frame.origin = CGPointMake(0, 200);
    view.frame = frame;
    [self.view addSubview:view];
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
        reportFlag=@"2gfzrb";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }else if(sender.tag==1){
        reportFlag=@"3gfzrb";
        col=5;
        tableviewy=84;
        [self initTableTitle42g3g];
    }else if(sender.tag==2){
        reportFlag=@"kdfzrb";
        col=7;
        tableviewy=96;
        [self initTableTitle4kdfz];
    }else if(sender.tag==3){
        reportFlag=@"kdcjrb";
        col=7;
        tableviewy=96;
        [self initTableTitle4kdfz];
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
    labeldq.text = @"地区";
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
    label.backgroundColor = [UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0];    //label.backgroundColor = [UIColor redColor];
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
    self.datepickerView.frame = CGRectMake(0, mainBounds.size.height, 320, 300);
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
        //self.myDateLabel.text = selectDate;
        [self initData:selectDate];
        [self removePickerView:nil];
        //_dateTag = YES;
    }
}


- (void)dealloc {
    [aSIHTTPRequestUtils release];
    [reslist release];
    [_switchCommon2GButton release];
    [_swithOCS2GButton release]; 
    [super dealloc];
}
- (void)viewDidUnload {
    
    [super viewDidUnload];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
