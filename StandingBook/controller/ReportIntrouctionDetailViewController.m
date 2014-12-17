//
//  ReportIntrouctionDetailViewController.m
//  zsjf
//报表说明详情
//  Created by xieyunchao on 14-2-15.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import "ReportIntrouctionDetailViewController.h"

@interface ReportIntrouctionDetailViewController ()

@end

@implementation ReportIntrouctionDetailViewController
@synthesize reportDic;
@synthesize aSIHTTPRequestUtils;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)requestList{
    aSIHTTPRequestUtils =[[ASIHTTPRequestUtils alloc] initWithHandleWithoutAutoRelease:self];
    NSString* subUrl=[[[NSString alloc] initWithString:@"tm/ZSJFAction.do?method=getReportIntrouctionList"] autorelease];
    NSMutableDictionary* requestData = [[NSMutableDictionary alloc] init];
    NSLog(@"Dictionary is : \n%@",requestData);
    [aSIHTTPRequestUtils requestData:subUrl data:requestData action:@selector(doAfterRequestList:) isShowProcessBar:YES];
    [requestData  release];
}

-(void)doAfterRequestList:(NSData*)jsonData{
    NSArray* kbArray = [DataProcess getArrayListFromNSData:jsonData];
    self.list = kbArray;
    if(self.list.count>0){
        NSDictionary *d=(NSDictionary*)self.list[0];
        NSString* res=[d objectForKey:@"introduction"];
        self.tvReportDetail.text=res;
    }
    //[self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.list = nil;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title=[reportDic objectForKey:@"name" ];
    self.title=@"报表说明";
    //self.tvReportDetail.text=[reportDic objectForKey:@"introduction" ];
    [self.tvReportDetail setEditable:NO];
    [self requestList];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
