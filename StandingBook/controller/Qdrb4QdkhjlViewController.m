//
//  HSRB43GYWViewController.m
//  zsjf
//渠道日报-渠道客户经理日报
//  Created by xieyunchao on 13-11-17.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "Qdrb4QdkhjlViewController.h"
#import "CustomTableView.h"
#import "DateUtils.h"


@interface Qdrb4QdkhjlViewController ()

@end

@implementation Qdrb4QdkhjlViewController
@synthesize aSIHTTPRequestUtils;
@synthesize reslist;
@synthesize options = _options;
@synthesize optionsOther = _optionsOther;

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
    //self.title=@"客户经理揽装日报";
    col=7;
    reportFlag=@"2g";//2g发展日报
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(showActionSheet)];
    
    
    [self initSwitchButton];
    [self setcurrentSwitchStyle:self.switch2gButton];
    
    self.pickerView.frame = CGRectMake(0, 480, 320, 300);
    
    //默认显示呼市当天数据
    _reqdic = [[NSMutableDictionary alloc] init];
    NSString *date=[DateUtils getYesterdayStr];
    [super setWrapTitle:@"渠道客户经理日报" date:date];
    [_reqdic setObject:date forKey:@"date"];
    [_reqdic setObject:[DataProcess getSysUserExtendedMVO].sysUserSVO.sysUserId forKey:@"staffId"];
    
    showwgFlag=YES;
    //[_reqdic setObject:@"呼市" forKey:@"dq"];
    
    [self initData:_reqdic];
    [self initToolBar4zsjf];
    
    // Do any additional setup after loading the view from its nib.
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
            
            NSString *ocsg2s=[dd objectForKey:@"ocs2gDyljsx"];
            int b=[ocsg2s intValue];
            [md setValue:[NSNumber numberWithInt:b] forKey:@"ocs2gDyljsx"];
            
            
            NSString *g3s=[dd objectForKey:@"pt3gDylj"];
            int c=[g3s intValue];
            [md setValue:[NSNumber numberWithInt:c] forKey:@"pt3gDylj"];
            
            NSString *ocs3g=[dd objectForKey:@"ocs3gDylj"];
            int d=[ocs3g intValue];
            [md setValue:[NSNumber numberWithInt:d] forKey:@"ocs3gDylj"];
            
            NSString *g4=[dd objectForKey:@"pt4gDgyl"];
            int e=[g4 intValue];
            [md setValue:[NSNumber numberWithInt:e] forKey:@"pt4gDgyl"];

            
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
        
        if (reportFlag==nil ||[@"2g" isEqualToString:reportFlag]) {
            sortByCol=@"pt2gDylj";
        }else if([@"ocs2g" isEqualToString:reportFlag]){
            sortByCol=@"ocs2gDyljsx";
        }else if([@"3g" isEqualToString:reportFlag]){
            sortByCol=@"pt3gDylj";
        }else if([@"ocs3g" isEqualToString:reportFlag]){
            sortByCol=@"ocs3gDylj";
        }else if([@"4g" isEqualToString:reportFlag]){
            sortByCol=@"pt4gDgyl";
        }
        
        NSSortDescriptor *descripor=[[NSSortDescriptor alloc] initWithKey:sortByCol ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&descripor count:1];
        
        [amarr sortUsingDescriptors:sortDescriptors];
        
       // [amarr addObject:d];
        
        [descripor release];
        [sortDescriptors release];
        return amarr;
    }else{
        return arr;
    }
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
                                  otherButtonTitles:@"选择网格", @"选择客户经理",@"选择日期",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self showListView];
        NSLog(@"xxxxxxxxxxxx");
    }else if (buttonIndex==1){
         [self showListView4khjl];
    }else if (buttonIndex==2){
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
    
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=rtb4qdkhjlrb"] autorelease];
    [aSIHTTPRequestUtils requestData:subUrl data:requestDic action:@selector(doAfterinitData:) isShowProcessBar:YES];
   
}

//初始化网格列表，用于展示查询条件
-(void)initwgList:(NSDictionary*) dic{
    if(showwgFlag==YES){
        //初始化并关闭开关
         NSMutableArray* array=[self.reslist objectForKey:@"wglist"];
        self.options=array;
        
        NSMutableArray* array1=[self.reslist objectForKey:@"khjllist"];
        self.optionsOther=array1;
        
        showwgFlag=NO;
        [_reqdic setObject:@"" forKey:@"showwgFlag"];
    }
}

