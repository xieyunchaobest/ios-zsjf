//
//  HSRB43GYWViewController.m
//  zsjf
//
//  Created by xieyunchao on 13-11-17.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "HSRB43GYWViewController.h"
#import "CustomTableView.h"
#import "DateUtils.h"


@interface HSRB43GYWViewController ()

@end

@implementation HSRB43GYWViewController
@synthesize aSIHTTPRequestUtils;
@synthesize reslist;
@synthesize options = _options;

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
    //self.title=@"3G业务日报";
    col=5;
    reportFlag=@"pt3g";//2g发展日报
    showwgFlag=YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(showActionSheet)];
    
    
    [self initSwitchButton];
    [self setcurrentSwitchStyle:self.switchcommon3gButton];
    
    self.pickerView.frame = CGRectMake(0, 480, 320, 300);
    
    //默认显示呼市当天数据
    _reqdic = [[NSMutableDictionary alloc] init];
    NSString *date=[DateUtils getYesterdayStr];
    [super setWrapTitle:@"3G业务日报" date:date];
    [_reqdic setObject:date forKey:@"date"];
    //[_reqdic setObject:@"呼市" forKey:@"dq"];
    
    [self initData:_reqdic];
    [self initToolBar4zsjf];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"筛选条件"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"选择地区", @"选择日期",nil];
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

-(void)initData:(NSMutableDictionary*) requestDic {
    if (showwgFlag==YES) {
        [requestDic setObject:@"ANY" forKey:@"showwgFlag"];
    }
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=hsrb43gyw"] autorelease];
    [aSIHTTPRequestUtils requestData:subUrl data:requestDic action:@selector(doAfterinitData:) isShowProcessBar:YES];
}

-(void)initSwitchButton{
    [self.switchcommon3gButton setTitle:@"普通3G" forState:UIControlStateNormal];
    [self.swithocs3gButton setTitle:@"OCS3G" forState:UIControlStateNormal];
    
    [self setSwitchButtonStyle:self.switchcommon3gButton];
    [self setSwitchButtonStyle:self.swithocs3gButton]; 
    
    
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
    NSMutableArray *muarr=[[NSMutableArray alloc] init];
    //解析服务器返回数据
    if (responseData!=nil) {
        NSDictionary* list = [DataProcess getNSDictionaryFromNSData:responseData];
        [self initTableTitle4kdfz];
        self.reslist=list;
        [self initwgList:list];
    }
    
    NSMutableArray* array=[self.reslist objectForKey:@"list"];
    
    if([reportFlag isEqualToString:@"pt3g"]){
        for (NSDictionary *dic in array) {
            NSString *bz=[dic objectForKey:@"t3grbBz"];
            if([bz isEqualToString:@"0"]){
                [muarr addObject:dic];
            }
        }
    }else{
        for (NSDictionary *dic in array) {
            NSString *bz=[dic objectForKey:@"t3grbBz"];
            if([bz isEqualToString:@"1"]){
                [muarr addObject:dic];
            }
        }
    }
    
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
    for (int i = 0; i < [muarr  count]; i ++) {//行数
        NSDictionary* vo=muarr[i];
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:0];
        for (NSString *key in trDict) {
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"t3grbHbt"];
                }else if([key isEqualToString:@"1"]){
                    rfa=[vo objectForKey:@"t3grbRfz"];
                }else if([key isEqualToString:@"2"]){
                    rfa=[vo objectForKey:@"t3grbByfz"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"t3grbSytq"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"t3grbZzs"];
                }
                [data setValue:rfa forKey:key]; 
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
    frame.origin = CGPointMake(0, 94);
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    [muarr release];
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
        reportFlag=@"pt3g";
        col=5;
        [self initTableTitle4kdfz];
    }else if(sender.tag==1){
        reportFlag=@"ocs3g";
        col=5;
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


-(void)initTableTitle4kdfz{
    [self removeTitle];//删除原来表头，重建表头
    CGRect rectdq = CGRectMake(0, 60, 52, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=100;
    labeldq.text = @"业务";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfa = CGRectMake(53, 60, 68, 23);
    UILabel *labelrfz0 = [[UILabel alloc] initWithFrame:rectrfa];
    labelrfz0.tag=100;
    labelrfz0.text = @"日发展";
    [self setLabelStyle:labelrfz0];
    
    
    CGRect rectrfz = CGRectMake(122, 60, 67, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"本月发展";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(190, 60, 81, 23);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"上月发展";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(272, 60, 49, 23);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"增长数";
    [self setLabelStyle:labelsytqlj];
    
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz0];
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
        NSLog(@"selectDateselectDate%@",selectDate);
         [_reqdic setObject:selectDate forKey:@"date"];
        [super setWrapTitle:@"3G业务日报" date:selectDate];
        [self initData:_reqdic];
        [self removePickerView:nil];
    }
}


- (void)showListView {
   

    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"选择地区" options:self.options handler:^(NSInteger anIndex) {
        //infoLabel.text = [NSString stringWithFormat:@"You have selected %@", _dq_options[anIndex]];
        NSDictionary* dqdic=_options[anIndex];
        NSString* dq=[dqdic objectForKey:@"diqu"];
        NSLog(@"vvvvvvvvv%@",_options[anIndex]);
        [_reqdic setObject:dq forKey:@"dq"];
        [self initData:_reqdic];

    }];
    //lplv.delegate = self;
    [lplv showInView:self.view animated:YES];
}

#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex {
    //_infoLabel.text = [NSString stringWithFormat:@"You have selected %@",_dq_options[anIndex]];
}
- (void)leveyPopListViewDidCancel {
    //_infoLabel.text = @"You have cancelled";
}

- (void)dealloc {
    [aSIHTTPRequestUtils release];
    [reslist release];
    [_switchcommon3gButton release];
    [_swithocs3gButton release];
    [_whickReportFlag release];
    [_reqdic release];
    [super dealloc];
}



@end
