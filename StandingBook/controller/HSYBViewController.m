//
//  expandListViewController.m
//  expandList
//
//  Created by zhangxi on 12-3-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HSYBViewController.h"
#import "ReportTableViewController.h"
#import "HSYB4GJZB4QWViewController.h"
#import "HSYB4GJZB4PTW2GViewController.h"
#import "HSYB4GJZB4PTW3GViewController.h"
#import "HSYB4GJZB4OCS3GViewController.h"
#import "HSYB4GJZB4KDViewController.h"
#import "HSYB4GJZB4GHViewController.h"
#import "HSYB43GYWViewController.h"
#import "HSYB4KDYFZQKViewController.h"
#import "YB4SRHBViewController.h"
#import "YB4SRHB4ywViewController.h"
#import "YB4SRHB4wgViewController.h"
#import "YB4SRHB4qxViewController.h"

@implementation HSYBViewController



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
    self.title=@"月通报";
    
    data=[self getFuncTreeDic];
	
	/**创建demo数据
    data = [[NSMutableArray alloc]initWithCapacity : 2];
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
	[dict setObject:@"呼市关键指标月通报" forKey:@"groupname"];
	
	//利用数组来填充数据
	NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[arr addObject: @"全网"];
	[arr addObject: @"普通网2G"];
	[arr addObject: @"普通网3G"];
    [arr addObject: @"OCS3G"];
    [arr addObject: @"宽带"];
    [arr addObject: @"固话"];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[data addObject: dict];
	[dict release];
    
    
	dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
	[dict setObject:@"3G业务月报" forKey:@"groupname"];
	arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[arr addObject: @"3G业务月报"];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[data addObject: dict];
	[dict release];
    
    dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
	[dict setObject:@"网格月报" forKey:@"groupname"];
	arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[arr addObject: @"重点业务月报"];
    [arr addObject: @"宽带月发展情况"];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[data addObject: dict];
	[dict release];**/
    
    
    
    	
	
	//创建一个tableView视图
	//创建UITableView 并指定代理
	CGRect frame = [UIScreen mainScreen].applicationFrame;
	frame.origin.y = 0;
	tbView = [[UITableView alloc]initWithFrame: frame style:UITableViewStylePlain];
	[tbView setDelegate: self];
	[tbView setDataSource: self];
	[self.view addSubview: tbView];
	[tbView release];
	
	[tbView reloadData];
}


-(NSMutableArray*) getFuncTreeDic{
    NSMutableArray* tempArray =[DataProcess getSysUserExtendedMVO].arrFuncNodeTree;
    NSMutableArray *adata = [[NSMutableArray alloc]initWithCapacity : 2];
    
    for (int i=0; i<tempArray.count ;i++) {
        NSDictionary *treeDic=(NSDictionary*)tempArray[i];
        NSString* aparentNodeTreeId=[treeDic objectForKey:@"parentNodeTreeId"];
        NSString *nodeTreeName=[treeDic objectForKey:@"nodeTreeName"];
        
        if( [aparentNodeTreeId isEqualToString:@"10" ]){
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
    
    return [data count];
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
    eButton.font=[UIFont systemFontOfSize:18];
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
    if([reportName isEqualToString:@"全网"]){
        HSYB4GJZB4QWViewController *viewController = [[HSYB4GJZB4QWViewController alloc] initWithNibName:@"HSYB4GJZB4QWViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([reportName isEqualToString:@"普通网2G"]){
        HSYB4GJZB4PTW2GViewController *viewController = [[HSYB4GJZB4PTW2GViewController alloc] initWithNibName:@"HSYB4GJZB4PTW2GViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([reportName isEqualToString:@"普通网3G"]){
        HSYB4GJZB4PTW3GViewController *viewController = [[HSYB4GJZB4PTW3GViewController alloc] initWithNibName:@"HSYB4GJZB4PTW3GViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([reportName isEqualToString:@"OCS3G"]){
        HSYB4GJZB4OCS3GViewController *viewController = [[HSYB4GJZB4OCS3GViewController alloc] initWithNibName:@"HSYB4GJZB4OCS3GViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([reportName isEqualToString:@"宽带"]){
        HSYB4GJZB4KDViewController *viewController = [[HSYB4GJZB4KDViewController alloc] initWithNibName:@"HSYB4GJZB4KDViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([reportName isEqualToString:@"固话"]){
        HSYB4GJZB4GHViewController *viewController = [[HSYB4GJZB4GHViewController alloc] initWithNibName:@"HSYB4GJZB4GHViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([reportName isEqualToString:@"3G业务月报"]){
        HSYB43GYWViewController *viewController = [[HSYB43GYWViewController alloc] initWithNibName:@"HSYB43GYWViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([reportName isEqualToString:@"宽带月发展情况"]){
        HSYB4KDYFZQKViewController *viewController = [[HSYB4KDYFZQKViewController alloc] initWithNibName:@"HSYB4KDYFZQKViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    
    }else if([reportName isEqualToString:@"收入环比通报(按客户群)"]){
        YB4SRHBViewController *viewController = [[YB4SRHBViewController alloc] initWithNibName:@"YB4SRHBViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
        
    }else if([reportName isEqualToString:@"收入环比通报(按业务)"]){
        YB4SRHB4ywViewController *viewController = [[YB4SRHB4ywViewController alloc] initWithNibName:@"YB4SRHB4ywViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
        
    }else if([reportName isEqualToString:@"网格收入环比通报"]){
        YB4SRHB4wgViewController *viewController = [[YB4SRHB4wgViewController alloc] initWithNibName:@"YB4SRHB4wgViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
        
    }else if([reportName isEqualToString:@"旗县收入环比通报"]){
        YB4SRHB4qxViewController *viewController = [[YB4SRHB4qxViewController alloc] initWithNibName:@"YB4SRHB4qxViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
        
    }
    
}



@end
