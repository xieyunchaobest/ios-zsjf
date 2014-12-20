//
//  expandListViewController.m
//  expandList
//
//  Created by zhangxi on 12-3-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "dayReportViewController.h"
#import "ReportTableViewController.h"
#import "G2YWRBViewController.h"
#import "HSRB43GYWViewController.h"
#import "HSRB42GYWViewController.h"
#import "HSRB4KDYWViewController.h"
#import "HSRB42g3grhViewController.h"
#import "HSRB4zdywlzViewController.h"
#import "HSRB4khjllzlzViewController.h"
#import "JTRB4QSYWFZRB.h"
#import "JTRB4HYBYWFZRBViewController.h"
#import "QDRB4GWDYWFZRBViewController.h"
#import "JTRB4WGJLZDGZViewController.h"
#import "QDRB4QdwgzdywrbViewController.h"
#import "Xyrb4SqwgzdywViewController.h"

@implementation dayReportViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"日通报";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem.title=@"返回";
	
	//创建demo数据
    /**data = [[NSMutableArray alloc]initWithCapacity : 2];
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
	[dict setObject:@"呼市日报" forKey:@"groupname"];
	
	//利用数组来填充数据
	NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[arr addObject: @"重点业务发展日报"];
	[arr addObject: @"2G业务日报"];
	[arr addObject: @"3G业务日报"];
    [arr addObject: @"宽带业务日报"];
    [arr addObject: @"2G/3G融合业务日报"];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[data addObject: dict];
	[dict release];
    
    
	dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
	[dict setObject:@"网格日报" forKey:@"groupname"];
	arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[arr addObject: @"重点业务缆装日报"];
	[arr addObject: @"客户经理缆装日报"];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[data addObject: dict];
	[dict release];
    
    dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
	[dict setObject:@"集团日报" forKey:@"groupname"];
	arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[arr addObject: @"区级/市级业务发展日报"];
	[arr addObject: @"行业部业务发展日报"];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[data addObject: dict];
	[dict release];
	
	
	dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
	[dict setObject:@"渠道日报" forKey:@"groupname"];
	arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[arr addObject: @"各网点业务发展日报"];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[data addObject: dict];
	[dict release];**/
	
	
	//创建一个tableView视图
	//创建UITableView 并指定代理
	CGRect frame = [UIScreen mainScreen].applicationFrame;
    data=[self getFuncTreeDic:2];
    
	frame.origin.y = 0;
	tbView = [[UITableView alloc]initWithFrame: frame style:UITableViewStylePlain];
    if ([tbView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [tbView setSeparatorInset:UIEdgeInsetsZero];
    }
	[tbView setDelegate: self];
	[tbView setDataSource: self];
	[self.view addSubview: tbView];
	[tbView release];
	
	[tbView reloadData];
}



-(NSMutableArray*) getFuncTreeDic:(int) parentNodeTreeId{
    NSMutableArray* tempArray =[DataProcess getSysUserExtendedMVO].arrFuncNodeTree;
    NSMutableArray *adata = [[NSMutableArray alloc]initWithCapacity : 2];
    
    for (int i=0; i<tempArray.count ;i++) {
        NSDictionary *treeDic=(NSDictionary*)tempArray[i];
        NSString* aparentNodeTreeId=[treeDic objectForKey:@"parentNodeTreeId"];
        NSString *nodeTreeName=[treeDic objectForKey:@"nodeTreeName"];
        
        if( [aparentNodeTreeId isEqualToString:@"2" ]){
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
            [dict setObject:nodeTreeName forKey:@"groupname"];
            
            NSMutableArray *arr1=[treeDic objectForKey:@"userFuncNodeList"];
            
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity : 2];
            for (int j=0; j<arr1.count; j++) {
                NSDictionary* d=(NSDictionary*)arr1[j];
                NSString *nodeName=[d objectForKey:@"funcNodeName"];
                [arr addObject:nodeName];
            }
            if(arr.count>0){
                [dict setObject:arr forKey:@"users"];
                [adata addObject:dict];
            }
            [dict release];
        }
    }
    
    return adata;
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[data release];
    [super dealloc];
}



#pragma mark -
#pragma mark Table view data source


