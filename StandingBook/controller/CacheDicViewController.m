//
//  CacheDicViewController.m
//  mos
//
//  Created by Mos on 13-8-22.
//  Copyright (c) 2013年 Cattsoft. All rights reserved.
//

#import "CacheDicViewController.h"

@interface CacheDicViewController ()

@end

@implementation CacheDicViewController
@synthesize dataArray;
@synthesize tag;
@synthesize aSIHTTPRequestUtils;

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
    // Do any additional setup after loading the view from its nib.
    aSIHTTPRequestUtils = [[ASIHTTPRequestUtils alloc] initWithHandle:self];
    if(tag == 1024){
        NSString* subUrl=[[[NSString alloc] initWithString:@"loginAction.do?method=findStaff4MOS"] autorelease];
        
        NSLog(@"Dictionary is : \n%@",self.requestDicData);
        
        [aSIHTTPRequestUtils requestData:subUrl data:self.requestDicData action:@selector(returnOK:) isShowProcessBar:YES];
    }else if(tag==1023){
        NSString* subUrl=[[[NSString alloc] initWithString:@"loginAction.do?method=getWorkAreaStaff4MOS"] autorelease];
        
        NSLog(@"Dictionary is : \n%@",self.requestDicData);
        
        [aSIHTTPRequestUtils requestData:subUrl data:self.requestDicData action:@selector(getWorkAreaResult:) isShowProcessBar:YES];
    }
}

-(void)getWorkAreaResult:(NSData*)jsonData{
    NSArray* retunArray = [DataProcess getArrayListFromNSData:jsonData];
    NSLog(@"retunArray====>%@",retunArray);
    self.dataArray = [[retunArray mutableCopy] objectAtIndex:0];
    [self.tableView reloadData];

}

-(void)returnOK:(NSData*)jsonData{
    NSArray* retunArray = [DataProcess getArrayListFromNSData:jsonData];
    self.title = @"施工人员";
    self.dataArray = [retunArray mutableCopy];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
//    NSLog(@"indexPath.row---->%i",indexPath.row);

    NSDictionary* dic = [self.dataArray objectAtIndex:indexPath.row];
    if (self.tag==1023) {

        cell.textLabel.text = [dic objectForKey:@"workareaName"];
    }else
        cell.textLabel.text = [dic objectForKey:@"label"]; 
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSDictionary *tempDic = [dataArray objectAtIndex:indexPath.row];
    //通过委托协议传值
    [self.delegate passValue:tempDic];
    
    [self.navigationController popViewControllerAnimated:true];
}

- (void)dealloc{
    [dataArray release];
    [super dealloc];
}
- (void)viewDidUnload{
    [self setDataArray:nil];
    [super viewDidUnload];
}

@end
