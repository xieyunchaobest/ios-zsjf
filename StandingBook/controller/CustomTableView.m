//
//  CustomTableView.m
//  Custom
//
//  Created by tan on 13-1-22.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "CustomTableView.h"

@implementation CustomTableView

@synthesize leftScrollView = _leftScrollView;
@synthesize leftTableView = _leftTableView;
@synthesize rightScrollView = _rightScrollView;
@synthesize rightTableView = _rightTableView;
@synthesize dataArray = _dataArray;
@synthesize trDictionary = _trDictionary;
@synthesize leftDataKeys = _leftDataKeys;
@synthesize rightDataKeys = _rightDataKeys;

- (id)initWithData:(NSArray *)dArray trDictionary:(NSDictionary *)trDict size:(CGSize)size scrollMethod:(ScrollMethod)sm leftDataKeys:(NSArray *)leftDataKeys rightDataKeys:(NSArray *)rightDataKeys {
    if (self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)]) {
        //data
        self.dataArray = [NSArray arrayWithArray:dArray];
        self.trDictionary = [NSDictionary dictionaryWithDictionary:trDict];
        self.leftDataKeys = [NSArray arrayWithArray:leftDataKeys];
        self.rightDataKeys = [NSArray arrayWithArray:rightDataKeys];
        
        float leftWidth = 0;//左边tableview的宽度
        float rightWidth = 0;//右边tableview的宽度
        for (NSString *trKey in _leftDataKeys) {
            float trWidth = [[trDict objectForKey:trKey] floatValue];
            leftWidth += trWidth;
        }
        for (NSString *trKey in _rightDataKeys) {
            float trWidth = [[trDict objectForKey:trKey] floatValue];
            rightWidth += trWidth;
        }
        
        //scrollview
        float leftScrollWidth = 0;
        float rightScrollWidth = 0;
        @try {
            if (sm == kScrollMethodWithLeft) {
                if (rightWidth > size.width) {
                    @throw [NSException exceptionWithName:@"width small" reason:@"" userInfo:nil];
                }
                rightScrollWidth = rightWidth;
                leftScrollWidth = size.width - rightScrollWidth;
            } else if (sm == kScrollMethodWithRight) {
                if (leftWidth > size.width) {
                    @throw [NSException exceptionWithName:@"width small" reason:@"" userInfo:nil];
                }
                leftScrollWidth = leftWidth;
                rightScrollWidth = size.width - leftScrollWidth;
            } else {
                leftScrollWidth = rightScrollWidth = size.width / 2.0 ;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"ERROR:%@", exception.name);
            NSAssert(false, @"width small");
        }
    
        UIScrollView *leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, leftScrollWidth, size.height)];
        [leftScrollView setShowsHorizontalScrollIndicator:FALSE];
        [leftScrollView setShowsVerticalScrollIndicator:FALSE];
        self.leftScrollView = leftScrollView;
        [leftScrollView release];
        
        UIScrollView *rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(leftScrollWidth, 0, rightScrollWidth, size.height)];
        [rightScrollView setShowsHorizontalScrollIndicator:FALSE];
        [rightScrollView setShowsVerticalScrollIndicator:FALSE];
        self.rightScrollView = rightScrollView;
        [rightScrollView release];
        
        //tableView
        UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, size.height-40)];
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        if ([leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [leftTableView setSeparatorInset:UIEdgeInsetsZero];   
        }
        [leftTableView setShowsHorizontalScrollIndicator:NO];
        [leftTableView setShowsVerticalScrollIndicator:NO];
        self.leftTableView = leftTableView;
        
        [leftTableView release];
        
        UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rightWidth, size.height-40)];
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        [rightTableView setShowsHorizontalScrollIndicator:NO];
        [rightTableView setShowsVerticalScrollIndicator:NO];
        if ([rightTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [rightTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        self.rightTableView = rightTableView;
        [rightTableView release];
        
        [self.leftScrollView addSubview:_leftTableView];
        [self.rightScrollView addSubview:_rightTableView];
        [self.leftScrollView setContentSize:_leftTableView.frame.size];
        [self.rightScrollView setContentSize:_rightTableView.frame.size];
        
        [self addSubview:_leftScrollView];
        [self addSubview:_rightScrollView];
    }
    return self;
}

- (void)dealloc {
    [_leftTableView release];
    [_leftScrollView release];
    [_rightTableView release];
    [_rightScrollView release];
    [_dataArray release];
    [_trDictionary release];
    [_leftDataKeys release];
    [_rightDataKeys release];
    [super dealloc];
}

#pragma mark - Custom TableView Content

- (UIView *)viewWithLeftContent:(NSInteger)index {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, _leftTableView.frame.size.width, kTableViewCellHeight)] autorelease];
    NSDictionary *rowDict = [_dataArray objectAtIndex:index];
    @try {
        float x=0;
        for (NSString *key in _leftDataKeys) {
            float width = [[_trDictionary objectForKey:key] floatValue];
            NSString *value = [rowDict objectForKey:key];
            
// TODO: 初始化内部label 可以自定义
            //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width, kTableViewCellHeight)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width, kTableViewCellHeight)];
            label.contentMode = UIViewContentModeCenter;
            label.textAlignment = NSTextAlignmentCenter;
            label.lineBreakMode = UILineBreakModeWordWrap;
            label.numberOfLines = 0;
            label.text = value;
            
            
            // label.text = @"mmmmmm";
            label.textAlignment = UITextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:13.0];
            [view addSubview:label];
            [label release];
            
            x += width;
        }
    }
    @catch (NSException *exception) {
        
    }
    return view;
}

