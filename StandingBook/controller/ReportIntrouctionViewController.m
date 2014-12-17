//
//  ReportIntrouctionViewController.m
//  zsjf
//报表说明
//  Created by xieyunchao on 14-2-15.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import "ReportIntrouctionViewController.h"
#import "ReportIntrouctionDetailViewController.h"

@interface ReportIntrouctionViewController ()

@end

@implementation ReportIntrouctionViewController
@synthesize list;
@synthesize tableView;
@synthesize aSIHTTPRequestUtils;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.title=@"报表说明";
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self requestList];
    // Do any additional setup after loading the view from its nib.
//    NSArray *array = [[NSArray alloc] initWithObjects:@"美国", @"菲律宾",
//                      @"黄岩岛", @"中国", @"泰国", @"越南", @"老挝",
//                      @"日本" , nil];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.list = nil;
    
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
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [[self.list objectAtIndex:row] objectForKey:@"name"];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
    NSUInteger row = [indexPath row];
    NSDictionary *dic=[self.list objectAtIndex:row];
    ReportIntrouctionDetailViewController *g2V = [[ReportIntrouctionDetailViewController alloc] initWithNibName:@"ReportIntrouctionDetailViewController" bundle:nil];
    g2V.reportDic=dic;
    
    [self.navigationController pushViewController:g2V animated:YES];
    [g2V release];
    
    
}


@end
