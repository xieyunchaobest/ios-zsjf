//
//  HSRB42GYWViewController.m
//  zsjf
//
//  Created by xieyunchao on 13-11-18.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "HSYB4GJZB4GHViewController.h"
#import "CustomTableView.h"
#import "DateUtils.h"

@interface HSYB4GJZB4GHViewController ()

@end

@implementation HSYB4GJZB4GHViewController
@synthesize aSIHTTPRequestUtils;
@synthesize reslist;

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
    //self.title=@"固话关键指标";
    col=5;
    reportFlag=@"dyfz";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStylePlain target:self action:@selector(showDateSelectView)];
    
    
    [self initSwitchButton];
    [self setcurrentSwitchStyle:self.switchdyfzButton];
    
    self.pickerView.frame = CGRectMake(0, 480, 320, 300);
    
    //默认显示呼市当天数据
    _reqdic = [[NSMutableDictionary alloc] init];
    NSString *date=[DateUtils getLastMonthEndDayStr];
    [super setWrapTitle:@"固话关键指标" date:date];
    [_reqdic setObject:date forKey:@"date"];
    
    [self initData:_reqdic];
    [self initToolBar4zsjf];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showDateSelectView{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    CGRect mainBounds = [[UIScreen mainScreen] bounds];
    self.pickerView.frame = CGRectMake(0, mainBounds.size.height-300, 320, 300);
    [self.myDatePicker setDate:[DateUtils getLastMonthEndDay]];
    self.myDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.pickerView];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
}


-(void)initData:(NSMutableDictionary*) requestDic {
    
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=hsyb4gjzbyb"] autorelease];
    [aSIHTTPRequestUtils requestData:subUrl data:requestDic action:@selector(doAfterinitData:) isShowProcessBar:YES];
}

-(void)initSwitchButton{
    [self.switchdyfzButton setTitle:@"当月发展" forState:UIControlStateNormal];
    [self.switchczsrButton setTitle:@"出账收入" forState:UIControlStateNormal];
    [self.swithczyhsButton setTitle:@"出账用户数" forState:UIControlStateNormal];
    
    [self setSwitchButtonStyle:self.switchczsrButton];
    [self setSwitchButtonStyle:self.swithczyhsButton];
    [self setSwitchButtonStyle:self.switchdyfzButton];
    
}



//登录成功后执行方法
-(void) doAfterinitData:(NSData*)responseData {
    //解析服务器返回数据
    if (responseData!=nil) {
        NSDictionary* list = [DataProcess getNSDictionaryFromNSData:responseData];
        if ([reportFlag isEqualToString:@"dyfz"] || reportFlag==nil) {
            [self initTableTitle4dyfz];
        }else{
            [self initTableTitle4cz];
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
        if([reportFlag isEqualToString:@"dyfz"]){
            for (NSString *key in trDict) {
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"gjywytbQy"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"ghDyfzDy"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"ghDyfzSy"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"ghDyfzZzs"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"ghDyfzZzl"];
                }
                [data setValue:rfa forKey:key];
            }
        }else if([reportFlag isEqualToString:@"czsr"]){
            for (NSString *key in trDict) {
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"gjywytbQy"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"ghCzsrDy"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"ghCzsrSy"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"ghCzsrHbzzl"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"ghCzsrTbzzl"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"ghCzsrDbzzl"];
                }
                [data setValue:rfa forKey:key];
            }
        }else if([reportFlag isEqualToString:@"czyhs"]){
            for (NSString *key in trDict) {
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"gjywytbQy"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"ghCzyhsDy"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"ghCzyhsSy"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"ghCzyhsHbzzl"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"ghCzyhsTbzzl"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"ghCzyhsDbzzl"];
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
    frame.origin = CGPointMake(0, 84);
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
        reportFlag=@"dyfz";
        col=5;
        [self initTableTitle4dyfz];
    }else if(sender.tag==1){
        reportFlag=@"czsr";
        col=6;
        [self initTableTitle4cz];
    }else if(sender.tag==2){
        reportFlag=@"czyhs";
        col=6;
        [self initTableTitle4cz];
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


-(void)initTableTitle4dyfz{
    [self removeTitle];//删除原来表头，重建表头
    CGRect rectdq = CGRectMake(0, 60, 52, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=100;
    labeldq.text = @"区域";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(53, 60, 68, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"当月";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(122, 60, 67, 23);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"上月";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(190, 60, 81, 23);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"增长数";
    [self setLabelStyle:labelsytqlj];
    
    CGRect rectzzs = CGRectMake(272, 60, 49, 23);
    UILabel *labelzzs = [[UILabel alloc] initWithFrame:rectzzs];
    labelzzs.tag=104;
    labelzzs.text = @"增长率";
    [self setLabelStyle:labelzzs];
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelsytqlj];
    [self.view addSubview:labelzzs];
    
    // [super viewDidLoad];
    
}


-(void)initTableTitle4cz{
    [self removeTitle];//删除原来表头，重建表头
    CGRect rectdq = CGRectMake(0, 60, 55, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=100;
    labeldq.text = @"区域";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(56, 60, 52, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"当月";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(109, 60, 52, 23);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"上月";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(162, 60, 52, 23);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"环比增长率";
    [self setLabelStyle:labelsytqlj];
    
    CGRect rectzzs = CGRectMake(215, 60, 52, 23);
    UILabel *labelzzs = [[UILabel alloc] initWithFrame:rectzzs];
    labelzzs.tag=104;
    labelzzs.text = @"同比增长率";
    [self setLabelStyle:labelzzs];
    
    
    CGRect rectzzs1 = CGRectMake(268, 60, 52, 23);
    UILabel *labelzzs1 = [[UILabel alloc] initWithFrame:rectzzs1];
    labelzzs1.tag=104;
    labelzzs1.text = @"定比增长率";
    [self setLabelStyle:labelzzs1];
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelsytqlj];
    [self.view addSubview:labelzzs];
    [self.view addSubview:labelzzs1];
    
    // [super viewDidLoad];
    
}

-(void)setLabelStyle:(UILabel*)label{
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    // 设置字体颜色
    label.textColor = [UIColor whiteColor];
    // 设置背景色
    label.backgroundColor = [UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0];
    //label.backgroundColor = [UIColor redColor];
    // 文字换
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
        [self removePickerView:nil];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *selectDate =  [dateFormatter stringFromDate:select];
         [super setWrapTitle:@"固话关键指标" date:selectDate];
        NSLog(@"selectDateselectDate%@",selectDate);
        [_reqdic setObject:selectDate forKey:@"date"];
        [self initData:_reqdic];
        [self removePickerView:nil];
    }
}

- (void)dealloc {
    [aSIHTTPRequestUtils release];
    [reslist release];
    [_switchdyfzButton release];
    [_swithczyhsButton release];
    [_whickReportFlag release];
    [_reqdic release];
    [super dealloc];
}



-(void)setSwitchButtonStyle:(UIButton*) button{
    [button setTitleColor:[UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0]
                 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:240.0/255 green:108.0/255 blue:0.0/255 alpha:1.0]
                 forState:UIControlStateNormal];
    button.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    button.titleLabel.textAlignment=NSTextAlignmentCenter;
}






@end