-(void)initSwitchButton{
    [self.switch2gButton setTitle:@"普通2G" forState:UIControlStateNormal];
    [self.switchocs2gButton setTitle:@"OCS2G" forState:UIControlStateNormal];
    [self.switch3gButton setTitle:@"3G" forState:UIControlStateNormal];
    [self.switchocs3gButton setTitle:@"OCS3G" forState:UIControlStateNormal];
    [self.switch4gButton setTitle:@"4G" forState:UIControlStateNormal];
    
    
    [self setSwitchButtonStyle:self.switch2gButton];
    [self setSwitchButtonStyle:self.switch3gButton];
    [self setSwitchButtonStyle:self.switch4gButton];
    [self setSwitchButtonStyle:self.switchocs2gButton];
    [self setSwitchButtonStyle:self.switchocs3gButton];
    
    
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
        self.reslist=list;
        [self initwgList:list];
        if(reportFlag==nil || [reportFlag isEqualToString:@"2g"] || [reportFlag isEqualToString:@"3g"]||[reportFlag isEqualToString:@"4g"]){
            [self initTableTitle4hdgh];
        }else{
            [self initTableTitle4hdgh];
        }
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
        if([reportFlag isEqualToString:@"2g"] || reportFlag==nil){
            for (NSString *key in trDict) {
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]    ){
                    rfa=[vo objectForKey:@"khjlMc"];
                }else if([key isEqualToString:@"2"]    ){
                    rfa=[vo objectForKey:@"wdMc"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"pt2gRfz"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"pt2gDylj"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"pt2gSytq"];
                }else if([key isEqualToString:@"6"]){
                    rfa=[vo objectForKey:@"pt2gZzs"];
                }
                [data setValue:rfa forKey:key];
            }
        }else if(([reportFlag isEqualToString:@"ocs2g"])){
            for (NSString *key in trDict) {
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]    ){
                    rfa=[vo objectForKey:@"khjlMc"];
                }else if([key isEqualToString:@"2"]    ){
                    rfa=[vo objectForKey:@"wdMc"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"ocs2gRxs"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"ocs2gRjh"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"ocs2gDyljsx"];
                }else if([key isEqualToString:@"6"]){
                    rfa=[vo objectForKey:@"ocs2gSyljjh"];
                }
                [data setValue:rfa forKey:key];
            }
        }else if(([reportFlag isEqualToString:@"3g"])){
            for (NSString *key in trDict) {
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]    ){
                    rfa=[vo objectForKey:@"khjlMc"];
                }else if([key isEqualToString:@"2"]    ){
                    rfa=[vo objectForKey:@"wdMc"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"pt3gRfz"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"pt3gDylj"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"pt3gSytq"];
                }else if([key isEqualToString:@"6"]){
                    rfa=[vo objectForKey:@"pt3gZzs"];
                }
                [data setValue:rfa forKey:key];
            }
        }
        else if(([reportFlag isEqualToString:@"ocs3g"])){
            for (NSString *key in trDict) {
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]    ){
                    rfa=[vo objectForKey:@"khjlMc"];
                }else if([key isEqualToString:@"2"]    ){
                    rfa=[vo objectForKey:@"wdMc"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"ocs3gRfz"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"ocs3gDylj"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"ocs3gSytq"];
                }else if([key isEqualToString:@"6"]){
                    rfa=[vo objectForKey:@"ocs3gZzs"];
                }
                [data setValue:rfa forKey:key];
            }
        }else{
            for (NSString *key in trDict) {
                NSString * rfa=@"";
                if([key isEqualToString:@"0"]){
                    rfa=[vo objectForKey:@"wgMc"];
                }else if([key isEqualToString:@"1"]    ){
                    rfa=[vo objectForKey:@"khjlMc"];
                }else if([key isEqualToString:@"2"]    ){
                    rfa=[vo objectForKey:@"wdMc"];
                }else if([key isEqualToString:@"3"]){
                    rfa=[vo objectForKey:@"pt4gRfz"];
                }else if([key isEqualToString:@"4"]){
                    rfa=[vo objectForKey:@"pt4gDgyl"];
                }else if([key isEqualToString:@"5"]){
                    rfa=[vo objectForKey:@"pt4gSytq"];
                }else if([key isEqualToString:@"6"]){
                    rfa=[vo objectForKey:@"pt4gZzs"];
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
    frame.origin = CGPointMake(0, 94);
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
        reportFlag=@"2g";
        col=7;
        [self initTableTitle4hdgh];
    }else if(sender.tag==1){
        reportFlag=@"ocs2g";
        col=7;
        [self initTableTitle4hdgh];
    }else if(sender.tag==2){
        reportFlag=@"3g";
        col=7;
        [self initTableTitle4hdgh];
    }else if(sender.tag==3){
        reportFlag=@"ocs3g";
        col=7;
        [self initTableTitle4hdgh];
    }else if(sender.tag==4){
        reportFlag=@"4g";
        col=7;
        [self initTableTitle4hdgh];
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


-(void)initTableTitle42g3g{
    [self removeTitle];//删除原来表头，重建表头
    CGRect rectdq = CGRectMake(0, 60, 79, 23);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=100;
    labeldq.text = @"部门";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(80, 60, 79, 23);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"姓名";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(160, 60, 79, 23);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"当天发展";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(240, 60, 80, 23);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"当月累计发展";
    [self setLabelStyle:labelsytqlj];
    
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelsytqlj];
}

-(void)initTableTitle4hdgh{
    [self removeTitle];//删除原来表头，重建表头
    CGRect rectdq = CGRectMake(0, 60, 42, 34);
    UILabel *labeldq = [[UILabel alloc] initWithFrame:rectdq];
    labeldq.tag=100;
    labeldq.text = @"网格";
    [self setLabelStyle:labeldq];
    
    CGRect rectrfz = CGRectMake(43, 60, 45, 34);
    UILabel *labelrfz = [[UILabel alloc] initWithFrame:rectrfz];
    labelrfz.tag=101;
    labelrfz.text = @"客户经理";
    [self setLabelStyle:labelrfz];
    
    CGRect rectdylj = CGRectMake(89, 60, 45, 34);
    UILabel *labeldylj = [[UILabel alloc] initWithFrame:rectdylj];
    labeldylj.tag=102;
    labeldylj.text = @"网点";
    [self setLabelStyle:labeldylj];
    
    CGRect rectsytqlj = CGRectMake(135, 60, 45, 34);
    UILabel *labelsytqlj = [[UILabel alloc] initWithFrame:rectsytqlj];
    labelsytqlj.tag=103;
    labelsytqlj.text = @"日发展";
    [self setLabelStyle:labelsytqlj];
    
    CGRect rectzzs = CGRectMake(181, 60, 45, 34);
    UILabel *labelzzs = [[UILabel alloc] initWithFrame:rectzzs];
    labelzzs.tag=104;
    labelzzs.text = @"当月累计";
    [self setLabelStyle:labelzzs];
    
    CGRect rectqnljfz = CGRectMake(227, 60, 45, 34);
    UILabel *labelqnljfz = [[UILabel alloc] initWithFrame:rectqnljfz];
    labelqnljfz.tag=105;
    labelqnljfz.text = @"上月同期累计";
    [self setLabelStyle:labelqnljfz];
    
    CGRect rectjnljfz = CGRectMake(273, 60, 45, 34);
    UILabel *labeljnljfz = [[UILabel alloc] initWithFrame:rectjnljfz];
    labeljnljfz.tag=106;
    labeljnljfz.text = @"增长数";
    [self setLabelStyle:labeljnljfz];
    
    [self.view addSubview:labeldq];
    [self.view addSubview:labelrfz];
    [self.view addSubview:labeldylj];
    [self.view addSubview:labelzzs];
    [self.view addSubview:labelsytqlj];
    [self.view addSubview:labelqnljfz];
    [self.view addSubview:labeljnljfz];
    
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
        [super setWrapTitle:@"渠道客户经理日报" date:selectDate];
        NSLog(@"selectDateselectDate%@",selectDate);
        [_reqdic setObject:selectDate forKey:@"date"];
        [self initData:_reqdic];
        [self removePickerView:nil];
    }
}


- (void)showListView4khjl {
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"选择客户经理" options:_optionsOther handler:^(NSInteger anIndex) {
        //infoLabel.text = [NSString stringWithFormat:@"You have selected %@", _dq_options[anIndex]];
        NSDictionary* dqdic=_optionsOther[anIndex];
        NSString* dq=[dqdic objectForKey:@"diqu"];
        NSLog(@"vvvvvvvvv%@",_optionsOther[anIndex]);
        [_reqdic setObject:dq forKey:@"khjl"];
        [self initData:_reqdic];
        
    }];
    //lplv.delegate = self;
    [lplv showInView:self.view animated:YES];
}

- (void)showListView {
   /** _options = [NSArray arrayWithObjects:
                [NSDictionary dictionaryWithObjectsAndKeys:@"呼市",@"diqu", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"武川",@"diqu", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"和林",@"diqu", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"清水河",@"diqu", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"土左旗",@"diqu", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:@"托县",@"diqu", nil],
                nil];**/
    
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"选择网格" options:_options handler:^(NSInteger anIndex) {
        //infoLabel.text = [NSString stringWithFormat:@"You have selected %@", _dq_options[anIndex]];
        NSDictionary* dqdic=_options[anIndex];
        NSString* dq=[dqdic objectForKey:@"diqu"];
        NSLog(@"vvvvvvvvv%@",_options[anIndex]);
        [_reqdic setObject:dq forKey:@"diqu"];
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
    [_switch2gButton release];
    [_switch3gButton release];
    [_switchocs3gButton release];
    [_switchocs2gButton release];
    [_whickReportFlag release];
    [_switch4gButton release];
    [_reqdic release];
    [_options release];
    [_optionsOther release];
    [super dealloc];
}



@end