//对指定的节进行“展开/折叠”操作
-(void)collapseOrExpand:(int)section{
	Boolean expanded = NO;
	//Boolean searched = NO;
	NSMutableDictionary* d=[data objectAtIndex:section];
	
	//若本节model中的“expanded”属性不为空，则取出来
	if([d objectForKey:@"expanded"]!=nil)
		expanded=[[d objectForKey:@"expanded"]intValue];
	
	//若原来是折叠的则展开，若原来是展开的则折叠
	[d setObject:[NSNumber numberWithBool:!expanded] forKey:@"expanded"];

}


//返回指定节的“expanded”值
-(Boolean)isExpanded:(int)section{
	Boolean expanded = NO;
	NSMutableDictionary* d=[data objectAtIndex:section];
	
	//若本节model中的“expanded”属性不为空，则取出来
	if([d objectForKey:@"expanded"]!=nil)
		expanded=[[d objectForKey:@"expanded"]intValue];
	
	return expanded;
}


//按钮被点击时触发
-(void)expandButtonClicked:(id)sender{
	
	UIButton* btn= (UIButton*)sender;
	int section= btn.tag; //取得tag知道点击对应哪个块
	
	//	NSLog(@"click %d", section);
	[self collapseOrExpand:section];
	
	//刷新tableview
	[tbView reloadData];
	
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    int count=[data count];
    return count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	
	//对指定节进行“展开”判断
	if (![self isExpanded:section]) {
		
		//若本节是“折叠”的，其行数返回为0
		return 0;
	}
	
	NSDictionary* d=[data objectAtIndex:section];
	return [[d objectForKey:@"users"] count];
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    

	NSDictionary* m= (NSDictionary*)[data objectAtIndex: indexPath.section];
	NSArray *d = (NSArray*)[m objectForKey:@"users"];
		
	if (d == nil) {
		return cell;
	}
	
	//显示联系人名称
    
	cell.textLabel.text = [d objectAtIndex: indexPath.row];

	cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font=[UIFont systemFontOfSize:16];
	
	//UIColor *newColor = [[UIColor alloc] initWithRed:(float) green:(float) blue:(float) alpha:(float)];
	cell.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_listbg.png"]];
	//cell.imageView.image = [UIImage imageNamed:@"mod_user.png"];

	
	//选中行时灰色
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	[cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}



// 设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

	return 40;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   
{
	
		
	UIView *hView;
	if (UIInterfaceOrientationLandscapeRight == [[UIDevice currentDevice] orientation] ||
			UIInterfaceOrientationLandscapeLeft == [[UIDevice currentDevice] orientation])
	{
		hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 40)];
	}
	else
	{
		hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
			//self.tableView.tableHeaderView.frame = CGRectMake(0.f, 0.f, 320.f, 44.f);
	}
		//UIView *hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
		
	UIButton* eButton = [[UIButton alloc] init];
		
	//按钮填充整个视图
	eButton.frame = hView.frame;
	[eButton addTarget:self action:@selector(expandButtonClicked:)
	forControlEvents:UIControlEventTouchUpInside];
	eButton.tag = section;//把节号保存到按钮tag，以便传递到expandButtonClicked方法
		
	//根据是否展开，切换按钮显示图片
	if ([self isExpanded:section]) 
		[eButton setImage: [ UIImage imageNamed: @"btn_down.png" ] forState:UIControlStateNormal];
	else
		[eButton setImage: [ UIImage imageNamed: @"btn_right.png" ] forState:UIControlStateNormal];
		
		
	//由于按钮的标题，
	//4个参数是上边界，左边界，下边界，右边界。
	eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; 
	[eButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 0)]; 
	[eButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
		 
		
	//设置按钮显示颜色
	eButton.backgroundColor = [UIColor lightGrayColor];
	[eButton setTitle:[[data objectAtIndex:section] objectForKey:@"groupname"] forState:UIControlStateNormal];
    eButton.font=[UIFont systemFontOfSize:18];
	[eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		//[eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	
	[eButton setBackgroundImage: [ UIImage imageNamed: @"btn_listbg.png" ] forState:UIControlStateNormal];//btn_line.png"
	//[eButton setTitleShadowColor:[UIColor colorWithWhite:0.1 alpha:1] forState:UIControlStateNormal];
	//[eButton.titleLabel setShadowOffset:CGSizeMake(1, 1)];
		
	[hView addSubview: eButton];
		
	[eButton release];
	return hView;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.section=%d",indexPath.section);
    NSDictionary* m= (NSDictionary*)[data objectAtIndex: indexPath.section];
	NSArray *d = (NSArray*)[m objectForKey:@"users"];
 
	
	//显示联系人名称
    
	NSString* reportName=[d objectAtIndex: indexPath.row];
    NSLog(@"assssssssssssss%@",reportName);
//    if([reportName isEqualToString:@"重点业务发展日报"]){        
//        JTRB4WGJLZDGZViewController *viewController = [[JTRB4WGJLZDGZViewController alloc] initWithNibName:@"JTRB4WGJLZDGZViewController" bundle:nil];
//        [self.navigationController pushViewController:viewController animated:YES];
//        [viewController release];    
//    }else
    
    if([reportName isEqualToString:@"重点业务发展日报 "]){
        ReportTableViewController *viewController = [[ReportTableViewController alloc] initWithNibName:@"ReportTableViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([reportName isEqualToString:@"2G业务日报"]){
        HSRB42GYWViewController *g2ywrbview= [[HSRB42GYWViewController alloc] initWithNibName:@"HSRB42GYWViewController" bundle:nil];
        [self.navigationController pushViewController:g2ywrbview animated:YES];
        [g2ywrbview release];
    }else if([reportName isEqualToString:@"3G业务日报"]){
        HSRB43GYWViewController *g3ywrbview= [[HSRB43GYWViewController alloc] initWithNibName:@"HSRB43GYWViewController" bundle:nil];
        [self.navigationController pushViewController:g3ywrbview animated:YES];
        [g3ywrbview release];
    }else if([reportName isEqualToString:@"宽带业务日报"]){
        HSRB4KDYWViewController *kdywrbview= [[HSRB4KDYWViewController alloc] initWithNibName:@"HSRB4KDYWViewController" bundle:nil];
        [self.navigationController pushViewController:kdywrbview animated:YES];
        [kdywrbview release];
    }else if([reportName isEqualToString:@"2G3G融合业务日报"]){
        HSRB42g3grhViewController *g2g3ywrbview= [[HSRB42g3grhViewController alloc] initWithNibName:@"HSRB42g3grhViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }else if(([reportName isEqualToString:@"网格重点业务日报"])){
        HSRB4zdywlzViewController *g2g3ywrbview= [[HSRB4zdywlzViewController alloc] initWithNibName:@"HSRB4zdywlzViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }else if((([reportName isEqualToString:@"客户经理揽装日报"]))){
        HSRB4khjllzlzViewController *g2g3ywrbview= [[HSRB4khjllzlzViewController alloc] initWithNibName:@"HSRB4khjllzlzViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    
    }else if((([reportName isEqualToString:@"区级、市级业务发展日报"]))){
        JTRB4QSYWFZRB *g2g3ywrbview= [[JTRB4QSYWFZRB alloc] initWithNibName:@"JTRB4QSYWFZRB" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    
    }else if([reportName isEqualToString:@"行业部业务发展日报"]){
        JTRB4HYBYWFZRBViewController *g2g3ywrbview= [[JTRB4HYBYWFZRBViewController alloc] initWithNibName:@"JTRB4HYBYWFZRBViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }else if([reportName isEqualToString:@"各网点业务发展日报"]){
        QDRB4GWDYWFZRBViewController *g2g3ywrbview= [[QDRB4GWDYWFZRBViewController alloc] initWithNibName:@"QDRB4GWDYWFZRBViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }else if([reportName isEqualToString:@"渠道网格重点业务日报"]){
        QDRB4QdwgzdywrbViewController *g2g3ywrbview= [[QDRB4QdwgzdywrbViewController alloc] initWithNibName:@"QDRB4QdwgzdywrbViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }else if([reportName isEqualToString:@"商企网格重点业务日报"]){
        Xyrb4SqwgzdywViewController *g2g3ywrbview= [[Xyrb4SqwgzdywViewController alloc] initWithNibName:@"Xyrb4SqwgzdywViewController" bundle:nil];
        [self.navigationController pushViewController:g2g3ywrbview animated:YES];
        [g2g3ywrbview release];
    }

}



@end
