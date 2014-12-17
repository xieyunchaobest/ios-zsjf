//
//  GCJGTJReportViewController.m
//  zsjf
//
//  Created by xieyunchao on 14-3-24.
//  Copyright (c) 2014年 Cattsoft. All rights reserved.
//

#import "GCJGTJReportViewController.h"
#import "GcjgtjCell.h"
#import "GCJSFilterViewController.h"
@interface GCJGTJReportViewController ()

@end

@implementation GCJGTJReportViewController
@synthesize  aSIHTTPRequestUtils;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(showFilterView)];
    _reqdic = [[NSMutableDictionary alloc] init];
    NSString *date=[DateUtils getYesterdayStr];
    [super setWrapTitle:@"工程竣工信息" date:date];
    [_reqdic setObject:@"" forKey:@"startDate"];
    [_reqdic setObject:@"" forKey:@"endDate"];
    self.tableView.delegate=self;
    
    [self requestData];
    
}


-(void)showFilterView{
    GCJSFilterViewController *g2V = [[GCJSFilterViewController alloc] initWithNibName:@"GCJSFilterViewController" bundle:nil];
    [self.navigationController pushViewController:g2V animated:YES];
    g2V.delegate=self;
    [g2V release];
    
}

-(void)requestData{
    aSIHTTPRequestUtils =[[ASIHTTPRequestUtils alloc] initWithHandleWithoutAutoRelease:self];
    NSString* subUrl=[[[NSString alloc] initWithString:@"/tm/ZSJFAction.do?method=showGCJGTJReport"] autorelease];
    NSMutableDictionary* requestData = [[NSMutableDictionary alloc] init];
    NSLog(@"Dictionary is : \n%@",_reqdic);
    [aSIHTTPRequestUtils requestData:subUrl data:_reqdic action:@selector(getList:) isShowProcessBar:YES];
    [requestData  release];
}

-(void)getList:(NSData*)jsonData{
    NSArray* kbArray = [DataProcess getArrayListFromNSData:jsonData];
    // Create the master list for the main view controller.
    NSMutableArray *tempMutableArray = [[NSMutableArray alloc] initWithCapacity:4];
    self.listContent = tempMutableArray;
    [tempMutableArray release];
    for (NSDictionary *kb in kbArray) {
        NSString *gcmc = [kb objectForKey:@"gcmc"];
        NSString *jgsj = [kb objectForKey:@"jgsjStr"];
        NSString *sqr = [kb objectForKey:@"sqr"];
        NSString *sqsj = [kb objectForKey:@"sqsjStr"];
        
      
        NSMutableDictionary *md=[[NSMutableDictionary alloc] init];
        [md setObject:gcmc forKey:@"gcmc"];
        [md setObject:jgsj forKey:@"jgsjStr"];
        [md setObject:sqr forKey:@"sqr"];
        [md setObject:sqsj forKey:@"sqsjStr"];
        [self.listContent addObject:md];
        
        [md release];
        
    }
    [self.tableView reloadData];
}

//告诉数据源返回的行数给定部分的表视图
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [self.listContent count];

}

//向数据源对Cell在特定位置插入的表视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //来创建对应SimpleTableIdentifier标识的UITableViewCell实例。
    static NSString *CellTableIndentifier = @"CellTableIndentifier";
    UINib *nib = [UINib nibWithNibName:@"GcjgtjCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIndentifier];
    GcjgtjCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
	
	/*
	 If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
	 */
	NSMutableDictionary *md =   md = [self.listContent objectAtIndex:indexPath.row];

    [cell.lblproName setText:[md objectForKey:@"gcmc"]];
    [cell.lblsqr setText:[md objectForKey:@"sqr"]];
    [cell.lblsqsj setText:  [md objectForKey:@"sqsjStr"]];
    [cell.lbljgsj setText:[md objectForKey:@"jgsjStr"]];
    cell.lblproName.lineBreakMode = UILineBreakModeWordWrap;
    cell.lblproName.numberOfLines = 0;
    
    cell.lblsqr.lineBreakMode = UILineBreakModeWordWrap;
    cell.lblsqr.numberOfLines = 0;
    
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  140;
}


//select告诉代表指定行现在是被选定的
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//	Product *product = nil;
//	if (tableView == self.searchDisplayController.searchResultsTableView)
//	{
//        product = [self.filteredListContent objectAtIndex:indexPath.row];
//    }
//	else
//	{
//        product = [self.listContent objectAtIndex:indexPath.row];
//    }
//    
//    KnowledgeChildViewController *g2V = [[KnowledgeChildViewController alloc] initWithNibName:@"KnowledgeChildViewController" bundle:nil];
//    self.knowledgeChildViewController = g2V;
//    g2V.title = product.name;
//    g2V.forumId = product.forumId;
//    [self.navigationController pushViewController:g2V animated:YES];
//    [g2V release];
    
    
}

-(void)passValue:(NSMutableDictionary *)passData{
    NSLog(@"ddddddd====>%@",passData);
    //传送的ID
    _reqdic=passData;
    [self requestData];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
