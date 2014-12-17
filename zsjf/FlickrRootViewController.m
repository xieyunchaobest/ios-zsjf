//
//  SDWebImageRootViewController.m
//  Sample
//  照片标签页面
//  Created by Kirby Turner on 3/18/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "FlickrRootViewController.h"
#import "FlickrDataSource.h"


@implementation FlickrRootViewController
@synthesize navigationController;
- (void)dealloc {
    [images_ release], images_ = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

-(void)initImage{
    images_ = [[FlickrDataSource alloc] init];
    [self setDataSource:images_];

}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