- (UIView *)viewWithRightContent:(NSInteger)index {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, _rightTableView.frame.size.width, kTableViewCellHeight)] autorelease];
    NSDictionary *rowDict = [_dataArray objectAtIndex:index];
    @try {
        float x=0;
        float n=0;
        for (NSString *key in _rightDataKeys) {
            float width = [[_trDictionary objectForKey:key] floatValue];
            id aid = [rowDict objectForKey:key];
            NSString *value=@"";
            if([aid isKindOfClass:[NSNumber class]]){
                NSNumber *anb=(NSNumber*)aid;
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                value=[numberFormatter stringFromNumber:anb];
            }else if([aid isKindOfClass:[NSString class]]){
                value=(NSString*)aid;
            }
            
// TODO: 初始化内部label 可以自定义
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width, kTableViewCellHeight)];
            label.contentMode = UIViewContentModeCenter;
            label.textAlignment = NSTextAlignmentCenter;
            
            label.text = value;
            //label.text = @"nnn";
            if (n==_rightDataKeys.count-1) {
                if([self isNumber:value]){
                    if ([value intValue]>=0) {
                        //label.textColor=[UIColor greenColor];
                    }else{
                        label.textColor=[UIColor redColor];
                    }
                }
            }
            
            label.font = [UIFont systemFontOfSize:13.0];
            label.lineBreakMode = UILineBreakModeWordWrap;
            label.numberOfLines = 0;
            [view addSubview:label];
            [label release];
            
            x += width;
            n++;
        }
    }
    @catch (NSException *exception) {
        
    }
    return view;
}

#pragma mark - TableView DataSource Methods

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
    }
    UIView *view;
    if ([tableView isEqual:_leftTableView]) {
        view = [self viewWithLeftContent:indexPath.row];
    } else {
        view = [self viewWithRightContent:indexPath.row];
    }
    
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    
    [cell.contentView addSubview:view];
    CGRect frame = cell.frame;
    frame.size = view.frame.size;
    cell.frame = frame;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

#pragma mark - TableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_leftTableView]) {
        [self.rightTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    } else {
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - ScrollView Delegate 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_leftTableView]) {
        self.rightTableView.contentOffset = _leftTableView.contentOffset;
    } else {
        self.leftTableView.contentOffset = _rightTableView.contentOffset;
    }
}

-(BOOL)isNumber:(NSString *)string{
    return ([self isPureInt:string] || [self isPureFloat:string]);
    
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
@end
